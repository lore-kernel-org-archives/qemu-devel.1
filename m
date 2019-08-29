Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1CDC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33CC2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33CC2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3JAk-0006Gw-5o
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 08:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i3J9t-0005of-GD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i3J9q-0006nl-Sy
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i3J9q-0006jL-Eb; Thu, 29 Aug 2019 08:04:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AB1210F23F1;
 Thu, 29 Aug 2019 12:04:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4F6600C1;
 Thu, 29 Aug 2019 12:04:04 +0000 (UTC)
Date: Thu, 29 Aug 2019 14:04:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190829140402.3a547a76@redhat.com>
In-Reply-To: <0abe612b-5a00-4ebc-9874-6b794d411f51@de.ibm.com>
References: <20190806094834.7691-2-imammedo@redhat.com>
 <20190807153241.24050-1-imammedo@redhat.com>
 <20190820180727.32cf4891.cohuck@redhat.com>
 <20190827145629.62c5839e@redhat.com>
 <0abe612b-5a00-4ebc-9874-6b794d411f51@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 29 Aug 2019 12:04:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v5 1/2] kvm: s390: split too big
 memory section on several memslots
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
Cc: thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 08:47:49 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 27.08.19 14:56, Igor Mammedov wrote:
> > On Tue, 20 Aug 2019 18:07:27 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Wed,  7 Aug 2019 11:32:41 -0400
> >> Igor Mammedov <imammedo@redhat.com> wrote:
> >>  
> >>> Max memslot size supported by kvm on s390 is 8Tb,
> >>> move logic of splitting RAM in chunks upto 8T to KVM code.
> >>>
> >>> This way it will hide KVM specific restrictions in KVM code
> >>> and won't affect baord level design decisions. Which would allow
> >>> us to avoid misusing memory_region_allocate_system_memory() API
> >>> and eventually use a single hostmem backend for guest RAM.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>> v5:
> >>>   * move computation 'size -= slot_size' inside of loop body
> >>>           (David Hildenbrand <david@redhat.com>)
> >>> v4:
> >>>   * fix compilation issue
> >>>           (Christian Borntraeger <borntraeger@de.ibm.com>)
> >>>   * advance HVA along with GPA in kvm_set_phys_mem()
> >>>           (Christian Borntraeger <borntraeger@de.ibm.com>)
> >>>
> >>> patch prepares only KVM side for switching to single RAM memory region
> >>> another patch will take care of  dropping manual RAM partitioning in
> >>> s390 code.    
> >>
> >> I may have lost track a bit -- what is the status of this patch (and
> >> the series)?  
> > 
> > Christian,
> > 
> > could you test it on a host that have sufficient amount of RAM?  
> 
> 
> This version looks good. I was able to start a 9TB guest.
> [pid 215723] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=8796091973632, userspace_addr=0x3ffee700000}) = 0
> [pid 215723] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=1, flags=0, guest_phys_addr=0x7fffff00000, memory_size=1099512676352, userspace_addr=0xbffee600000}) = 0
>
> The only question is if we want to fix the weird alignment (0x7fffff00000) when
> we already add a migration barrier for uber-large guests.
> Maybe we could split at 4TB to avoid future problem with larger page sizes?
That probably should be a separate patch on top.


