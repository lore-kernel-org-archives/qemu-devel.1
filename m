Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D10CC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D45A2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpXTaPf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D45A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4qOr-000519-A1
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 13:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4qO3-0004OL-Mj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4qO0-0000rP-Mb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:17:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4qO0-0000pB-DG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582222638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OxJZ6x6LNPFDyJeyWImBaOUHp+JSLASzATkkwo/5v4=;
 b=SpXTaPf7t2MmG7R6yt7iAchtB1TePP2s9zNTNcpIAbBv7evdbEqMvZjPku9CUwcMmOU6yp
 Dz7iPcprMO4LQSLyFrNwLQ8vVcZL/0BHSPNduskWNxAahAmetqg55fU24hEskUZOn5vkGD
 tpHMlY4D9o+v7z5CnS2tZH6waG/JAak=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-zsT8lQpvPjmJuLqCwbgCKQ-1; Thu, 20 Feb 2020 13:17:11 -0500
Received: by mail-qv1-f69.google.com with SMTP id z39so3160236qve.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 10:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7gBF2N544JSN/FzCwCeXpyEHqdoVMntz2vXwRjWtmEI=;
 b=sZxu9oM7uKI37VkRoPiLxh17BKOTgsNV3e7KLrbVS+mdB8GaWZl4eFrwnKm99P6OO6
 hlqwE+J8luSOR/dPm4wlXMGtTt47Ox0bqepDawXYLbrjKiq6ZoNi+aNVI891I3Fv+xlg
 jxQG2NNJPCRgAQk9wNgIPtrRV0QX9A4Lphl5JbVn1X10S7kAJ87gYoI1xHVhGQX90ZzD
 ZTQRZeFXKm86P3Nk+31fw3qNNbj5jatcZavfy6Rfn8AXSOT9asxxoWHgSJ9nZCXG/Mon
 lDMhMusmyQCzDIWN3xdPsY6Pvy/XCd6dErKaWpDi7YFpWpeGevAgbsOQ6Muh6OwU56hx
 JqLw==
X-Gm-Message-State: APjAAAXOqcEk3LOFt8EMqoYcf3Dxx/NkjEVyIN2vThMBtX2xbGPg5OVH
 n7/htDKja0sYfPNuV3jPRAR99wO9cQrGjbnj9DeuxbitzLAk4zOkbDoLaVC4t4JxzXMR+tuSFjC
 EeEei/fyxh/RdMwA=
X-Received: by 2002:ac8:7357:: with SMTP id q23mr27542953qtp.12.1582222631391; 
 Thu, 20 Feb 2020 10:17:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwT0HHbreNyVDlJS26f97XEMXnHSFkHwOsSV8EcdlPgss+q/+5S5IeR5NHI/m4ACr8pZbsqqA==
X-Received: by 2002:ac8:7357:: with SMTP id q23mr27542919qtp.12.1582222631052; 
 Thu, 20 Feb 2020 10:17:11 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id b84sm182610qkc.73.2020.02.20.10.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 10:17:09 -0800 (PST)
Date: Thu, 20 Feb 2020 13:17:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Ben Gardon <bgardon@google.com>
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
Message-ID: <20200220181708.GE2905@xz-x1>
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
 <20200219171919.GA34517@xz-x1>
 <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
 <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
X-MC-Unique: zsT8lQpvPjmJuLqCwbgCKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Junaid Shahid <junaids@google.com>,
 "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "linfeng \(M\)" <linfeng23@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zhoujian \(jay\)" <jianjay.zhou@huawei.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 09:34:52AM -0800, Ben Gardon wrote:
> On Thu, Feb 20, 2020 at 5:53 AM Zhoujian (jay) <jianjay.zhou@huawei.com> =
wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Peter Xu [mailto:peterx@redhat.com]
> > > Sent: Thursday, February 20, 2020 1:19 AM
> > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > Cc: kvm@vger.kernel.org; qemu-devel@nongnu.org; pbonzini@redhat.com;
> > > dgilbert@redhat.com; quintela@redhat.com; Liujinsong (Paul)
> > > <liu.jinsong@huawei.com>; linfeng (M) <linfeng23@huawei.com>; wangxin=
 (U)
> > > <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > > <weidong.huang@huawei.com>
> > > Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
> > >
> > > On Wed, Feb 19, 2020 at 01:19:08PM +0000, Zhoujian (jay) wrote:
> > > > Hi Peter,
> > > >
> > > > > -----Original Message-----
> > > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > > Sent: Wednesday, February 19, 2020 1:43 AM
> > > > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > > > Cc: kvm@vger.kernel.org; qemu-devel@nongnu.org;
> > > pbonzini@redhat.com;
> > > > > dgilbert@redhat.com; quintela@redhat.com; Liujinsong (Paul)
> > > > > <liu.jinsong@huawei.com>; linfeng (M) <linfeng23@huawei.com>;
> > > > > wangxin (U) <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > > > > <weidong.huang@huawei.com>
> > > > > Subject: Re: RFC: Split EPT huge pages in advance of dirty loggin=
g
> > > > >
> > > > > On Tue, Feb 18, 2020 at 01:13:47PM +0000, Zhoujian (jay) wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > We found that the guest will be soft-lockup occasionally when l=
ive
> > > > > > migrating a 60 vCPU, 512GiB huge page and memory sensitive VM. =
The
> > > > > > reason is clear, almost all of the vCPUs are waiting for the KV=
M
> > > > > > MMU spin-lock to create 4K SPTEs when the huge pages are write
> > > > > > protected. This
> > > > > phenomenon is also described in this patch set:
> > > > > > https://patchwork.kernel.org/cover/11163459/
> > > > > > which aims to handle page faults in parallel more efficiently.
> > > > > >
> > > > > > Our idea is to use the migration thread to touch all of the gue=
st
> > > > > > memory in the granularity of 4K before enabling dirty logging. =
To
> > > > > > be more specific, we split all the PDPE_LEVEL SPTEs into
> > > > > > DIRECTORY_LEVEL SPTEs as the first step, and then split all the
> > > > > > DIRECTORY_LEVEL SPTEs into
> > > > > PAGE_TABLE_LEVEL SPTEs as the following step.
> > > > >
> > > > > IIUC, QEMU will prefer to use huge pages for all the anonymous
> > > > > ramblocks (please refer to ram_block_add):
> > > > >
> > > > >         qemu_madvise(new_block->host, new_block->max_length,
> > > > > QEMU_MADV_HUGEPAGE);
> > > >
> > > > Yes, you're right
> > > >
> > > > >
> > > > > Another alternative I can think of is to add an extra parameter t=
o
> > > > > QEMU to explicitly disable huge pages (so that can even be
> > > > > MADV_NOHUGEPAGE instead of MADV_HUGEPAGE).  However that
> > > should also
> > > > > drag down the performance for the whole lifecycle of the VM.
> > > >
> > > > From the performance point of view, it is better to keep the huge
> > > > pages when the VM is not in the live migration state.
> > > >
> > > > > A 3rd option is to make a QMP
> > > > > command to dynamically turn huge pages on/off for ramblocks globa=
lly.
> > > >
> > > > We're searching a dynamic method too.
> > > > We plan to add two new flags for each memory slot, say
> > > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES and
> > > > KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES. These flags can be set through
> > > > KVM_SET_USER_MEMORY_REGION ioctl.

[1]

> > > >
> > > > The mapping_level which is called by tdp_page_fault in the kernel s=
ide
> > > > will return PT_DIRECTORY_LEVEL if the
> > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES
> > > > flag of the memory slot is set, and return PT_PAGE_TABLE_LEVEL if t=
he
> > > > KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES flag is set.
> > > >
> > > > The key steps to split the huge pages in advance of enabling dirty =
log
> > > > is as follows:
> > > > 1. The migration thread in user space uses
> > > KVM_SET_USER_MEMORY_REGION
> > > > ioctl to set the KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag for each
> > > memory
> > > > slot.
> > > > 2. The migration thread continues to use the KVM_SPLIT_HUGE_PAGES
> > > > ioctl (which is newly added) to do the splitting of large pages in =
the
> > > > kernel side.
> > > > 3. A new vCPU is created temporally(do some initialization but will
> > > > not
> > > > run) to help to do the work, i.e. as the parameter of the tdp_page_=
fault.
> > > > 4. Collect the GPA ranges of all the memory slots with the
> > > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES flag set.
> > > > 5. Split the 1G huge pages(collected in step 4) into 2M by calling
> > > > tdp_page_fault, since the mapping_level will return
> > > > PT_DIRECTORY_LEVEL. Here is the main difference from the usual path
> > > > which is caused by the Guest side(EPT violation/misconfig etc), we
> > > > call it directly in the hypervisor side.
> > > > 6. Do some cleanups, i.e. free the vCPU related resources 7. The
> > > > KVM_SPLIT_HUGE_PAGES ioctl returned to the user space side.
> > > > 8. Using KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES instread of
> > > > KVM_MEM_FORCE_PT_DIRECTORY_PAGES to repeat step 1 ~ step 7, in step
> > > 5
> > > > the 2M huge pages will be splitted into 4K pages.
> > > > 9. Clear the KVM_MEM_FORCE_PT_DIRECTORY_PAGES and
> > > > KVM_MEM_FORCE_PT_PAGE_TABLE_PAGES flags for each memory slot.
> > > > 10. Then the migration thread calls the log_start ioctl to enable t=
he
> > > > dirty logging, and the remaining thing is the same.
> > >
> > > I'm not sure... I think it would be good if there is a way to have fi=
ner granularity
> > > control on using huge pages for any process, then KVM can directly le=
verage
> > > that because KVM page tables should always respect the mm configurati=
ons on
> > > these (so e.g. when huge page split, KVM gets notifications via mmu n=
otifiers).
> > > Have you thought of such a more general way?
> >
> > I did have thought of this, if we split the huge pages into 4K of a pro=
cess, I'm
> > afraid it will not be workable for the huge pages sharing scenario, e.g=
. DPDK,
> > SPDK etc. So, only split the EPT page table and keep the VM process pag=
e table
> > (e.g. qemu) untouched is the goal.

Ah I see your point now.

> >
> > >
> > > (And I just noticed that MADV_NOHUGEPAGE is only a hint to khugepaged
> > > and probably won't split any huge page at all after madvise() returns=
..)
> > > To tell the truth I'm still confused on how split of huge pages helpe=
d in your
> > > case...
> >
> > I'm sorry if the meaning is not expressed clearly, and thanks for your =
patience.
> >
> > > If I read it right the test reduced some execution time from 9s to a
> > > few ms after your splittion of huge pages.
> >
> > Yes
> >
> > > The thing is I don't see how split of
> > > huge pages could solve the mmu_lock contention with the huge VM, beca=
use
> > > IMO even if we split the huge pages into smaller ones, those pages sh=
ould still
> > > be write-protected and need merely the same number of page faults to =
resolve
> > > when accessed/written? And I thought that should only be fixed with
> > > solutions like what Ben has proposed with the MMU rework. Could you s=
how
> > > me what I've missed?
> >
> > Let me try to describe the reason of mmu_lock contention more clearly a=
nd the
> > effort we tried to do...
> > The huge VM only has EPT >=3D level 2 sptes, and level 1 sptes don't
> > exist at the beginning. Write protect all the huge pages will trigger E=
PT
> > violation to create level 1 sptes for all the vCPUs which want to write=
 the
> > content of the memory. Different vCPU write the different areas of
> > the memory, but they need the same kvm->mmu_lock to create the level 1
> > sptes, this situation will be worse if the number of vCPU and the memor=
y of
> > VM is large(in our case 60U512G), meanwhile the VM has
> > memory-write-intensive work to do. In order to reduce the mmu_lock
> > contention, we try to: write protect VM memory gradually in small chunk=
s,
> > such as 1G or 2M. Using a vCPU temporary creately by migration thread t=
o
> > split 1G to 2M as the first step, and to split 2M to 4K as the second s=
tep
> > (this is a little hacking...and I do not know any side effect will be t=
riggered
> > indeed).
> > Comparing to write protect all VM memory in one go, the write
> > protected range is limited in this way and only the vCPUs write this li=
mited
> > range will be involved to take the mmu_lock. The contention will be red=
uced
> > since the memory range is small and the number of vCPU involved is smal=
l
> > too.
> >
> > Of course, it will take some extra time to split all the huge pages int=
o 4K
> > page before the real migration started, about 60s for 512G in my experi=
ment.
> >
> > During the memory iterative copy phase, PML will do the dirty logging w=
ork
> > (not write protected case for 4K), or IIRC using fast_page_fault to mar=
k page
> > dirty if PML is not supported, which case the mmu_lock does not needed.

Yes I missed both of these.  Thanks for explaining!

Then it makes sense at least to me with your idea. Though instead of
the KVM_MEM_FORCE_PT_* naming [1], we can also embed allowed page
sizes for the memslot into the flags using a few bits, with another
new kvm cap.

> >
> > Regards,
> > Jay Zhou
>=20
> (Ah I top-posted I'm sorry. Re-sending at the bottom.)
>=20
> FWIW, we currently do this eager splitting at Google for live
> migration. When the log-dirty-memory flag is set on a memslot we
> eagerly split all pages in the slot down to 4k granularity.
> As Jay said, this does not cause crippling lock contention because the
> vCPU page faults generated by write protection / splitting can be
> resolved in the fast page fault path without acquiring the MMU lock.
> I believe +Junaid Shahid tried to upstream this approach at some point
> in the past, but the patch set didn't make it in. (This was before my
> time, so I'm hoping he has a link.)
> I haven't done the analysis to know if eager splitting is more or less
> efficient with parallel slow-path page faults, but it's definitely
> faster under the MMU lock.

Yes, totally agreed.  Though comparing to eager splitting (which might
still need a new capabilility for the changed behavior after all, not
sure...), the per-memslot hint solution looks slightly nicer to me,
imho, because it can offer more mechanism than policy.

Thanks,

--=20
Peter Xu


