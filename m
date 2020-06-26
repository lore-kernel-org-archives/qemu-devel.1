Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41A7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912802075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk316Qtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912802075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqhv-0006dj-Qz
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joqh8-0005pi-JF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:55:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joqh5-00023n-SS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:55:14 -0400
Received: by mail-ot1-x342.google.com with SMTP id n24so6804986otr.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RIOPReNc7FnMuRo8zF+RFhXNIPaJWtVQQ6bUV80pa78=;
 b=Kk316Qtw9Nxo99Qq+BCeOfMMd0VoUUp02o/70fH0pf6t9zxwyimlLqiycvLFpjmJBP
 zU6DPtsTkctWL49txcw3LHtdrOuBK8XoUJLL0gIa6dgX2JBmRBuQvtX6K6IhFZ4Bq32E
 l3m6MBlZQeYoSyGuK/CC6/aFVGZharSWrFufnpwXcM59wwxFVJ80/V2j2Ec+L2boPz4R
 9E2CN4VWMJKdMp5o7yJ1Wq17Nqtg+2XtDONN3LM2oJ05bCA0V8lgueXH4gnTn28lHTX6
 sfx2hO4tWxFqpWTr37TCuDzVY3JgyjDi4Q2Xqx//PW3stLCJIO72fdIYmnfSH0fI83Aq
 YN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RIOPReNc7FnMuRo8zF+RFhXNIPaJWtVQQ6bUV80pa78=;
 b=qsDLUUleIteyt/o9qm9RCAKeyuTSxVMp+lfNNvB2RZn7Jed6lBxs11D71UusHWJmK4
 8nLCad/GnOGSFtaBOVlVgP2q8WFh/ZAfdSq+ToEJs+AqOB6nhhBWcTSXRWTxupsPeG//
 wpLTvhc7alO/1UppyskYril/4DO2A1qrwqVZT/T4oTmZmq0EZEbXZ9JbBJPenmZthaZ7
 XwMiRCHB6rjbgyWLS7axOIVvlaT4+D1LXheKwTGOrWkYEeVm2Bg05vRo/bsXKGV26qVU
 hMeJJ9Srq655kInHxI3JLiND6TDPLi9NpxCijV7iLpadNUPUw89Qx5e0Yp0Q2H7LPKsk
 NvCw==
X-Gm-Message-State: AOAM533cKD+daHc3OWzRlpkRg+RD+oG6mRSBHxQqKxA3o95c8YgDOpsJ
 gUgrvyJQcRqKVfE24DiSH9t9dwm7f2Q5HEvYX9AI8A==
X-Google-Smtp-Source: ABdhPJx3cF+7Q0nXQyhP3VZzOled3Nw7ALpctyzJfEgTHqh1Yt3r30I1kFAvM2dBGJCqJjmpQ1QDiO5lINNoMG9UXLg=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr360979ota.91.1593186909270; 
 Fri, 26 Jun 2020 08:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200624100210.59975-1-stefanha@redhat.com>
 <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
 <20200626102506.GD281902@stefanha-x1.localdomain>
 <CAFEAcA_kbt1Cmy3t+FWoZ_-OQ+=HgE=uzDbeXmFeJKnVdAdNFQ@mail.gmail.com>
 <CAJSP0QWA9kjk60QNG9S=_F4Y5BBNp4+NeZyJxMg15=AE1nrcOA@mail.gmail.com>
In-Reply-To: <CAJSP0QWA9kjk60QNG9S=_F4Y5BBNp4+NeZyJxMg15=AE1nrcOA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 16:54:58 +0100
Message-ID: <CAFEAcA9=sRd=oihDCGTSo15H_sBOkvA8BrKG6wK_2oKUzoNK4A@mail.gmail.com>
Subject: Re: [PULL 00/12] Block patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 14:01, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 11:49 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 26 Jun 2020 at 11:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 02:31:14PM +0100, Peter Maydell wrote:
> > > > On Wed, 24 Jun 2020 at 11:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > >
> > > > > The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:
> > > > >
> > > > >   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   https://github.com/stefanha/qemu.git tags/block-pull-request
> > > > >
> > > > > for you to fetch changes up to 7838c67f22a81fcf669785cd6c0876438422071a:
> > > > >
> > > > >   block/nvme: support nested aio_poll() (2020-06-23 15:46:08 +0100)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Pull request
> > > > >
> > > > > ----------------------------------------------------------------
> > > >
> > > > Failure on iotest 030, x86-64 Linux:
> > > >
> > > >   TEST    iotest-qcow2: 030 [fail]
> > > > QEMU          --
> > > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
> > > > -nodefaults -display none -accel qtest
> > > > QEMU_IMG      --
> > > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-img"
> > > > QEMU_IO       --
> > > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-io"
> > > >  --cache writeback --aio threads -f qcow2
> > > > QEMU_NBD      --
> > > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-nbd"
> > > > IMGFMT        -- qcow2 (compat=1.1)
> > > > IMGPROTO      -- file
> > > > PLATFORM      -- Linux/x86_64 e104462 4.15.0-76-generic
> > > > TEST_DIR      --
> > > > /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scratch
> > > > SOCK_DIR      -- /tmp/tmp.8tgdDjoZcO
> > > > SOCKET_SCM_HELPER --
> > > > /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotest/socket_scm_helper
> > > >
> > > > --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
> > > >  2019-07-15 17:18:35.251364738 +0100
> > > > +++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/030.out.bad
> > > >   2020-06-25 14:04:28.500534007 +0100
> > > > @@ -1,5 +1,17 @@
> > > > -...........................
> > > > +.............F.............
> > > > +======================================================================
> > > > +FAIL: test_stream_parallel (__main__.TestParallelOps)
> > > > +----------------------------------------------------------------------
> > > > +Traceback (most recent call last):
> > > > +  File "030", line 246, in test_stream_parallel
> > > > +    self.assert_qmp(result, 'return', {})
> > > > +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
> > > > line 848, in assert_qmp
> > > > +    result = self.dictpath(d, path)
> > > > +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
> > > > line 822, in dictpath
> > > > +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> > > > +AssertionError: failed path traversal for "return" in "{'error':
> > > > {'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
> > > > found"}}"
> > > > +
> > > >  ----------------------------------------------------------------------
> > > >  Ran 27 tests
> > > >
> > > > -OK
> > > > +FAILED (failures=1)
> > >
> > > Strange, I can't reproduce this failure on my pull request branch or on
> > > qemu.git/master.
> > >
> > > Is this failure deterministic? Are you sure it is introduced by this
> > > pull request?
> >
> > It might be a random one that you got hit by; I just bounced
> > the request because it's a block pullreq rather than anything
> > obviously unrelated (and because I hadn't seen it before). I
> > can have another go at merging this if you don't think it looks
> > like it would be something caused by any of the patches in
> > this series.
>
> Yes, please try the test again. None of the patches should affect
> qemu-iotests 030

Seemed to work this time.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

