Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04504C433E3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C926720738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxq7y3HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C926720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ZmL-0005Po-Uy
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2Zli-0004vk-OG
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:40:42 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:35874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2Zlg-0006ZK-SF
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:40:42 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id n24so4672850ooc.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wcNEV9Dm6oy2qVvWgQ1QGb+tNHgZza70ZERt60TetGw=;
 b=rxq7y3HJifmy7vp7Z1RtFDP5jSuechxdQE7jFhaNe5dO+oRn5VzXpRmI98CJkBN+7h
 doydijcM6cLo8ycND8P7OWascAzgqkmFaLmCHMU1OTm2TyrpgHQqvfo7j0gHzxJZ0Rkl
 tzuKR2dClPKdanjk9SplRbeO6SmGL8kEKImsVmEvt1ZmvppahXbNjzm1gAKZAFgL0+me
 F0Rkx5+YRsjDvud+umclBBYEMUGA8/z9Qrqb8UlF7O36ymhewa/ECNMFKGToYa3bivFu
 iBUkfMIxLuVwCXij47CZCXQigxXyLsRtJbZXqNftBjd/NEfplz8OMksPwFj88PeQME6N
 /I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wcNEV9Dm6oy2qVvWgQ1QGb+tNHgZza70ZERt60TetGw=;
 b=r/s7vUWCkEyHb5rl5d/TljM52opDB2Li4UjgHnHzkOaEOsLiMhcSu8xYSnElKKKviy
 KaO8yLds9/qQVV1X/VkzP0Olyexnbolo+Wh3Y+3dnXNEGvXrOB1uUSdHhOx7YPsRoQSc
 q+O0joQ3e9Md8Kf68425/T7hg0Gjeh9+izt+XxWDJmIVbJYlMTPOoFRZrcHt8cpXEqTX
 POOpePrOjlm9ybcVtjOvgnTyhvmVy3zqNC1KAsUWRNotBHS5UrcbhzC97lUaXL91cDU5
 nNXRZNWMqp7q+oPJYRrHmKk+18oWI+wef5IHpC0Un8y68IZtuFoghBq5yb9jUa1PPgU7
 oQfQ==
X-Gm-Message-State: AOAM533Url56z/TxE6BshukmOBKJE5RdsltrDZ9MpzPdjoIFgQaG/eOg
 S8QKZd8EDyqQroDP+P1eZBFk1AhhiiQeopEsPK5Ptg==
X-Google-Smtp-Source: ABdhPJwWbNoVPCU5evkV23d0dgumwFqrZjVwMBflaQAJFodnBAUXH+fhKonvhDrm6jIHJioVGpftiY76tyCf5KQbCaE=
X-Received: by 2002:a4a:4c44:: with SMTP id a65mr13882257oob.20.1596458439384; 
 Mon, 03 Aug 2020 05:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200717125510.238374-1-kwolf@redhat.com>
 <20200717125510.238374-6-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-6-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 13:40:28 +0100
Message-ID: <CAFEAcA_Fd2Do6LH8C9S82Yk5dTpu9xOR4iqEpsWrqfUtt4WW+Q@mail.gmail.com>
Subject: Re: [PULL 05/12] iotests/030: Reduce job speed to make race less
 likely
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2f.google.com
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

On Fri, 17 Jul 2020 at 13:55, Kevin Wolf <kwolf@redhat.com> wrote:
>
> It can happen that the throttling of the stream job doesn't make it slow
> enough that we can be sure that it still exists when it is referenced
> again. Just use a much smaller speed to make this very unlikely to
> happen again.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Message-Id: <20200716132829.20127-1-kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/030 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I just saw this iotest 030 failure again (ppc64 host, not
reproducible) fwiw:

  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-system-ppc64"
-nodefaults -display none -a
ccel qtest
QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.a6PEzbPDby
SOCKET_SCM_HELPER --
/home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/pm215/qemu/tests/qemu-iotests/030.out 2019-07-15
15:12:04.941863802 +0000
+++ /home/pm215/qemu/build/all/tests/qemu-iotests/030.out.bad
2020-08-03 09:01:37.540111583 +0000
@@ -1,5 +1,17 @@
-...........................
+.............F.............
+======================================================================
+FAIL: test_stream_parallel (__main__.TestParallelOps)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 251, in test_stream_parallel
+    self.assert_qmp(result, 'return', {})
+  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 882, in
assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 856, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' no
t found"}}"
+
 ----------------------------------------------------------------------
 Ran 27 tests

-OK
+FAILED (failures=1)


thanks
-- PMM

