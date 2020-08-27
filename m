Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B74C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544E92080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTKk4rWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544E92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKPp-0006Du-L5
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kBKNw-0004KY-Pz; Thu, 27 Aug 2020 12:04:20 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kBKNu-0004aw-JE; Thu, 27 Aug 2020 12:04:20 -0400
Received: by mail-io1-xd42.google.com with SMTP id d18so6325007iop.13;
 Thu, 27 Aug 2020 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Tx9S6uoPdFyNTRBfxNdyFFit/3TUwXl/QcWG9Wflwk=;
 b=DTKk4rWCZX3JSxTpaurUtd3mMNvJjBEbkK1MiK38I0lxoS5NTH3FtQbLHZEavi+7Oj
 fp6gZpcF//Ckfs6dVxni9avQ/WWjiWHfp6WCFNb5gOXAj6QZIDMo0NPTkbx5imb1Oe7v
 zUP39zJ3M/uhuckMt0Wha4D6Z2UKldkLKw7luHpmahipcSRtjCzFh7fvFO1QFrnPtBzh
 AI+vBjxc7RNQ0VrhS+27XOhh0TPGSB2zAO7q5j4mCaihuuOfNq/W+tIQiF5Pv2jjIZVr
 lTcUqTyCmPjynN9hhGaBI+huTAr6WIlLmWTBZjVO/68MVi4qnhMhACAatFJv0gFibJHK
 Z7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Tx9S6uoPdFyNTRBfxNdyFFit/3TUwXl/QcWG9Wflwk=;
 b=ssOWsNvdWcnUYqVzYF5EOPbqkTsF3qDSW2XYy3ka4eFhnSEaalPUkCK+N+GOXSd1Yc
 1xfwREjHPrjV1paU3AJ1X4gEpqPXPv76qtA7xvEdiquAHOPZ4jIqOB1Flk3FWIlqYx/7
 00hNBVSyQLssyV/w0a6Hy0Dy3bhGf+bLB/d9TBIOYe1OtS9YPcf6erAfsQGq6GpEOBIU
 mEqEw7BYSO0qm/kNTuAPrl2+GPCy0QeYm+IF7NelXl76bAPWOnwIgz2AEBQbHUpJ86oN
 ltwfrViBf6ia9q9n1Zx8JO7tKts6rJcfqv9cM5z6/p+KBLhf/XwWYKe6Ox8xLe0rbcHB
 SvPg==
X-Gm-Message-State: AOAM5317efm8QJid+n5JS7ZE6rXZEIR5eb4XDAOLXbOCdYyJvux8tWjf
 Ldhz/llQBPh8kHKO1qeIJXirjuiPdgs/LN9z9tg=
X-Google-Smtp-Source: ABdhPJx8XjY0lXhhWIfKF7ooPB6U1ybUpVizT+9AZT8Py06Z5KEmGz2MT9enknGSaltHtRc1FK1iBnfGdjPbRxNBCkk=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr17363630ios.176.1598544256063; 
 Thu, 27 Aug 2020 09:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200610134731.1514409-1-mst@redhat.com>
 <20200827053216.GA1515751@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200827053216.GA1515751@ubuntu-n2-xlarge-x86>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Aug 2020 08:53:30 -0700
Message-ID: <CAKmqyKNYrpkN+JjDja+2YuSBTg9hVjTZsr+Zej0AFC-KWJr_eA@mail.gmail.com>
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
To: Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 11:26 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> Sorry for the duplicate reply, my first one was rejected by a mailing
> list administrator for being too long so I resent it with the error logs
> as a link instead of inline.
>
> On Wed, Jun 10, 2020 at 09:47:49AM -0400, Michael S. Tsirkin wrote:
> > Memory API documentation documents valid .min_access_size and .max_access_size
> > fields and explains that any access outside these boundaries is blocked.
> >
> > This is what devices seem to assume.
> >
> > However this is not what the implementation does: it simply
> > ignores the boundaries unless there's an "accepts" callback.
> >
> > Naturally, this breaks a bunch of devices.
> >
> > Revert to the documented behaviour.
> >
> > Devices that want to allow any access can just drop the valid field,
> > or add the impl field to have accesses converted to appropriate
> > length.
> >
> > Cc: qemu-stable@nongnu.org
> > Reviewed-by: Richard Henderson <rth@twiddle.net>
> > Fixes: CVE-2020-13754
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1842363
> > Fixes: a014ed07bd5a ("memory: accept mismatching sizes in memory_region_access_valid")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  memory.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> >
> > diff --git a/memory.c b/memory.c
> > index 91ceaf9fcf..3e9388fb74 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1352,35 +1352,24 @@ bool memory_region_access_valid(MemoryRegion *mr,
> >                                  bool is_write,
> >                                  MemTxAttrs attrs)
> >  {
> > -    int access_size_min, access_size_max;
> > -    int access_size, i;
> > +    if (mr->ops->valid.accepts
> > +        && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> > +        return false;
> > +    }
> >
> >      if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
> >          return false;
> >      }
> >
> > -    if (!mr->ops->valid.accepts) {
> > +    /* Treat zero as compatibility all valid */
> > +    if (!mr->ops->valid.max_access_size) {
> >          return true;
> >      }
> >
> > -    access_size_min = mr->ops->valid.min_access_size;
> > -    if (!mr->ops->valid.min_access_size) {
> > -        access_size_min = 1;
> > +    if (size > mr->ops->valid.max_access_size
> > +        || size < mr->ops->valid.min_access_size) {
> > +        return false;
> >      }
> > -
> > -    access_size_max = mr->ops->valid.max_access_size;
> > -    if (!mr->ops->valid.max_access_size) {
> > -        access_size_max = 4;
> > -    }
> > -
> > -    access_size = MAX(MIN(size, access_size_max), access_size_min);
> > -    for (i = 0; i < size; i += access_size) {
> > -        if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
> > -                                    is_write, attrs)) {
> > -            return false;
> > -        }
> > -    }
> > -
> >      return true;
> >  }
> >
> > --
> > MST
> >
> >
>
> I just ran into a regression with booting RISC-V kernels due to this
> commit. I can reproduce it with QEMU 5.1.0 and latest tip of tree
> (25f6dc28a3a8dd231c2c092a0e65bd796353c769 at the time of initially
> writing this).
>
> The error message, commands, and bisect logs are available here:
>
> https://gist.githubusercontent.com/nathanchance/c106dd22ec0c0e00f6a25daba106a1b9/raw/d929f2fff6da9126ded156affb0f19f359e9f693/qemu-5.1.0-issue-terminal-log.txt

From what I can tell the problem happens when you try to reboot the board right?

You might want to try changing this line from 4 to 8:
https://github.com/qemu/qemu/blob/master/hw/riscv/sifive_test.c#L63

>
> I have attached the rootfs and kernel image used for these tests. If for
> some reason there is a problem receiving them, the kernel is just an
> arch/riscv/configs/defconfig kernel at Linux 5.9-rc2 and the rootfs is
> available here:
>
> https://github.com/ClangBuiltLinux/boot-utils/blob/3b21a5b71451742866349ba4f18638c5a754e660/images/riscv/rootfs.cpio.zst
>
> Please let me know if I can provide any follow up information or if I am
> doing something wrong.

Thanks for providing so much information and doing a bisect.

Alistair

>
> Cheers,
> Nathan

