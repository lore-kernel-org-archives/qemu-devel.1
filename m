Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EFDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECCA20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmjGwirc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECCA20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joS0w-00032f-0h
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRyV-0008Er-35
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:31:32 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:35403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRyR-0005jF-Mn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:31:30 -0400
Received: by mail-oi1-x22f.google.com with SMTP id k4so4959662oik.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T83L/jp7T1UPrpVDDi8J3X93DTN0mhpJd5lvMULeVNk=;
 b=cmjGwircUiBde2KHaqRzsLtXCSMrBk8+kMSq/bZJwb7LyvzmKZAtEJcr5ab+CY5BYP
 KEF0gTYDCSxx1gTCLfZHvj3+hkafvcupzgNuE2a6RXas3Gf9dqHjJOkkGaDbrdDZ9heB
 mkc+7uvON5DAqvkVdhPdCq7q75c5mdCulqwmEV3qO2k9DPPm+vyKC4TRuNlnhYEZq/0f
 MENch9VTW4zmUPHrf0anhQ36fPwNtZ0NJTi8XySaj6oYMsdLYFknulqk59L8lAyFOg3V
 9OorFSp/Gni5AnD32ZI92wbZp6IyLefLTP5ma+7yYgRsnoFzHXLQpcEi+d9y0BnU/AbM
 VTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T83L/jp7T1UPrpVDDi8J3X93DTN0mhpJd5lvMULeVNk=;
 b=lCusHqHk+9B6kGoN0TJAs20kXslzrPGI1kqQoImwfubLKynbWEuaJFVwyvHscZfchl
 j0VJWhL3eL2Mjm1O7lEjvT3r3jEg/1NN1RrEnQYSHQtBFHqvNc3mVTcMwgZ/K3fEbv/e
 DQlWqYBI4z1QOd3UrOUWkz8CczxREJ2s1YwDeRzx21+5NBe7NW1DgQ372LA789N+vc5x
 DrMLEvPfoMoPAMdh7nmtNvQBs3WKZjaw0ufmxAhtD+CGl0ejEJmjwK+8Fasz8ZITt1L2
 x81E0ctN6SeAZM4TxUwdYCyNTzuHbsYagWkqrdHoXGHJgFZqfa1/eznvTwXNg81n135J
 PeOA==
X-Gm-Message-State: AOAM53215yQZszGIGFFN2LBBDg3h4zEKqmxMeU0bGqQ5Sekl5WBZYI75
 TEypvp8RmxR9CiXCsC+QceQCMBAYLTonG0eH4159UQ==
X-Google-Smtp-Source: ABdhPJyxXKa3QcnGOR30K/q/fYKxXdWN9PA+M9nvcztuyQWjLyhCuQQrXNgbrfDYFBZlNwQZDRONHt+YqZSuZfUYQZE=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2014596oib.48.1593091886277; 
 Thu, 25 Jun 2020 06:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200624100210.59975-1-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:31:14 +0100
Message-ID: <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
Subject: Re: [PULL 00/12] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 at 11:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 7838c67f22a81fcf669785cd6c0876438422071a:
>
>   block/nvme: support nested aio_poll() (2020-06-23 15:46:08 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Failure on iotest 030, x86-64 Linux:

  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
-nodefaults -display none -accel qtest
QEMU_IMG      --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-io"
 --cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 e104462 4.15.0-76-generic
TEST_DIR      --
/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.8tgdDjoZcO
SOCKET_SCM_HELPER --
/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotest/socket_scm_helper

--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
 2019-07-15 17:18:35.251364738 +0100
+++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/030.out.bad
  2020-06-25 14:04:28.500534007 +0100
@@ -1,5 +1,17 @@
-...........................
+.............F.............
+======================================================================
+FAIL: test_stream_parallel (__main__.TestParallelOps)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 246, in test_stream_parallel
+    self.assert_qmp(result, 'return', {})
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
line 848, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
line 822, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
found"}}"
+
 ----------------------------------------------------------------------
 Ran 27 tests

-OK
+FAILED (failures=1)


thanks
-- PMM

