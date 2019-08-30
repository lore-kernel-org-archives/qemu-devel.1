Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A5C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18BC21670
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18BC21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3dRE-0000VD-1M
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 05:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i3dPJ-00080i-UH
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i3dP9-0006a3-H3
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i3dP9-0006Mk-7Q; Fri, 30 Aug 2019 05:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2DEF10C6979;
 Fri, 30 Aug 2019 09:41:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD52060872;
 Fri, 30 Aug 2019 09:41:06 +0000 (UTC)
Date: Fri, 30 Aug 2019 11:41:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190830114105.312cf69f@redhat.com>
In-Reply-To: <ff7b7534-e954-84f2-34a9-bfa0ac37c8fe@de.ibm.com>
References: <20190806094834.7691-2-imammedo@redhat.com>
 <20190807153241.24050-1-imammedo@redhat.com>
 <20190820180727.32cf4891.cohuck@redhat.com>
 <20190827145629.62c5839e@redhat.com>
 <0abe612b-5a00-4ebc-9874-6b794d411f51@de.ibm.com>
 <20190829140402.3a547a76@redhat.com>
 <6afa8d99-c958-6f60-69f4-f84151358479@de.ibm.com>
 <20190829143125.17a44fa5@redhat.com>
 <ff7b7534-e954-84f2-34a9-bfa0ac37c8fe@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 30 Aug 2019 09:41:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.2 v5 1/2] kvm: s390:
 split too big memory section on several memslots
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

On Thu, 29 Aug 2019 14:41:13 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 29.08.19 14:31, Igor Mammedov wrote:
> > On Thu, 29 Aug 2019 14:07:44 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 29.08.19 14:04, Igor Mammedov wrote:  
> >>> On Thu, 29 Aug 2019 08:47:49 +0200
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>     
> >>>> On 27.08.19 14:56, Igor Mammedov wrote:    
> >>>>> On Tue, 20 Aug 2019 18:07:27 +0200
> >>>>> Cornelia Huck <cohuck@redhat.com> wrote:
> >>>>>       
> >>>>>> On Wed,  7 Aug 2019 11:32:41 -0400
> >>>>>> Igor Mammedov <imammedo@redhat.com> wrote:
> >>>>>>      
> >>>>>>> Max memslot size supported by kvm on s390 is 8Tb,
> >>>>>>> move logic of splitting RAM in chunks upto 8T to KVM code.
> >>>>>>>
> >>>>>>> This way it will hide KVM specific restrictions in KVM code
> >>>>>>> and won't affect baord level design decisions. Which would allow
> >>>>>>> us to avoid misusing memory_region_allocate_system_memory() API
> >>>>>>> and eventually use a single hostmem backend for guest RAM.
> >>>>>>>
> >>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>>>>> ---
> >>>>>>> v5:
> >>>>>>>   * move computation 'size -= slot_size' inside of loop body
> >>>>>>>           (David Hildenbrand <david@redhat.com>)
> >>>>>>> v4:
> >>>>>>>   * fix compilation issue
> >>>>>>>           (Christian Borntraeger <borntraeger@de.ibm.com>)
> >>>>>>>   * advance HVA along with GPA in kvm_set_phys_mem()
> >>>>>>>           (Christian Borntraeger <borntraeger@de.ibm.com>)
> >>>>>>>
> >>>>>>> patch prepares only KVM side for switching to single RAM memory region
> >>>>>>> another patch will take care of  dropping manual RAM partitioning in
> >>>>>>> s390 code.        
> >>>>>>
> >>>>>> I may have lost track a bit -- what is the status of this patch (and
> >>>>>> the series)?      
> >>>>>
> >>>>> Christian,
> >>>>>
> >>>>> could you test it on a host that have sufficient amount of RAM?      
> >>>>
> >>>>
> >>>> This version looks good. I was able to start a 9TB guest.
> >>>> [pid 215723] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=8796091973632, userspace_addr=0x3ffee700000}) = 0
> >>>> [pid 215723] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=1, flags=0, guest_phys_addr=0x7fffff00000, memory_size=1099512676352, userspace_addr=0xbffee600000}) = 0  
> >>  
> >>>> The only question is if we want to fix the weird alignment (0x7fffff00000) when
> >>>> we already add a migration barrier for uber-large guests.
> >>>> Maybe we could split at 4TB to avoid future problem with larger page sizes?    
> >>> That probably should be a separate patch on top.    
> >>
> >> Right. The split in KVM code is transparent to migration and other parts of QEMU, correct?  
> > 
> > it should not affect other QEMU parts and migration (to my limited understanding of it),
> > we are passing to KVM memory slots upto KVM_SLOT_MAX_BYTES as we were doing before by
> > creating several memory regions instead of one as described in [2/2] commit message.
> > 
> > Also could you also test migration of +9Tb guest, to check that nothing where broken by
> > accident in QEMU migration code?  
> 
> I only have one server that is large enough :-/
Could you test offline migration on it (to a file and restore from it)?


