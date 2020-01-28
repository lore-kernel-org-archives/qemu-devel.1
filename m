Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB9A2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbRoRl6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB9A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV5m-0008Ep-8C
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iwV2C-0002kQ-Fb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iwV2A-0004LW-RB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:20 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iwV2A-0004G7-GN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:52:18 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so17082344wrm.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2Ciy74Td3c0M3xkpx4M6ryfo3B5sVwPaaOSPyyL3Q5Y=;
 b=fbRoRl6suBTRsKqVJNzxubaw48b1j05gE55W1bXhps9/eXtINLRm3gV/OK9ZLLmMMb
 XSyDyfDqlRPh8jozPnt+q8QlUXrfuk5WjQggGwM8KM2KETRTHpTGI7S6cHFbHvXolEtY
 Gj8WgpPhugwXvnmMI0HbS+a6/lo9QE/R/UZcgqvwip1eMNeH46uag0B2Y3vc67TzjQMz
 MOwHcmMelmB/WiHtD2d92Yvj7pBXC8P79+6vajrGoWXHAprqQrz2140PmrLpVOV1Ppfg
 FrDpwnE9pITzow/2mztb8JU/TJMm69HvSICcijzVfjn3M/h3+gXIAbOTb5Z3X16gkrIe
 gk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2Ciy74Td3c0M3xkpx4M6ryfo3B5sVwPaaOSPyyL3Q5Y=;
 b=Jce+ohdN5ySEiDi5/5lxU9KEMRP9+4+eLO4Q42Kph31fPL8ek8SWisrEqZH6jZ0ptd
 WCgxAHRSWsKAHoVW6IujNacfwnGA65mqFViPUCUW28vcdDtUzCsDDxeYyoWVpeIhzIQ3
 9ueh8pksr3TM3xx3Cl5d9P4mzPL5JjuHRGdjSZi4caRBozuIEz4NmzIXHVDVKdA/SnSb
 tKaNmRHJEdePM2WQp6dKjSKqhdUzyvW3pBRbZx7b2104ctPBJFSlJqzHwpcnwV6EZcze
 fivixnl3usAL6/NcILysN6g0x0UtE8PASWLGTPDE2Hsq5dk8YgCxopz9h2FECgmEsc+P
 vmkQ==
X-Gm-Message-State: APjAAAX1p3hCmrWHi4Ei5UVAE97oKAff4TQ3hTKJ+AxeNBmIjzctebbx
 WvLnRum2GJUT8RZZ3n1PcUD3jA==
X-Google-Smtp-Source: APXvYqxwM/oX4e9CfI6AxEX7pH2GHY0VhGVjkrTeEq4YUiK6hNjfXxkjn/xhez7prbLVvsgud5OBPg==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr1928402wrw.347.1580233934063; 
 Tue, 28 Jan 2020 09:52:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s65sm4093946wmf.48.2020.01.28.09.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:52:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39D151FF87;
 Tue, 28 Jan 2020 17:52:12 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 0/8] tests/vm: Add support for aarch64 VMs
In-reply-to: <20200124165335.422-1-robert.foley@linaro.org>
Date: Tue, 28 Jan 2020 17:52:12 +0000
Message-ID: <87wo9beaer.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This patch adds support for 2 aarch64 VMs.=20=20
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM
<snip>

Another failure to note - under TCG:

  make vm-build-ubuntu.aarch64 V=3D1 QEMU=3Daarch64-softmmu/qemu-system-aar=
ch64

Gives:

Not run: 172 186 192 220
Failures: 001 002 003 004 005 007 008 009 010 011 012 013 017 018 019 020 0=
21 022 024 025 027 029 031 032 033 034 035 036 037 038 039 042 043 046 047 =
048 049 050 052 053 054 060 061 062 063 066 069 071 072 073 074 079 080 086=
 089 090 097 098 099 103 104 105 107 108 110 111 114 117 120 126 133 134 13=
7 138 140 141 143 150 154 156 158 159 161 170
174 176 177 179 184 187 190 191 195 214 217 226 229 244 249 251 252 265 267=
 268
Failed 104 of 104 iotests
/tmp/tmp.EjcqWtvHwd/tests/Makefile.include:840: recipe for target 'check-te=
sts/check-block.sh' failed
make: *** [check-tests/check-block.sh] Error 1
rm tests/qemu-iotests/socket_scm_helper.o
Connection to 127.0.0.1 closed.
DEBUG:QMP:>>> {'execute': 'quit'}
DEBUG:QMP:<<< {'timestamp': {'seconds': 1580134315, 'microseconds': 216297}=
, 'event': 'NIC_RX_FILTER_CHANGED', 'data': {'path': '/machine/peripheral-a=
non/device[0]/virtio-backend'}}
DEBUG:QMP:<<< {'return': {}}
/home/alex.bennee/lsrc/qemu.git/tests/vm/Makefile.include:63: recipe for ta=
rget 'vm-build-ubuntu.aarch64' failed
make: *** [vm-build-ubuntu.aarch64] Error 3

With things like:

--- /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/063.out      2020-01-27 10:54:38=
.000000000 +0000
+++ /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/063.out.bad  2020-01-28 01:20:28=
.563789323 +0000
@@ -1,3 +1,4 @@
+bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)
 QA output created by 063
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4194304
 =3D=3D Testing conversion with -n fails with no target file =3D=3D
  TEST    iotest-qcow2: 066 [fail]
QEMU          -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../aarch64-soft=
mmu/qemu-system-aarch64" -nodefaults -display none -machine virt -accel qte=
st
QEMU_IMG      -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../qemu-img"
QEMU_IO       -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../qemu-io"  --=
cache writeback -f qcow2
QEMU_NBD      -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/aarch64 ubuntu-guest 4.15.0-74-generic
TEST_DIR      -- /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.BJ9gTNMmv1
SOCKET_SCM_HELPER -- /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/socket_scm_help=
er

So I suspect a locale issue is breaking things.

--=20
Alex Benn=C3=A9e

