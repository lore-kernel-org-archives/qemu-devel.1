Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA855CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E86720656
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E86720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMW74-000443-PB
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iMVwd-0008Ev-1j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iMVwb-00059I-5o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iMVwa-00058y-Th
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:33:49 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E833A85543
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 11:33:46 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id s9so7106192wrw.23
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=k3kps7Hc+WmV5SD6w0zEPQ+Y7hrVV9ERe2IJs88KPso=;
 b=MA1fdc67DuFyREMbxf1wfZXau+gdeAgPzW9Fm4EXNSiD8B/KdkAGbIOABaOQ9tbZ6w
 igIDyMBF0uojab/eDG2wnWjEuQibSt8rSTzi97uHgJlGZ1kI2xRIbG73/xK288Y0aY8m
 fHwB8Bb+KBlIS+LQ1pyUNlxjme0VYtl3G5FrYyioSo4RjAEGVJjv/tEU2D5DJDldr+Wn
 vF27wWHvZbhL/UxOmYNKOeK3dZPcDU7F9Mrf5ViXVN9danPGG9MmU7EwIt0S2TYg6XKY
 v16HRLftqobytzGmDCqK6VJa6q8QwtgqgV0vpr0Ql6dgWJkbvUyITheeFKjfqY2uoVaN
 uMhg==
X-Gm-Message-State: APjAAAU1Y3wK6s51QLb8Ud8Jpz4tmdp1bhi3S40M5acECSIgoTYdEcjb
 +jxDt+9Y6F6AEHl57VRL80QxttyU6jXWqHtRt4bjIvfV8ShFJeul57HWC4Gez66Ay2VAQk+djJL
 Z1FPjpNOtHqmU4i0=
X-Received: by 2002:a7b:cc01:: with SMTP id f1mr20108818wmh.113.1571657625512; 
 Mon, 21 Oct 2019 04:33:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8DgG5PxEx9UTOxLeyOwTPMhk3KIanDGoNANmCfHtI+vG+HAwHxGPjzpdzqNzMKIX71FnHdg==
X-Received: by 2002:a7b:cc01:: with SMTP id f1mr20108790wmh.113.1571657625170; 
 Mon, 21 Oct 2019 04:33:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id u2sm12138245wml.44.2019.10.21.04.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:33:44 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: Using virtual IOMMU in guest hypervisors other than KVM and Xen?
In-Reply-To: <20191021004418.GD9478@xz-x1>
References: <CAHyh4xisBvQ+-p5R6Wj0po17-3EOkKsALzRysHU+R=mprbdjtg@mail.gmail.com>
 <20191015024947.GC8666@xz-x1>
 <CAHyh4xgzqMuWR7moxPfWZarED5HtPcu3LmnTHMe7CpwScHa4Eg@mail.gmail.com>
 <20191019033651.GA9478@xz-x1>
 <CAHyh4xgrMUEeXOr8-dv5mZdhSkkLEPsOgu6ku_zJx1g1QxX3vA@mail.gmail.com>
 <20191021004418.GD9478@xz-x1>
Date: Mon, 21 Oct 2019 13:33:43 +0200
Message-ID: <87h8421gfc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Jintack Lim <incredible.tack@gmail.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Oct 18, 2019 at 11:19:55PM -0700, Jintack Lim wrote:
>> On Fri, Oct 18, 2019 at 8:37 PM Peter Xu <peterx@redhat.com> wrote:
>> >
>> > On Wed, Oct 16, 2019 at 03:01:22PM -0700, Jintack Lim wrote:
>> > > On Mon, Oct 14, 2019 at 7:50 PM Peter Xu <peterx@redhat.com> wrote:
>> > > >
>> > > > On Mon, Oct 14, 2019 at 01:28:49PM -0700, Jintack Lim wrote:
>> > > > > Hi,
>> > > >
>> > > > Hello, Jintack,
>> > > >
>> > > Hi Peter,
>> > >
>> > > > >
>> > > > > I'm trying to pass through a physical network device to a nested VM
>> > > > > using virtual IOMMU. While I was able to do it successfully using KVM
>> > > > > and Xen guest hypervisors running in a VM respectively, I couldn't do
>> > > > > it with Hyper-V as I described below. I wonder if anyone have
>> > > > > successfully used virtual IOMMU in other hypervisors other than KVM
>> > > > > and Xen? (like Hyper-V or VMware)
>> > > > >
>> > > > > The issue I have with Hyper-V is that Hyper-V gives an error that the
>> > > > > underlying hardware is not capable of doing passthrough. The exact
>> > > > > error message is as follows.
>> > > > >
>> > > > > Windows Power-shell > (Get-VMHost).IovSupportReasons
>> > > > > The chipset on the system does not do DMA remapping, without which
>> > > > > SR-IOV cannot be supported.
>> > > > >
>> > > > > I'm pretty sure that Hyper-V recognizes virtual IOMMU, though; I have
>> > > > > enabled iommu in windows boot loader[1], and I see differences when
>> > > > > booing a Windows VM with and without virtual IOMMU. I also checked
>> > > > > that virtual IOMMU traces are printed.
>> > > >
>> > > > What traces have you checked?  More explicitly, have you seen DMAR
>> > > > enabled and page table setup for that specific device to be
>> > > > pass-throughed?
>> > >
>> > > Thanks for the pointers. I checked that DMAR is NOT enabled. The only
>> > > registers that Windows guest accessed were Version Register,
>> > > Capability Register, and Extended Capability Register. On the other
>> > > hand, a Linux guest accessed other registers and enabled DMAR.
>> > > Here's a link to the trace I got using QEMU 4.1.0. Do you see anything
>> > > interesting there?
>> > > http://paste.ubuntu.com/p/YcSyxG9Z3x/
>> >
>> > Then I feel like Windows is reluctant to enable DMAR due to lacking of
>> > some caps.
>> >
>> > >
>> > > >
>> > > > >
>> > > > > I have tried multiple KVM/QEMU versions including the latest ones
>> > > > > (kernel v5.3, QEMU 4.1.0) as well as two different Windows servers
>> > > > > (2016 and 2019), but I see the same result. [4]
>> > > > >
>> > > > > I'd love to hear if somebody is using virtual IOMMU in Hyper-V or
>> > > > > VMware successfully, especially for passthrough. I also appreciate if
>> > > > > somebody can point out any configuration errors I have.
>> > > > >
>> > > > > Here's the qemu command line I use, basically from the QEMU vt-d
>> > > > > page[2] and Hyper-v on KVM from kvmforum [3].
>> > > > >
>> > > > > ./qemu/x86_64-softmmu/qemu-system-x86_64 -device
>> > > > > intel-iommu,intremap=on,caching-mode=on -smp 6 -m 24G -M
>> > > >
>> > > > Have you tried to use 4-level IOMMU page table (aw-bits=48 on latest
>> > > > QEMU, or x-aw-bits=48 on some old ones)?  IIRC we've encountered
>> > > > issues when trying to pass the SVVP Windows test with this, in which
>> > > > 4-level is required.  I'm not sure whether whether that is required in
>> > > > general usages of vIOMMU in Windows.
>> > >
>> > > I just tried the option you mentioned, but it didn't change anything.
>> > > BTW, what version of Windows was it?
>> >
>> > Sorry I don't remember that. I didn't do the test but I was just
>> > acknowledged that with it the test passed.  I assume you're using the
>> > latest QEMU here because I know Windows could require another
>> > capability (DMA draining) and it should be on by default in latest
>> > qemu master.
>> 
>> Thanks. Yes, I plan to use v2.11.0 eventually, but I'm trying to make
>> things work with the latest version first.
>> 
>> >
>> > At that time the complete cmdline to pass the test should be:
>> >
>> >   -device intel-iommu,intremap=on,aw-bits=48,caching-mode=off,eim=on
>> >
>> > I also don't remember on why caching-mode needs to be off at that
>> > time (otherwise SVVP fails too).
>> 
>> Thanks for providing the cmdline. However, turning off the
>> caching-mode with an assigned device resulted in the following error
>> on VM boot.
>> "We need to set caching-mode=on for intel-iommu to enable device assignment."
>> Does this mean that we can't assign a physical device all the way to a
>> nested VM with a Windows L1 hypervisor as of now?
>> 
>> Without assigning a device, I was able to boot a Windows VM with the
>> cmdline above and I see that DMAR in vIOMMU is enabled. Windows still
>> complains about DMA remapping, though. I'll investigate further.
>
> We're going to have other ways to do device assignment in the future
> leveraging the coming nested device page tables just like ARM, but
> it's still a long way until even the hardware is ready...  And we also
> don't know whether Microsoft will be unhappy again on these new
> bits. :)
>
> So, I would consider bouncing that question to Microsoft, because we
> first need to understand why Windows do not allow caching-mode to be
> set..
>
> My wild guess is that caching-mode will require some extra overhead in
> guest OS IOMMU layer so Windows is currently lacking of, while they
> might have some other way to do device assignment to L2 on their own
> (e.g., do Microsoft allow to assign devices to L2 guest if on Hyperv
> cloud)?

AFAIU, currently not: they don't have vIOMMU support at all. 

>
> CCing Vitaly as the Hyperv/Windows expert in case for further input.

I don't know if this is useful or not but Hyper-V TLFS has the following
bits defined:

CPUID 0x40000004.EAX:

Bit 6: Recommend using DMA remapping.
Bit 7: Recommend using interrupt remapping.
Bit 8: Recommend using x2APIC MSRs.

AFAIR we don't set these bits in KVM/QEMU with the currently implemented
Hyper-V enlightenments. I'd suggest to hack things up and set these to
see what happens :-) My guess is that it may even work, looking at linux
commit 29217a474683 it doesn't seem that we heed a new hypercall or
anything specific.

-- 
Vitaly

