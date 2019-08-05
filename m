Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D7EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2EC20B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2EC20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huYlw-0002GA-TK
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 04:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1huYlV-0001oy-Ir
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1huYlU-0007FU-Cb
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1huYlU-0007Es-4c; Mon, 05 Aug 2019 04:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4B5C308212F;
 Mon,  5 Aug 2019 08:54:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B96C760603;
 Mon,  5 Aug 2019 08:54:41 +0000 (UTC)
Date: Mon, 5 Aug 2019 10:54:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190805105440.33c4dc8a@redhat.com>
In-Reply-To: <eb897214-2625-1a44-2709-e33560256480@de.ibm.com>
References: <20190802133241.29298-1-imammedo@redhat.com>
 <8318d96d-3130-f7ba-0b3c-5c0da8535d80@de.ibm.com>
 <2bff9895-f60f-1aba-2d22-943af53003c2@de.ibm.com>
 <eb897214-2625-1a44-2709-e33560256480@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 05 Aug 2019 08:54:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v3 0/2] s390: stop abusing
 memory_region_allocate_system_memory()
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 17:04:21 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.08.19 16:59, Christian Borntraeger wrote:
> > 
> > 
> > On 02.08.19 16:42, Christian Borntraeger wrote:  
> >> On 02.08.19 15:32, Igor Mammedov wrote:  
> >>> Changelog:
> >>>   since v2:
> >>>     - break migration from old QEMU (since 2.12-4.1) for guest with >8TB RAM
> >>>       and drop migratable aliases patch as was agreed during v2 review
> >>>     - drop 4.2 machines patch as it's not prerequisite anymore
> >>>   since v1:
> >>>     - include 4.2 machines patch for adding compat RAM layout on top
> >>>     - 2/4 add missing in v1 patch for splitting too big MemorySection on
> >>>           several memslots
> >>>     - 3/4 amend code path on alias destruction to ensure that RAMBlock is
> >>>           cleaned properly
> >>>     - 4/4 add compat machine code to keep old layout (migration-wise) for
> >>>           4.1 and older machines 
> >>>
> >>>
> >>> While looking into unifying guest RAM allocation to use hostmem backends
> >>> for initial RAM (especially when -mempath is used) and retiring
> >>> memory_region_allocate_system_memory() API, leaving only single hostmem backend,
> >>> I was inspecting how currently it is used by boards and it turns out several
> >>> boards abuse it by calling the function several times (despite documented contract
> >>> forbiding it).
> >>>
> >>> s390 is one of such boards where KVM limitation on memslot size got propagated
> >>> to board design and memory_region_allocate_system_memory() was abused to satisfy
> >>> KVM requirement for max RAM chunk where memory region alias would suffice.
> >>>
> >>> Unfortunately, memory_region_allocate_system_memory() usage created migration
> >>> dependency where guest RAM is transferred in migration stream as several RAMBlocks
> >>> if it's more than KVM_SLOT_MAX_BYTES. During v2 review it was agreed to ignore
> >>> migration breakage (documenting it in release notes) and leaving only KVM fix.
> >>>
> >>> In order to replace these several RAM chunks with a single memdev and keep it
> >>> working with KVM memslot size limit, following was done:
> >>>    * [1/2] split too big RAM chunk inside of KVM code on several memory slots
> >>>            if necessary
> >>>    * [2/2] drop manual ram splitting in s390 code
> >>>
> >>>
> >>> CC: pbonzini@redhat.com
> >>> CC: qemu-s390x@nongnu.org
> >>> CC: borntraeger@de.ibm.com
> >>> CC: thuth@redhat.com
> >>> CC: david@redhat.com
> >>> CC: cohuck@redhat.com  
> >>
> >> With the fixup this patch set seems to work on s390. I can start 9TB guests and
> >> I can migrate smaller guests between 4.1+patch and 4.0 and 3.1. I currently can
> >> not test migration for the 9TB guest due to lack of a 2nd system.   
> > 
> > I have to correct myself. The 9TB guest started up but it does not seem to do
> > anything useful (it hangs).  
> 
> Seems that the userspace addr is wrong (its the same). 
> [pid 258234] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=8796091973632, userspace_addr=0x3fff7d00000}) = 0
> [pid 258234] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=1, flags=0, guest_phys_addr=0x7fffff00000, memory_size=1099512676352, userspace_addr=0x3fff7d00000}) = 0

It's a bug in 1/2, I forgot to advance mem->ram along with mem->start_addr.
Let me fix it and simulate it on small s390 host (/me sorry for messy patches)
it won't test migration properly but should be sufficient for testing KVM code patch.


