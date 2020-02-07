Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A76C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EFB20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8F8pP98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EFB20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Bs-0006Yl-1F
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j02B9-00066y-2g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j02B7-0004a0-EX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:52:10 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:38042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j02B7-0004Yv-8O
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:52:09 -0500
Received: by mail-ot1-x329.google.com with SMTP id z9so1889490oth.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g1orxJDA1aZ6mK5gip746HiaJQGij6kSxFTvD270u2Q=;
 b=V8F8pP98tyvg1JXsKx/6L6O7Z4rscuW/uMDVwbaNXON89EmFCGjsK6O22Q8ppuzx7n
 HQhcbCFh7tXyLoo8teWXLCKXvhiM828q4sb+q8Q71O0c065rLwwuYDrUHgo4R926OQiC
 RxH1yZJA0DUfsU2cvYBnTNf2DlimR5oi6KtuaO/mH1ZaT/j0e4NO918ufpOCmIbl+eFj
 5OK7sutfEYhRLLKTOM4/yfDgNLsaIDhjx00Zx+wTdygQqI4RDfq9stQXcGq0ZWwhrR4Z
 7Omvv94x+uL8ih8n8jy4MKBRaSdOVgccf0l1eKabJSyFafRko3ine4Aw/bsEQWZLApVX
 zSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g1orxJDA1aZ6mK5gip746HiaJQGij6kSxFTvD270u2Q=;
 b=HDyV2TorpWKM+muVu5ZOCFXUIYjoIWPJw92mG4DpQa9LB0y5kFEgkGNmiPhBVjbef3
 EDwE7VL5/6XGmCL7Q3kVfMV6BlipYUCRqSTCeb5OE/9+TeyHQpgxpg25pNGJv5K2bB7s
 /IWTl7jkuDc/6urH/xA/ND9DlOmakOwLI9VNW/hr3E33zTDBqxJUswOXpRpVQpc+UaeJ
 cb5xnCY8AdF6FvbI+qYOzdYQX3F/1VthgO5ra6kBENDOz9LYnnIdH0OM3nFuh24WU+9x
 nPjzX7pjFHDRYisxYxnSn/IbPE9l5YEMf2jZIbB5S73JQgHcOnettw7cUaMj6W/Dgv0V
 55Dg==
X-Gm-Message-State: APjAAAVh8dYEQghwxc5kDkLTlW3TTTzzbqx3QtUeLBzXMgl5SlpBQXac
 saAxazpQT6dKv7eZG27VU1muD633yhm9we5OLy7WZQ==
X-Google-Smtp-Source: APXvYqxa9cZVOuf2jRXuUnFI4hYniPOMFDwLaE6ENl+JG4qPE5DmExmJiWtkJtNqrFD+bR0GTPxAereWQUnyt6K9ejM=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr2402386otq.135.1581076327955; 
 Fri, 07 Feb 2020 03:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20200206211936.17098-1-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 11:51:57 +0000
Message-ID: <CAFEAcA_bHE1s5q4bUrna0ph4Zw4m0VynjTcRo9GPjZDThqHZZQ@mail.gmail.com>
Subject: Re: [PULL 00/46] Python queue 2020-02-06
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 21:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> I prepared this series on behalf of Eduardo and
> Cleber (one of them will ack this cover).
>
> Regards,
>
> Phil.
>
> The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d761=
1c:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040220-=
1' into staging (2020-02-04 18:55:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/python-next-20200206
>
> for you to fetch changes up to 3e3481a5df933a26b47f08e5913821672d28d308:
>
>   .readthedocs.yml: specify some minimum python requirements (2020-02-06 =
21:48:24 +0100)

Hi; this fails 'make check' (all hosts):

  TEST    iotest-qcow2: 252
  TEST    iotest-qcow2: 256
  TEST    iotest-qcow2: 265
  TEST    iotest-qcow2: 267
  TEST    iotest-qcow2: 268
  TEST    iotest-qcow2: 283 [fail]
QEMU          --
"/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../../x=
86_64-softmmu/qemu-system-x86_64"
-nodefaults -display none -accel qtest
QEMU_IMG      --
"/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../../q=
emu-img"
QEMU_IO       --
"/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../../q=
emu-io"
 --cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../../q=
emu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 e104462 4.15.0-74-generic
TEST_DIR      --
/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.oppAzNNHIY
SOCKET_SCM_HELPER --
/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/socket_s=
cm_helper

--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/283.out
 2020-02-06 18:59:06.291529139 +0000
+++ /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/283.=
out.bad
     2020-02-07 11:25:38.477373907 +0000
@@ -1,8 +1 @@
-{"execute": "blockdev-add", "arguments": {"driver": "null-co",
"node-name": "target"}}
-{"return": {}}
-{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
"image": {"driver": "null-co", "node-name": "base", "size": 1048576},
"node-name": "source"}}
-{"return": {}}
-{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
"image": "base", "node-name": "other", "take-child-perms": ["write"]}}
-{"return": {}}
-{"execute": "blockdev-backup", "arguments": {"device": "source",
"sync": "full", "target": "target"}}
-{"error": {"class": "GenericError", "desc": "Cannot set permissions
for backup-top filter: Conflicts with use by other as 'image', which
uses 'write' on base"}}
+./check: line 866: ./283: Permission denied
Not run: 220
Failures: 283
Failed 1 of 115 iotests
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:842:
recipe for target 'check-tests/check-block.sh' failed

thanks
-- PMM

