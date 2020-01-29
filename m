Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93918C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB2D20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdY+xGBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB2D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmyF-0007KJ-HS
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iwmxW-0006mR-VJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iwmxR-0000lE-Q2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:00:42 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iwmxR-0000hs-Hr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:00:37 -0500
Received: by mail-lf1-x142.google.com with SMTP id 9so11801625lfq.10
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NBvLAC906/+xeKraub2KwjpTFVIotFcTTE5aZ6YjSDk=;
 b=hdY+xGBLG9ZTyzc5LdtqgJdMUA2cfa90LJ4tmCPP8SZ6/CaAc9MxA+8fGJOxEea2wb
 X2RhwsNgYsAtY/TTijOBFq5eEpRz5uO9RAQ47lz4t97fKQ07rqyRiyZMQwAmjKLvu5vn
 elCSbHD45/bbsevX7J7lAcRo2OG2dfHApSoRr5dy4y0XfFUmm2b1GNKwgCNjsoO2sK4t
 /t3GZYZaf9WCecaYXktbOcm95nd3kRENsbmxpfGXBQO5aMseHEiKytWgiycYw0tcANzk
 O0/SLD1D5g71u7G9vq0eBjyaDfVsB+95xjHHgpXAtBN1M563RF7ItXOVhp+xSAzijhzq
 0pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NBvLAC906/+xeKraub2KwjpTFVIotFcTTE5aZ6YjSDk=;
 b=jRBw1kZW9EeuY0v7XI+aac1v36WBpbBYbm0zUQGTdXvAUxs+Wwnpfqf2FqOd7fI0VD
 gVcni7q3exU1VKYrRKPpC5nov1fTRuPpPhO07BbUq9O5j9RgMmS3GDDis9KYFBaSTf85
 6ED+Ziel0duw2qpj3Ig9YAOGOy5z7w1+L+PpGh2eDdIrig7KPD+VmZ5Zh9h7D47WRjyg
 q0WxMJ1MKyq83JjFTii0l8F4DZfNePRSES8KBJdUmuV5UkNmHV32pQQT9lvCJ8MJC1LS
 S9xOBpMafSNQ1f/r5Z5iAjKei5FKOQ8D7Zv7Qjc+02bYMfQrrPTgPBSIwpdqIc641FxO
 /TDw==
X-Gm-Message-State: APjAAAW2HMpf8xYB2mCgabkkFn+2T8vwwtPcbLjKQU3umfMuL2B6GgxK
 vfJFo/Hu3JardTBayE0Q7qOmjCKj/JPMJxqugvU28w==
X-Google-Smtp-Source: APXvYqztw2dI0XtrfeizLN4VpMtNlzKXfdykO+gLh2ORzVElSBF6+8XX14pYnN9GVKRv52w/qGDYbq+wmgNUycqDBV8=
X-Received: by 2002:ac2:53b9:: with SMTP id j25mr5363412lfh.140.1580302835297; 
 Wed, 29 Jan 2020 05:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <87wo9beaer.fsf@linaro.org>
In-Reply-To: <87wo9beaer.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 29 Jan 2020 07:59:59 -0500
Message-ID: <CAEyhzFsKxd0rBFYLHcpHS5fJg4=BnDP8VM8Y_kfoP7kJKgLi0Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] tests/vm: Add support for aarch64 VMs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the details on the failure.   I have not been able to
reproduce it yet, but digging into it further.

On Tue, 28 Jan 2020 at 12:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This patch adds support for 2 aarch64 VMs.
> >  - Ubuntu 18.04 aarch64 VM
> >  - CentOS 8 aarch64 VM
> <snip>
>
> Another failure to note - under TCG:
>
>   make vm-build-ubuntu.aarch64 V=3D1 QEMU=3Daarch64-softmmu/qemu-system-a=
arch64
>
> Gives:
>
> Not run: 172 186 192 220
> Failures: 001 002 003 004 005 007 008 009 010 011 012 013 017 018 019 020=
 021 022 024 025 027 029 031 032 033 034 035 036 037 038 039 042 043 046 04=
7 048 049 050 052 053 054 060 061 062 063 066 069 071 072 073 074 079 080 0=
86 089 090 097 098 099 103 104 105 107 108 110 111 114 117 120 126 133 134 =
137 138 140 141 143 150 154 156 158 159 161 170
> 174 176 177 179 184 187 190 191 195 214 217 226 229 244 249 251 252 265 2=
67 268
> Failed 104 of 104 iotests
> /tmp/tmp.EjcqWtvHwd/tests/Makefile.include:840: recipe for target 'check-=
tests/check-block.sh' failed
> make: *** [check-tests/check-block.sh] Error 1
> rm tests/qemu-iotests/socket_scm_helper.o
> Connection to 127.0.0.1 closed.
> DEBUG:QMP:>>> {'execute': 'quit'}
> DEBUG:QMP:<<< {'timestamp': {'seconds': 1580134315, 'microseconds': 21629=
7}, 'event': 'NIC_RX_FILTER_CHANGED', 'data': {'path': '/machine/peripheral=
-anon/device[0]/virtio-backend'}}
> DEBUG:QMP:<<< {'return': {}}
> /home/alex.bennee/lsrc/qemu.git/tests/vm/Makefile.include:63: recipe for =
target 'vm-build-ubuntu.aarch64' failed
> make: *** [vm-build-ubuntu.aarch64] Error 3
>
> With things like:
>
> --- /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/063.out      2020-01-27 10:54:=
38.000000000 +0000
> +++ /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/063.out.bad  2020-01-28 01:20:=
28.563789323 +0000
> @@ -1,3 +1,4 @@
> +bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)
>  QA output created by 063
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4194304
>  =3D=3D Testing conversion with -n fails with no target file =3D=3D
>   TEST    iotest-qcow2: 066 [fail]
> QEMU          -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../aarch64-so=
ftmmu/qemu-system-aarch64" -nodefaults -display none -machine virt -accel q=
test
> QEMU_IMG      -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../qemu-io"  =
--cache writeback -f qcow2
> QEMU_NBD      -- "/tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/aarch64 ubuntu-guest 4.15.0-74-generic
> TEST_DIR      -- /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.BJ9gTNMmv1
> SOCKET_SCM_HELPER -- /tmp/tmp.EjcqWtvHwd/tests/qemu-iotests/socket_scm_he=
lper
>
> So I suspect a locale issue is breaking things.
>
> --
> Alex Benn=C3=A9e

