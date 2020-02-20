Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF47AC11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 04:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E8E207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 04:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBNv2kY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E8E207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zYW-0007ia-KA
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 23:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bgardon@google.com>) id 1j4pj9-0005AE-2t
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bgardon@google.com>) id 1j4pj7-00013X-12
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:35:07 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b]:44716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bgardon@google.com>) id 1j4pj6-00013D-QN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:35:04 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id p6so3181277vsj.11
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pmepnRQK+Zeo8qJsEnVROV7jHSWSqjA8jl+uj8g9eIM=;
 b=KBNv2kY21Ekq9DJjatjVC+1UAKeTLzMFYY+GIqYkhD0imNTcI/tOFagRTRtxWQQUOZ
 9SvpD59m/sJqW1dNrAUebD/XLNSZn8utkzirgGA6HxmrBwUYAhovlQa/Pm/ujPgRz9xL
 uCtRvZ4QB8pbmF7v4IuLrtM7Smmh6M94elINPcQr0bR5NFcuemcUHkJW1/vxT4zauneD
 m/AuvwRul1Mn3uMMPzjKrH2lspInCYHZFfg6bBBGCr3DSdfKRthWIXhSonr2rHfqrYm5
 +dgWzwFGqf9kZhTAGbjhAahT//foRnRBhg0oXsBGQMU2nKq/ODVNvbMZJAqmFIOFdIrF
 OXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pmepnRQK+Zeo8qJsEnVROV7jHSWSqjA8jl+uj8g9eIM=;
 b=rqrv/ug/htnSuuwOhI0n81QIbQ07Qct6IqIUYedZE5SS2bev4dkBFytZMMt2814Io3
 JeKKwykm5AvUpSNS82ROOx9w1sT8KbIYncd0xcW8XXlG5GHT/Mxl8cvElEYuYHdWdFRb
 xWFfa55cuw4+Oom++gg5Cl1wAER2K4BXrrPiXkG3W3K/lFadNkHgpZhKKFAx4lwSnIYB
 X8XpdQqf52c0B5vy7FUeffy4lGljG0iClOdtuU98KRJnGWmAZyqytxrz7XkPscciTjGz
 FLLmAxHLJhptE5ayAOLgdATnTtE3cgBoGPZ4e1v9auWCjCcRQ+ZFsUnJ8ITEL1PVc0Ak
 Eblw==
X-Gm-Message-State: APjAAAX2eAZByb3+W0WLMGA7USDXceJMQHwR4Nw/ryoCAUsXIKQqKlTH
 Yt7X4KMv9sa1DAJzIRv95eZ2GzcI+jcJQsKFGzvB/g==
X-Google-Smtp-Source: APXvYqxJEi1XhN5xBDOdXVTbwudDgBOrXmAcvL/t5e4xbvxev5WQPoqMZZugmV8utCpq8q3pdC2gdhTQxSo3FgsJswA=
X-Received: by 2002:a05:6102:394:: with SMTP id
 m20mr17887422vsq.235.1582220103799; 
 Thu, 20 Feb 2020 09:35:03 -0800 (PST)
MIME-Version: 1.0
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
 <20200219171919.GA34517@xz-x1>
 <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
In-Reply-To: <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
From: Ben Gardon <bgardon@google.com>
Date: Thu, 20 Feb 2020 09:34:52 -0800
Message-ID: <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
 Junaid Shahid <junaids@google.com>
Cc: Peter Xu <peterx@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, 
 "Liujinsong (Paul)" <liu.jinsong@huawei.com>,
 "linfeng (M)" <linfeng23@huawei.com>, 
 "wangxin (U)" <wangxinxin.wang@huawei.com>,
 "Huangweidong (C)" <weidong.huang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e2b
X-Mailman-Approved-At: Thu, 20 Feb 2020 23:01:56 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 5:53 AM Zhoujian (jay) <jianjay.zhou@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Thursday, February 20, 2020 1:19 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: kvm@vger.kernel.org; qemu-devel@nongnu.org; pbonzini@redhat.com;
> > dgilbert@redhat.com; quintela@redhat.com; Liujinsong (Paul)
> > <liu.jinsong@huawei.com>; linfeng (M) <linfeng23@huawei.com>; wangxin (U)
> > <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > <weidong.huang@huawei.com>
> > Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
> >
> > On Wed, Feb 19, 2020 at 01:19:08PM +0000, Zhoujian (jay) wrote:
> > > Hi Peter,
> > >
> > > > -----Original Message-----
> > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > Sent: Wednesday, February 19, 2020 1:43 AM
> > > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > > Cc: kvm@vger.kernel.org; qemu-devel@nongnu.org;
> > pbonzini@redhat.com;
> > > > dgilbert@redhat.com; quintela@redhat.com; Liujinsong (Paul)
> > > > <liu.jinsong@huawei.com>; linfeng (M) <linfeng23@huawei.com>;
> > > > wangxin (U) <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > > > <weidong.huang@huawei.com>
> > > > Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
> > > >
> > > > On Tue, Feb 18, 2020 at 01:13:47PM +0000, Zhoujian (jay) wrote:
> > > > > Hi all,
> > > > >
> > > > > We found that the guest will be soft-lockup occasionally when live
> > > > > migrating a 60 vCPU, 512GiB huge page and memory sensitive VM. The
> > > > > reason is clear, almost all of the vCPUs are waiting for the KVM
> > > > > MMU spin-lock to create 4K SPTEs when the huge pages are write
> > > > > protected. This
> > > > phenomenon is also described in this patch set:
> > > > > https://patchwork.kernel.org/cover/11163459/
> > > > > which aims to handle page faults in parallel more efficiently.
> > > > >
> > > > > Our idea is to use the migration thread to touch all of the guest
> > > > > memory in the granularity of 4K before enabling dirty logging. To
> > > > > be more specific, we split all the PDPE_LEVEL SPTEs into
> > > > > DIRECTORY_LEVEL SPTEs as the first step, and then split all the
> > > > > DIRECTORY_LEVEL SPTEs into
> > > > PAGE_TABLE_LEVEL SPTEs as the following step.
> > > >
> > > > IIUC, QEMU will prefer to use huge pages for all the anonymous
> > > > ramblocks (please refer to ram_block_add):
> > > >
> > > >         qemu_madvise(new_block->host, new_block->max_length,
> > > > QEMU_MADV_HUGEPAGE);
> > >
> > > Yes, you're right
> > >
> > > >
> > > > Another alternative I can think of is to add an extra parameter to
> > > > QEMU to explicitly disable huge pages (so that can even be
> > > > MADV_NOHUGEPAGE instead of MADV_HUGEPAGE).  However that
> > should also
> > > > drag down the performance for the whole lifecycle of the VM.
> > >
> > > From the performance point of view, it is better to keep the huge
> > > pages when the VM is not in the live migration state.
> > >
> > > > A 3rd option is to make a QMP
> > > > command to dynamically turn huge pages on/off for ramblocks globally.
> > >
> > > We're searching a dynamic method too.
> > > We plan to add two new flags for each memory slot, say
> > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES and
> > > KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES. These flags can be set through
> > > KVM_SET_USER_MEMORY_REGION ioctl.
> > >
> > > The mapping_level which is called by tdp_page_fault in the kernel side
> > > will return PT_DIRECTORY_LEVEL if the
> > KVM_MEM_FORCE_PT_DIRECTORY_PAGES
> > > flag of the memory slot is set, and return PT_PAGE_TABLE_LEVEL if the
> > > KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES flag is set.
> > >
> > > The key steps to split the huge pages in advance of enabling dirty log
> > > is as follows:
> > > 1. The migration thread in user space uses
> > KVM_SET_USER_MEMORY_REGION
> > > ioctl to set the KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag for each
> > memory
> > > slot.
> > > 2. The migration thread continues to use the KVM_SPLIT_HUGE_PAGES
> > > ioctl (which is newly added) to do the splitting of large pages in the
> > > kernel side.
> > > 3. A new vCPU is created temporally(do some initialization but will
> > > not
> > > run) to help to do the work, i.e. as the parameter of the tdp_page_fault.
> > > 4. Collect the GPA ranges of all the memory slots with the
> > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag set.
> > > 5. Split the 1G huge pages(collected in step 4) into 2M by calling
> > > tdp_page_fault, since the mapping_level will return
> > > PT_DIRECTORY_LEVEL. Here is the main difference from the usual path
> > > which is caused by the Guest side(EPT violation/misconfig etc), we
> > > call it directly in the hypervisor side.
> > > 6. Do some cleanups, i.e. free the vCPU related resources 7. The
> > > KVM_SPLIT_HUGE_PAGES ioctl returned to the user space side.
> > > 8. Using KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES instread of
> > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES to repeat step 1 ~ step 7, in step
> > 5
> > > the 2M huge pages will be splitted into 4K pages.
> > > 9. Clear the KVM_MEM_FORCE_PT_DIRECTORY_PAGES and
> > > KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES flags for each memory slot.
> > > 10. Then the migration thread calls the log_start ioctl to enable the
> > > dirty logging, and the remaining thing is the same.
> >
> > I'm not sure... I think it would be good if there is a way to have finer granularity
> > control on using huge pages for any process, then KVM can directly leverage
> > that because KVM page tables should always respect the mm configurations on
> > these (so e.g. when huge page split, KVM gets notifications via mmu notifiers).
> > Have you thought of such a more general way?
>
> I did have thought of this, if we split the huge pages into 4K of a process, I'm
> afraid it will not be workable for the huge pages sharing scenario, e.g. DPDK,
> SPDK etc. So, only split the EPT page table and keep the VM process page table
> (e.g. qemu) untouched is the goal.
>
> >
> > (And I just noticed that MADV_NOHUGEPAGE is only a hint to khugepaged
> > and probably won't split any huge page at all after madvise() returns..)
> > To tell the truth I'm still confused on how split of huge pages helped in your
> > case...
>
> I'm sorry if the meaning is not expressed clearly, and thanks for your patience.
>
> > If I read it right the test reduced some execution time from 9s to a
> > few ms after your splittion of huge pages.
>
> Yes
>
> > The thing is I don't see how split of
> > huge pages could solve the mmu_lock contention with the huge VM, because
> > IMO even if we split the huge pages into smaller ones, those pages should still
> > be write-protected and need merely the same number of page faults to resolve
> > when accessed/written? And I thought that should only be fixed with
> > solutions like what Ben has proposed with the MMU rework. Could you show
> > me what I've missed?
>
> Let me try to describe the reason of mmu_lock contention more clearly and the
> effort we tried to do...
> The huge VM only has EPT >= level 2 sptes, and level 1 sptes don't
> exist at the beginning. Write protect all the huge pages will trigger EPT
> violation to create level 1 sptes for all the vCPUs which want to write the
> content of the memory. Different vCPU write the different areas of
> the memory, but they need the same kvm->mmu_lock to create the level 1
> sptes, this situation will be worse if the number of vCPU and the memory of
> VM is large(in our case 60U512G), meanwhile the VM has
> memory-write-intensive work to do. In order to reduce the mmu_lock
> contention, we try to: write protect VM memory gradually in small chunks,
> such as 1G or 2M. Using a vCPU temporary creately by migration thread to
> split 1G to 2M as the first step, and to split 2M to 4K as the second step
> (this is a little hacking...and I do not know any side effect will be triggered
> indeed).
> Comparing to write protect all VM memory in one go, the write
> protected range is limited in this way and only the vCPUs write this limited
> range will be involved to take the mmu_lock. The contention will be reduced
> since the memory range is small and the number of vCPU involved is small
> too.
>
> Of course, it will take some extra time to split all the huge pages into 4K
> page before the real migration started, about 60s for 512G in my experiment.
>
> During the memory iterative copy phase, PML will do the dirty logging work
> (not write protected case for 4K), or IIRC using fast_page_fault to mark page
> dirty if PML is not supported, which case the mmu_lock does not needed.
>
> Regards,
> Jay Zhou

(Ah I top-posted I'm sorry. Re-sending at the bottom.)

FWIW, we currently do this eager splitting at Google for live
migration. When the log-dirty-memory flag is set on a memslot we
eagerly split all pages in the slot down to 4k granularity.
As Jay said, this does not cause crippling lock contention because the
vCPU page faults generated by write protection / splitting can be
resolved in the fast page fault path without acquiring the MMU lock.
I believe +Junaid Shahid tried to upstream this approach at some point
in the past, but the patch set didn't make it in. (This was before my
time, so I'm hoping he has a link.)
I haven't done the analysis to know if eager splitting is more or less
efficient with parallel slow-path page faults, but it's definitely
faster under the MMU lock.

