Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6F2C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CCD2054F
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oypKc9ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CCD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9abQ-0002Lv-DJ
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9aak-0001L2-7e
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:58:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:35206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9aai-0000Kb-CY
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:58:21 -0400
Received: by mail-ed1-x52c.google.com with SMTP id m20so4765442eds.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Bc1RzgUd+QOvMuRwlYYuUj9tiB1OO+2isp4JUxIXKw=;
 b=oypKc9neY3Y18Bt/AU6ffGxVO+linpxn0jvxV65k0oDHRtuiXSachtLXUa5bDEwwer
 qU8LV6Fy4hrrPktqOvWr7uabNlvNimAGLWL3lr31mqjvk9ro/biBQDU7OEs1XPZ1KS9M
 ggsvnCXorpjC39ndliwEtRLtmLPdP6wRO10VodOlIuugdCTnQODAzyf2IDWFmXw4pJGJ
 vO0/vPnOpo9helxuUe02mKAvH7Q3Oab6D6w5iO/VbTCiwUB+zE7Ec8XWnjIy+3J6Qh7U
 JkCJuxv26Uw9BxBVs3Eaoyd37NOaRccjHQ8ay44QQNRiNYPG0OuzImcncsxfOR6umUdn
 yl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Bc1RzgUd+QOvMuRwlYYuUj9tiB1OO+2isp4JUxIXKw=;
 b=JoW54BVaA111C+sGwGQTqctWWONfre6bJYMxpz1cJwVTbkZgkJjBeT5n4aj4tcudeg
 CZGuQq5TL2+wJqXLvjoI2y/hBOK+FuwWxjMLoorhJSi+/q+U5uyEv4TSIj+eZhweOeaU
 hI8hD0Cu/lji0Hq76I14Yewumvy+XVEFB4lp4xoggguP9FmAsymB0u/u5XZ2LKnAy9Uo
 vdNJV58HBO+GJE5lfEQjQuQw2RxQ/997D+j0mgV7Kc4/Ikz7rAWKOAsoJ17bK0tnOaKH
 P/+Up2D0bvmXLf8qlaij91KMXmPtn+/qjNgJbbRPwTDWD2MMbf6QI8naM/1lsOu/z3MO
 0VEw==
X-Gm-Message-State: AOAM533MrPxFFafXYWsyJ0JTRryQYyOVk4zvOFSeM5r+0N1euKCdd7HZ
 sd+l0Oro0myk49PcznHUQXuWbbqE9vZR2ZYKi1jV3w==
X-Google-Smtp-Source: ABdhPJxSnP+N7SIrXFA0eeH2d6i2OMk+IpLnx6IVXQJwvb4lVWFpjYlgrHrWzymT4fVEJdEDj/tdZy9mcA1uMmu6w6w=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr8724779edq.204.1598129898201; 
 Sat, 22 Aug 2020 13:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140826.194322-1-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Aug 2020 21:58:07 +0100
Message-ID: <CAFEAcA-v2MCkbCsfHZzm6EOC34DdZkPEeOQ5c7cP1ODS_5r63g@mail.gmail.com>
Subject: Re: [PULL 00/14] bitmaps patches for 2020-08-21
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 at 15:12, Eric Blake <eblake@redhat.com> wrote:
> ----------------------------------------------------------------
> bitmaps patches for 2020-08-21
>
> - Andrey Shinkevich: Enhance qcow2.py for iotest inspection of qcow2 images
> - Max Reitz: Add block-bitmap-mapping migration parameter

iotest 030 failure on ppc64be:

  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-system-ppc64"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.2XM0XBi18t
SOCKET_SCM_HELPER --
/home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/pm215/qemu/tests/qemu-iotests/030.out 2019-07-15
15:12:04.941863802 +0000
+++ /home/pm215/qemu/build/all/tests/qemu-iotests/030.out.bad
2020-08-22 19:00:37.756291193 +0000
@@ -1,5 +1,17 @@
-...........................
+.............F.............
+======================================================================
+FAIL: test_stream_parallel (__main__.TestParallelOps)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 251, in test_stream_parallel
+    self.assert_qmp(result, 'return', {})
+  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 888, in
assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
found"}}"
+
 ----------------------------------------------------------------------
 Ran 27 tests

-OK
+FAILED (failures=1)

Intermittent; it passed second time around, so I'm guessing that this
is unrelated to this particular pullreq, and I've applied it.

Can we do something about iotest 030 ? It seems to be
causing intermittent failures for me still :-(


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

