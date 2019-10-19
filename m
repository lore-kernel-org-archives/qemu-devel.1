Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA527CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A773D21835
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbQ1oEJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A773D21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLi6o-0005yw-Or
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <incredible.tack@gmail.com>) id 1iLi60-00057m-Q9
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <incredible.tack@gmail.com>) id 1iLi5z-0007AT-5T
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:20:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:34144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <incredible.tack@gmail.com>)
 id 1iLi5y-00079U-TT
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:20:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y135so10709416wmc.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cd1VGtfqFhd2RP/xe2QL0DcEDsIauhUWaXJ4sqT0wwo=;
 b=jbQ1oEJYbcb8vgX8bHsj8u22T3o6D3Ki3yHWMOaPvhUg5YYf+xAsWWLVMEu/qtIh8r
 x5c0WBaCInApoUnTsnDBePzGHYdFtE1tOSc49nHanblsnT56Bzp2UUjYsmpPMLppoRsf
 zRyDO1zWa0fWQCuHsuoAh80jte7MebMzKJw9aodA500mL5Q4q56ICc1sQY5fcNPfSpQS
 uLBRmnEEqB1FkQ/w48SrmrbrG51J+U6xphxsyCa472LsfOC+Lyrt2Q+l+nVmlfob1qPX
 wvZLMiPDMijtWEbyvttwlj7ZGiVWT9A2rx4Cyod4NLVxLkVK7D2eVbVLT3jKw+CC9QMG
 GsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cd1VGtfqFhd2RP/xe2QL0DcEDsIauhUWaXJ4sqT0wwo=;
 b=pF5n51v0pBX2KjsjiF4JmCuSIJplpf4QXnggsG2D1ubmV7ow+yZs4aEC4Cq68WQ1Hn
 UiJJYXoFm1Ibwfm3As6UC9Q0StDvNygD1iIawm0YERIv8czTU2gEq67wLd6P9QbzDb43
 Zsmvb6iA3ahwBdjSBRbeu044jLxj3+J4l8Lf5xpmr+VtrYx1oJSm4XiZ7WPPAePgEkIY
 wzTqvzmpRPTmtf9Y7l9F30dU8mvlZPJqaJp0qqiY3aq40gxIkUvljgzMu+HljpvwM2lw
 LxDskcFiKqNxEg8rK8Vu8jV71ZvYuzsvzIBRwTBBqGqvdqC3QJkCnHP5im3FnyjgREjQ
 zWDQ==
X-Gm-Message-State: APjAAAWu9xmaD1dmlG6alMPp/SgSQ01WbGlqQnMEIZSJeSeB1t9MuW6x
 +FTbQyLJ2dHxBBZFrOd3/cLXww2tchnuKOSplTQ=
X-Google-Smtp-Source: APXvYqztUtKYTR8onOoz7MKsSV4qC+xp1AHC0QkU78059lDI1zyvnz8GJsJRkdTpy6sB54WCu8V3WtNbTVkktWV3VPU=
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr11028487wmc.8.1571466008471; 
 Fri, 18 Oct 2019 23:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
 <20191015024947.GC8666@xz-x1>
 <CAHyh4xgzqMuWR7moxPfWZarED5HtPcu3LmnTHMe7CpwScHa4Eg@mail.gmail.com>
 <20191019033651.GA9478@xz-x1>
In-Reply-To: <20191019033651.GA9478@xz-x1>
From: Jintack Lim <incredible.tack@gmail.com>
Date: Fri, 18 Oct 2019 23:19:55 -0700
Message-ID: <CAHyh4xgrMUEeXOr8-dv5mZdhSkkLEPsOgu6ku_zJx1g1QxX3vA@mail.gmail.com>
Subject: Re: Using virtual IOMMU in guest hypervisors other than KVM and Xen?
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 8:37 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Oct 16, 2019 at 03:01:22PM -0700, Jintack Lim wrote:
> > On Mon, Oct 14, 2019 at 7:50 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Mon, Oct 14, 2019 at 01:28:49PM -0700, Jintack Lim wrote:
> > > > Hi,
> > >
> > > Hello, Jintack,
> > >
> > Hi Peter,
> >
> > > >
> > > > I'm trying to pass through a physical network device to a nested VM
> > > > using virtual IOMMU. While I was able to do it successfully using KVM
> > > > and Xen guest hypervisors running in a VM respectively, I couldn't do
> > > > it with Hyper-V as I described below. I wonder if anyone have
> > > > successfully used virtual IOMMU in other hypervisors other than KVM
> > > > and Xen? (like Hyper-V or VMware)
> > > >
> > > > The issue I have with Hyper-V is that Hyper-V gives an error that the
> > > > underlying hardware is not capable of doing passthrough. The exact
> > > > error message is as follows.
> > > >
> > > > Windows Power-shell > (Get-VMHost).IovSupportReasons
> > > > The chipset on the system does not do DMA remapping, without which
> > > > SR-IOV cannot be supported.
> > > >
> > > > I'm pretty sure that Hyper-V recognizes virtual IOMMU, though; I have
> > > > enabled iommu in windows boot loader[1], and I see differences when
> > > > booing a Windows VM with and without virtual IOMMU. I also checked
> > > > that virtual IOMMU traces are printed.
> > >
> > > What traces have you checked?  More explicitly, have you seen DMAR
> > > enabled and page table setup for that specific device to be
> > > pass-throughed?
> >
> > Thanks for the pointers. I checked that DMAR is NOT enabled. The only
> > registers that Windows guest accessed were Version Register,
> > Capability Register, and Extended Capability Register. On the other
> > hand, a Linux guest accessed other registers and enabled DMAR.
> > Here's a link to the trace I got using QEMU 4.1.0. Do you see anything
> > interesting there?
> > http://paste.ubuntu.com/p/YcSyxG9Z3x/
>
> Then I feel like Windows is reluctant to enable DMAR due to lacking of
> some caps.
>
> >
> > >
> > > >
> > > > I have tried multiple KVM/QEMU versions including the latest ones
> > > > (kernel v5.3, QEMU 4.1.0) as well as two different Windows servers
> > > > (2016 and 2019), but I see the same result. [4]
> > > >
> > > > I'd love to hear if somebody is using virtual IOMMU in Hyper-V or
> > > > VMware successfully, especially for passthrough. I also appreciate if
> > > > somebody can point out any configuration errors I have.
> > > >
> > > > Here's the qemu command line I use, basically from the QEMU vt-d
> > > > page[2] and Hyper-v on KVM from kvmforum [3].
> > > >
> > > > ./qemu/x86_64-softmmu/qemu-system-x86_64 -device
> > > > intel-iommu,intremap=on,caching-mode=on -smp 6 -m 24G -M
> > >
> > > Have you tried to use 4-level IOMMU page table (aw-bits=48 on latest
> > > QEMU, or x-aw-bits=48 on some old ones)?  IIRC we've encountered
> > > issues when trying to pass the SVVP Windows test with this, in which
> > > 4-level is required.  I'm not sure whether whether that is required in
> > > general usages of vIOMMU in Windows.
> >
> > I just tried the option you mentioned, but it didn't change anything.
> > BTW, what version of Windows was it?
>
> Sorry I don't remember that. I didn't do the test but I was just
> acknowledged that with it the test passed.  I assume you're using the
> latest QEMU here because I know Windows could require another
> capability (DMA draining) and it should be on by default in latest
> qemu master.

Thanks. Yes, I plan to use v2.11.0 eventually, but I'm trying to make
things work with the latest version first.

>
> At that time the complete cmdline to pass the test should be:
>
>   -device intel-iommu,intremap=on,aw-bits=48,caching-mode=off,eim=on
>
> I also don't remember on why caching-mode needs to be off at that
> time (otherwise SVVP fails too).

Thanks for providing the cmdline. However, turning off the
caching-mode with an assigned device resulted in the following error
on VM boot.
"We need to set caching-mode=on for intel-iommu to enable device assignment."
Does this mean that we can't assign a physical device all the way to a
nested VM with a Windows L1 hypervisor as of now?

Without assigning a device, I was able to boot a Windows VM with the
cmdline above and I see that DMAR in vIOMMU is enabled. Windows still
complains about DMA remapping, though. I'll investigate further.

>
> --
> Peter Xu
>

