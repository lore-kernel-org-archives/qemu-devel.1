Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD8220721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hp8z38oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD8220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeM6m-0008H5-32
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeM5j-0007Dn-U3
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:13:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeM5i-0002m5-7y
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:13:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id g25so2898282otp.13
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JBZQS/xipNxsRrPiLmffKhBVrhoA56phva5dn0SuPKo=;
 b=Hp8z38oLyvmTazCu4NtVOGcxcj5Pem3FvbS/I4+Vc6RzRTsZp3H02cyxhfwUfWNAdL
 fAj5vVOl1pgI2OjOJ8ft6taXA9UKWEX5GuWkBDbh0unWV5DfEmKfrRrSOX5ePig1FSXY
 Lzd2FPDhw4NenQVATrB6wOt5wKu+0x+hUZIryHupib3/s9BzAPmmGLn6a5GEbEn6rsZj
 vvmgyJYarI9Meb7jmCavbv+C80V7iyaJ15gODR7HmxX9hRZDvPBSwziB4hCafzblkc1D
 k7teY/49G8pBu4HH9JDo+EKXqwhxgQcb66pLtHDLj01fDx/AvTRvaoq+qY0gKOcnuEsH
 OdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JBZQS/xipNxsRrPiLmffKhBVrhoA56phva5dn0SuPKo=;
 b=NEbTeTfFumh848x5Nqe25+WJ62zWUOSac71QhXBMtjolfxgKBT0rLzuIVpiIMEZfyA
 XT0cpZd2L+Eo/geBqFf0+ssxX5P25ShenobM2GdSjbmXeZg/GOrMOegxJ4r1rQJaocI2
 nNXG6SH9lactx9smFA6234+muTxp4QNwgCCfL4qEP5H5ju2yrz02FW6dqxUNFghSENSx
 RFmBqd6HNT/NXueSHFLXeIVvM5wFjZg/Ybal05168kSNgTTyhEYU8nyCH5Flnt5qyrM4
 3oWIMP66AUoF92k5ZRw8Fpx7LGw8sJrp23rht8dJOX3zMgEMDZ/OILCw634aUEbJ48gZ
 jPfw==
X-Gm-Message-State: AOAM532GJV3YOrKc2crfcU6sXWWgpWZxqU7wjZr6lOLqe0HcqnCGxCx3
 3ankXRI5G7sORP6y1ip7HlGsVwbQ196GanUxpsxvZw==
X-Google-Smtp-Source: ABdhPJwVaXrVHBh69fmXzG3J5kD90ivX6nV+JpzpesavjvxktwU+q9AefGI5+K/RC178DbcQicfhpmMjmGSHTykhK3A=
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr123697otk.135.1590685992314;
 Thu, 28 May 2020 10:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200527213708.1783644-1-eblake@redhat.com>
In-Reply-To: <20200527213708.1783644-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 18:13:01 +0100
Message-ID: <CAFEAcA-30_q6ZtFnpocVh9PH8qroZbqem6NYSRsGRCD7dzp8Ew@mail.gmail.com>
Subject: Re: [PULL v2 00/11] bitmaps patches for 2020-05-26
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 at 22:38, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-26-v2
>
> for you to fetch changes up to 958796e47d3af10ece329294a7bb41d5853667db:
>
>   iotests: Add test 291 to for qemu-img bitmap coverage (2020-05-27 16:19:59 -0500)
>
> v2: fix iotest 190 to not be as sensitive to different sparseness of
> qcow2 file on various filesystems, such as FreeBSD (sending only the
> changed patch)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-05-26
>
> - fix non-blockdev migration of bitmaps when mirror job is in use
> - add bitmap sizing to 'qemu-img measure'
> - add 'qemu-img convert --bitmaps'
>

Your fix for iotest 190 doesn't seem to work. Here's the new output
(same on openbsd, freebsd, netbsd):

  TEST    iotest-qcow2: 190 [fail]
QEMU          --
"/home/qemu/qemu-test.B2aJfj/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.B2aJfj/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.B2aJfj/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.B2aJfj/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- OpenBSD/amd64 openbsd 6.6
TEST_DIR      -- /home/qemu/qemu-test.B2aJfj/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.9459w4OTae
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.B2aJfj/src/tests/qemu-iotests/190.out  Thu
May 28 16:06:04 2020
+++ /home/qemu/qemu-test.B2aJfj/build/tests/qemu-iotests/190.out.bad
 Thu May 28 16:31:13 2020
@@ -17,7 +17,7 @@
 fully allocated size: 10813440
 required size: 2199023255552
 fully allocated size: 2199023255552
-required size: SIZE
+required size: 17170432
 fully allocated size: 17170432
 required size: 335806464
 fully allocated size: 2199359062016

I think this is an issue with your sed expression:
+$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG" |
+    sed '/^required size:/ s/[0-9]\+/SIZE/'

BSD sed seems to strictly implement POSIX basic regexes,
in which '+' is not handled. Compare:

$ echo "required size: 17170432" | sed '/^required size:/ s/[0-9]+/SIZE/'
required size: 17170432
$
$ echo "required size: 17170432" | sed '/^required size:/ s/[0-9][0-9]*/SIZE/'
required size: SIZE

thanks
-- PMM

