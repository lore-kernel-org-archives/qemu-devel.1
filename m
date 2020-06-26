Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD8DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CF320775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya6deqg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CF320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joo1R-0002ba-6w
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jonzA-000877-JX; Fri, 26 Jun 2020 09:01:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jonz7-0003DR-A9; Fri, 26 Jun 2020 09:01:40 -0400
Received: by mail-pf1-x444.google.com with SMTP id f9so4637750pfn.0;
 Fri, 26 Jun 2020 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xsTLxzSVnfn+B9EFfkSk3Uit7UECBv6PRYAcAUQQ4cY=;
 b=Ya6deqg0KjC+3D33afFsSlZ6g20QeZ/omDwpiGdTylA9PUksaS8KoG47ApAxPYuhNP
 FvsCamJ7D0Y3NlIS/rEUdrIdNSpioPFC6IHlgrhpBTTz779og+JedfW6ye8jw2jDiVel
 swpDRynTRLTQnFZi0Kx46EdtDhoO7ASnbV88ofLPVQoOH5eJNCpAUPTvhG/GzxOh8QcN
 tRAPyxkIGARlXqQyeMjOMvsrLQOblpmO+jySuL5cx+zXRXQF2Kg5BUIH9gT4BmKV+04P
 o+pk7bbxlWXQ43NyFCi9Y2QI97v9vZZOce+DInmpgDaweb508r91M5IyUGQrSpg7bUqh
 cw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xsTLxzSVnfn+B9EFfkSk3Uit7UECBv6PRYAcAUQQ4cY=;
 b=okFWtb9y+qopqJgFa5GExw0Ur6GKI3aCU+m1uMDyUZCh6DD5nNv63dicQ5TKVCacKy
 BZKp4nXIHkoyiOrHkJqWlG6vMYws6RjsfbZie5ZSjqw6YlJgvX01jb4ljrjEFcBrbqBN
 Bg858ckKJBkvifEOuP/tjMqHwjzu45REbHYl7Gh9TYZrTBODyvei0cTH188dXWd5mFBr
 M8bOB5TABVzTcJQvlSeFAvteVgiS7cgl94PC0sxbjct5jECtVy8zNRnXO4cb4NKTwQJI
 8udD2Qz/LJzPrGClz+z0zWLvWVuHqFTKFfrgNZZCO2EwR91zH2Wu5dbBGu6njB3eiUAw
 Ln1Q==
X-Gm-Message-State: AOAM531alae94gtY77mumbpO5onVGWBYjOsTh3v3A3Actg1KL1Q6Ti+V
 q7RL4wI5qgAa+pPjZvqpkgmcFh5my+A7UuEKVTs=
X-Google-Smtp-Source: ABdhPJxNWb664+Xo6jVzO6hCVY86vpCiTo75k5y+ZD/pxNjRCTkOzgqrO07JXbcE2MlACvktCaGtyJ4NpWqD9iZxykI=
X-Received: by 2002:a63:2b91:: with SMTP id r139mr2776441pgr.61.1593176493498; 
 Fri, 26 Jun 2020 06:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200624100210.59975-1-stefanha@redhat.com>
 <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
 <20200626102506.GD281902@stefanha-x1.localdomain>
 <CAFEAcA_kbt1Cmy3t+FWoZ_-OQ+=HgE=uzDbeXmFeJKnVdAdNFQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_kbt1Cmy3t+FWoZ_-OQ+=HgE=uzDbeXmFeJKnVdAdNFQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 26 Jun 2020 14:01:22 +0100
Message-ID: <CAJSP0QWA9kjk60QNG9S=_F4Y5BBNp4+NeZyJxMg15=AE1nrcOA@mail.gmail.com>
Subject: Re: [PULL 00/12] Block patches
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jun 26, 2020 at 11:49 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 26 Jun 2020 at 11:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Thu, Jun 25, 2020 at 02:31:14PM +0100, Peter Maydell wrote:
> > > On Wed, 24 Jun 2020 at 11:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >
> > > > The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:
> > > >
> > > >   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://github.com/stefanha/qemu.git tags/block-pull-request
> > > >
> > > > for you to fetch changes up to 7838c67f22a81fcf669785cd6c0876438422071a:
> > > >
> > > >   block/nvme: support nested aio_poll() (2020-06-23 15:46:08 +0100)
> > > >
> > > > ----------------------------------------------------------------
> > > > Pull request
> > > >
> > > > ----------------------------------------------------------------
> > >
> > > Failure on iotest 030, x86-64 Linux:
> > >
> > >   TEST    iotest-qcow2: 030 [fail]
> > > QEMU          --
> > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
> > > -nodefaults -display none -accel qtest
> > > QEMU_IMG      --
> > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-img"
> > > QEMU_IO       --
> > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-io"
> > >  --cache writeback --aio threads -f qcow2
> > > QEMU_NBD      --
> > > "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-nbd"
> > > IMGFMT        -- qcow2 (compat=1.1)
> > > IMGPROTO      -- file
> > > PLATFORM      -- Linux/x86_64 e104462 4.15.0-76-generic
> > > TEST_DIR      --
> > > /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scratch
> > > SOCK_DIR      -- /tmp/tmp.8tgdDjoZcO
> > > SOCKET_SCM_HELPER --
> > > /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotest/socket_scm_helper
> > >
> > > --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
> > >  2019-07-15 17:18:35.251364738 +0100
> > > +++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/030.out.bad
> > >   2020-06-25 14:04:28.500534007 +0100
> > > @@ -1,5 +1,17 @@
> > > -...........................
> > > +.............F.............
> > > +======================================================================
> > > +FAIL: test_stream_parallel (__main__.TestParallelOps)
> > > +----------------------------------------------------------------------
> > > +Traceback (most recent call last):
> > > +  File "030", line 246, in test_stream_parallel
> > > +    self.assert_qmp(result, 'return', {})
> > > +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
> > > line 848, in assert_qmp
> > > +    result = self.dictpath(d, path)
> > > +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
> > > line 822, in dictpath
> > > +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> > > +AssertionError: failed path traversal for "return" in "{'error':
> > > {'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
> > > found"}}"
> > > +
> > >  ----------------------------------------------------------------------
> > >  Ran 27 tests
> > >
> > > -OK
> > > +FAILED (failures=1)
> >
> > Strange, I can't reproduce this failure on my pull request branch or on
> > qemu.git/master.
> >
> > Is this failure deterministic? Are you sure it is introduced by this
> > pull request?
>
> It might be a random one that you got hit by; I just bounced
> the request because it's a block pullreq rather than anything
> obviously unrelated (and because I hadn't seen it before). I
> can have another go at merging this if you don't think it looks
> like it would be something caused by any of the patches in
> this series.

Yes, please try the test again. None of the patches should affect
qemu-iotests 030.

Stefan

