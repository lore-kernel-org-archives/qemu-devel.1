Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270DC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5857D2183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5857D2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5kU-00029e-GJ
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:02:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH5jY-0001dJ-Jw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH5jQ-0005dm-KE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:01:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hH5jP-0005aG-Uf; Thu, 18 Apr 2019 08:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41CC1C068BE8;
	Thu, 18 Apr 2019 12:01:24 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CACAC1001DE1;
	Thu, 18 Apr 2019 12:01:20 +0000 (UTC)
Date: Thu, 18 Apr 2019 14:01:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190418140116.19596c6d@redhat.com>
In-Reply-To: <93d242cb-dcc4-a65d-a7c7-7232dd16a2f2@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
	<89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
	<20190418113859.00248d07@redhat.com>
	<93d242cb-dcc4-a65d-a7c7-7232dd16a2f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 18 Apr 2019 12:01:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418120116.KFEJpHzp9igU_WKYvb7_1wJi6BcK35YWQQGiwEqVYhQ@z>

On Thu, 18 Apr 2019 13:24:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 18.04.19 11:38, Igor Mammedov wrote:
> > On Tue, 16 Apr 2019 13:09:08 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> This fails with more than 8TB, e.g.  "-m 9T "
> >>
> >> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffc8500000}) = 0
> >> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=9895604649984, userspace_addr=0x3ffc8500000}) = -1 EINVAL (Invalid argument)
> >>
> >> seems that the 2nd memslot gets the full size (and not 9TB-size of first slot).  
> > 
> > it turns out MemoryRegions is rendered correctly in to 2 parts (one per alias),
> > but follow up flatview_simplify() collapses adjacent ranges back
> > into big one.  
> 
> That sounds dangerous. Imagine doing that at runtime (e.g. hotplugging a
> DIMM), the kvm memory slot would temporarily be deleted to insert the
> new, bigger one. Guest would crash. This could happen if backing memory
> of two DIMMs would by pure luck be allocated side by side in user space.
> 

not sure I fully get your concerns, but if you look at can_merge()
it ensures that ranges belong to the same MemoryRegion.

It's hard for me to say if flatview_simplify() works as designed,
MemoryRegion code is quite complicated so I'd deffer to Paolo's
opinion.

