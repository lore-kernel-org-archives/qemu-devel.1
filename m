Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C9C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63F22083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63F22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErLa-0000ht-29
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:15:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hErKT-0008Su-K6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hErKS-0004zw-9q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:14:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hErKP-0004xU-3w; Fri, 12 Apr 2019 04:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFCB558569;
	Fri, 12 Apr 2019 08:14:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82156183DF;
	Fri, 12 Apr 2019 08:14:22 +0000 (UTC)
Date: Fri, 12 Apr 2019 10:14:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190412101418.616f1b30@redhat.com>
In-Reply-To: <20190412054407.GA5035@richard>
References: <20190313044253.31988-1-richardw.yang@linux.intel.com>
	<20190313044253.31988-4-richardw.yang@linux.intel.com>
	<20190313132300.3f56a5ca@redhat.com>
	<20190313133359.h2njohyijgvkcbtv@master>
	<20190313170943.5384f5cf@redhat.com>
	<20190402035343.GA6527@richard>
	<20190402081512.6194a58f@redhat.com>
	<20190405085529.GA24071@richard>
	<20190409165415.2e5df0c6@redhat.com>
	<20190412054407.GA5035@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 12 Apr 2019 08:14:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] hw/acpi: Extract build_mcfg
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
	qemu-devel@nongnu.org, Wei Yang <richard.weiyang@gmail.com>,
	shannon.zhaosl@gmail.com, wei.w.wang@intel.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412081418.jhSVUoKyZwin057lxQnWomBpahYV20Vxnbv0taUijEo@z>

On Fri, 12 Apr 2019 13:44:07 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Tue, Apr 09, 2019 at 04:54:15PM +0200, Igor Mammedov wrote:
> >> 
> >> Let's see a normal hotplug case first. 
> >> 
> >>     I did one test to see the how a guest with hot-plug cpu migrate to
> >>     destination.  It looks the migration fails if I just do hot-plug at
> >>     source. So I have to do hot-plug both at source and at destination. This
> >>     will expand the table_mr both at source and destination.
> >> 
> >> Then let's see the effect of hotplug more devices to exceed original padded
> >> size. There are two cases, before re-sizable MemoryRegion and after.
> >> 
> >> 1) Before re-sizable MemoryRegion introduced
> >> 
> >>     Before re-sizable MemoryRegion introduced, we just pad table_mr to 4K. And
> >>     this size never gets bigger, if I am right. To be accurate, the table_blob
> >>     would grow to next padded size if we hot-add more cpus/pci bridge, but we
> >>     just copy the original size of MemoryRegion. Even without migration, the
> >>     ACPI table is corrupted when we expand to next padded size.
> >>     
> >>     Is my understanding correct here?
> >> 
> >> 2) After re-sizable MemoryRegion introduced
> >> 
> >>     This time both tabl_blob and MemoryRegion grows when it expand to next
> >>     padded size. Since we need to hot-add device at both side, ACPI table
> >>     grows at the same pace.
> >> 
> >>     Every thing looks good, until one of it exceed the resizable
> >>     MemoryRegion's max size. (Not sure this is possible in reality, while
> >>     possible in theory). Actually, this looks like case 1) when resizable
> >>     MemoryRegion is not introduced. The too big ACPI table get corrupted.
> >> 
> >> So if my understanding is correct, the procedure you mentioned "expand from
> >> initial padded size to next padded size" only applies to two different max
> >> size resizable MemoryRegion. For other cases, the procedure corrupt the ACPI
> >> table itself.
> >> 
> >> Then when we look at
> >> 
> >>     commit 07fb61760cdea7c3f1b9c897513986945bca8e89
> >>     Author: Paolo Bonzini <pbonzini@redhat.com>
> >>     Date:   Mon Jul 28 17:34:15 2014 +0200
> >>     
> >>         pc: hack for migration compatibility from QEMU 2.0
> >>     
> >> This fix ACPI migration issue before resizable MemoryRegion is
> >> introduced(introduced in 2015-01-08). This looks expand to next padded size
> >> always corrupt ACPI table at that time. And it make me think expand to next
> >> padded size is not the procedure we should do?
> >> 
> >> And my colleague Wei Wang(in cc) mentioned, to make migration succeed, the
> >> MemoryRegion has to be the same size at both side. So I guess the problem
> >> doesn't lie in hotplug but in "main table" size difference.  
> >
> >It's true only for pre-resizable MemoryRegion QEMU versions,
> >after that size doesn't affect migration anymore.
> >
> >  
> >> For example, we have two version of Qemu: v1 and v2. Their "main table" size
> >> is:
> >> 
> >>     v1: 3990
> >>     v2: 4020
> >> 
> >> At this point, their ACPI table all padded to 4k, which is the same.
> >> 
> >> Then we create a machine with 1 more vcpu by these two versions. This will
> >> expand the table to:
> >> 
> >>     v1: 4095
> >>     v2: 4125
> >> 
> >> After padding, v1's ACPI table size is still 4k but v2's is 8k. Now the
> >> migration is broken.
> >> 
> >> If this analysis is correct, the relationship between migration failure and
> >> ACPI table is "the change of ACPI table size". Any size change of any  
> >you should make distinction between used_length and max_length here.
> >Migration puts on wire used_length and that's what matter for keeping migration
> >working.
> >  
> >> ACPI table would break migration. While of course, since we pad the table,
> >> only some combinations of tables would result in a visible real size change in
> >> MemoryRegion.
> >> 
> >> Then the principle for future ACPI development is to keep all ACPI table size
> >> unchanged.  
> >once again it applies only for QEMU (versions < 2.1) and that was
> >the problem (i.e. there always would be configurations that would create
> >differently sized tables regardless of arbitrary size we would preallocate)
> >resizable MemoryRegions solved.
> >   
> >> Now let's back to mcfg table. As the comment mentioned, guest could
> >> enable/disable MCFG, so the code here reserve table no matter it is enabled or
> >> not. This behavior ensures ACPI table size not changed. So do we need to find
> >> the machine type as you suggested before?  
> >We should be able to drop mcgf 'padding' hack since machine version
> >which was introduced in the QEMU version that introduced resizable MemoryRegion
> >as well.
> >
> >I'll send a patch to address that  
> 
> Hi, Igor,
> 
> We have found the qemu version 2.1 which is with resizable MemoryRegion
> enabled and q35 will stop support version before 2.3. The concern about ACPI
> mcfg table breaking live migration is solved, right?
> 
> If so, I would prepare mcfg refactor patch based on your cleanup.
yes, just base your patches on top of
 "[PATCH for-4.1] q35: acpi: do not create dummy MCFG  table"


