Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D87C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1B222464
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcUAjYZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1B222464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKQr-00077H-6i
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvKPr-0005hm-RI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:52:11 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:47077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvKPp-0002rE-QF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:52:11 -0400
Received: by mail-ot1-x336.google.com with SMTP id n24so12900801otr.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y+IXLran2n5JRXTBl5jxItH0XAnVJdyNDfRZvC0s+CI=;
 b=FcUAjYZFcUKxBFekCpPM0hNdHJqvhzf+uWVJe4d7BsFVgJeQa0iLZxxUMztu5vf8WN
 AN0huTscXgV0ayVkymdeXbK1st9yJeTQf4kjqXsr76QNiuokS1cTleE3qt/uXfVC+CGE
 LpYZjmkL/sC4uZhutnXJATz4fS8oNHnuzK5zpn+g9q0D/jNPDR+igRJDjH1PRjc9laGj
 WGZjL9mgoUMByzaY8qC+lfxBmS5D8OoGX+fhdT9J4WAE5HCuDE2CHw1KNsjTqavZMWjY
 yYgq2tSLYiwtiMwlJON3ORnMYXrxOpbDaea3sNFfp9ceTIydzCYVeAcaC4MMeFpwBO+q
 2AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y+IXLran2n5JRXTBl5jxItH0XAnVJdyNDfRZvC0s+CI=;
 b=OtTXtEGHAqP6ThXDQqrjYHEpO5n0Z4n0dZeAgTD2vmqFxaMBqY9uK/rE7JeXBMAeRb
 ZEEL3X+3AE/fv33Whp3yCgvEPcdRExF0b1gXzgCvd1ueh5E11J3Ix66GUJr2G8Z5lkbT
 EY/LuIhGm+6Ub7whsge/2VprxqiqWrHjtaRkBdiA+P0I0CBw+50m1HfOx9nr3MRIRLH2
 MESmb8STZuA2bKJDqvIu2sM/TfGVxrZXcaDfGke157Re8F9ZVuufC8isnZ3e3V9bykM8
 I2cLkwpGORLTZoMmcuBAZwu4WHhBXK/qDLZZTvhqiv7fPwT/gJUe5wfB+lwm0FNwhARy
 9MTQ==
X-Gm-Message-State: AOAM532lk94DN0BzQJ9VMWPcI+3pyfokRI7vi/0rmzegKbOm3y7wX0Ca
 oCLt/vGeDcfBbc8KdNk8aSAY7ZhKEOHO0J51Vgn8/A==
X-Google-Smtp-Source: ABdhPJzOqJRjFgdqXj4wPy1lbdfaGTu1e9HGTlRw3khciUkJhqXw66cknOgeR/crTCWiUxIzEpJkQlNYKFxhartH/5E=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr4027504oto.135.1594731128485; 
 Tue, 14 Jul 2020 05:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200713143306.311143-1-kwolf@redhat.com>
In-Reply-To: <20200713143306.311143-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 13:51:57 +0100
Message-ID: <CAFEAcA8wHhVdw4-0amwHbn8STddUsK7C+oiFzSRW-0dWJ4dFhg@mail.gmail.com>
Subject: Re: [PULL v3] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 15:33, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 6c87d9f311dba0641bdc2df556056938a8bf2a12:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/chardev-pull-request' into staging (2020-07-13 09:34:24 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7637b225a8d59a3b9b0e31bbc4eb8a0788792ac5:
>
>   block: Avoid stale pointer dereference in blk_get_aio_context() (2020-07-13 15:57:13 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Mitigate file fragmentation with extent size hints
> - Tighten qemu-img rules on missing backing format
> - qemu-img map: Don't limit block status request size
> - Fix crash with virtio-scsi and iothreads
>
> ----------------------------------------------------------------

Fails on OpenBSD:

  TEST    iotest-qcow2: 114 [fail]
QEMU          --
"/home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- OpenBSD/amd64 openbsd 6.6
TEST_DIR      -- /home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.fiTIG5IIBg
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.yVOWVF/src/tests/qemu-iotests/114.out  Mon
Jul 13 17:59:07 2020
+++ /home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/114.out.bad
 Tue Jul 14 12:39:01 2020
@@ -1,8 +1,9 @@
 QA output created by 114
-qemu-img: warning: Deprecated use of backing file without explicit
backing format (detected format of raw)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
backing_file=TEST_DIR/t.IMGFMT.orig
+./114: line 48: truncate: command not found
+qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.orig':
No such file or directory
+Could not open backing image.
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-qemu-img: warning: Deprecated use of backing file without explicit
backing format
+qemu-img: Could not open
'/home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/scratch/t.qcow2.orig':
Could not open '/home/qemu/qemu-test.yVOWVF/build/tests/qemu-iotests/scratch/t.qcow2.orig':
No such file or directory
 qemu-img: warning: Deprecated use of backing file without explicit
backing format (detected format of IMGFMT)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 qemu-img: warning: Deprecated use of unopened backing file without
explicit backing format, use of this image requires potentially unsafe
format probing
  TEST    iotest-qcow2: 117

thanks
-- PMM

