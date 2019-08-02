Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FACC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33ED205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33ED205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTiW-00016t-4j
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1htThv-0000Fz-0c
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1htTht-0002mb-RD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1htTht-0002lE-Hu; Fri, 02 Aug 2019 05:18:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA8E6C0A4F4B;
 Fri,  2 Aug 2019 09:18:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 547916013A;
 Fri,  2 Aug 2019 09:18:32 +0000 (UTC)
Date: Fri, 2 Aug 2019 11:18:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190802111830.29636f24@redhat.com>
In-Reply-To: <63d203d2-25b5-44e6-ccee-1857396556f0@de.ibm.com>
References: <20190729145229.4333-1-imammedo@redhat.com>
 <0e9cd550-c69b-3e97-4619-6746da4d4bd1@redhat.com>
 <63d203d2-25b5-44e6-ccee-1857396556f0@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 02 Aug 2019 09:18:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH RFC 0/2] s390: stop abusing
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
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 dgilbert@redhat.com, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 10:29:43 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.08.19 10:04, David Hildenbrand wrote:
> > On 29.07.19 16:52, Igor Mammedov wrote:  
> >> While looking into unifying guest RAM allocation to use hostmem backends
> >> for initial RAM (especially when -mempath is used) and retiring
> >> memory_region_allocate_system_memory() API, leaving only single hostmem backend,
> >> I was inspecting how currently it is used by boards and it turns out several
> >> boards abuse it by calling the function several times (despite documented contract
> >> forbiding it).
> >>
> >> s390 is one of such boards where KVM limitation on memslot size got propagated
> >> to board design and memory_region_allocate_system_memory() was abused to satisfy
> >> KVM requirement for max RAM chunk where memory region alias would suffice.
> >>
> >> Unfortunately, memory_region_allocate_system_memory() usage created migration
> >> dependency where guest RAM is transferred in migration stream as several RAMBlocks
> >> if it's more than KVM_SLOT_MAX_BYTES.  
> > 
> > So if I understand it correctly, we only call
> > memory_region_allocate_system_memory() in case the guest initial memory
> > size exceeds KVM_SLOT_MAX_BYTES - ~8TB.  
> 
> We always call it. We just call it twice for > 8TB
> > 
> > Do we *really* care about keeping migration of systems running that most
> > probably nobody (except Christian ;) ) really uses? (especially not in
> > production).
> > 
> > I am fine keeping migration running if it's easy, but introducing hacks
> > (reading below) for such obscure use cases - I don't know.
> > 
> > @Christian: Please prove me wrong. :)  
> 
> For the time being we can block migration for guests > 8TB if that helps (it should not
> fail in a guest killing fashion), but we should
> 1. continue to be able to migrate guests < 8TB
> 2. continue to be 
> 
> On the other hand I find "and suddenly it fails if you go beyond this" really
> unpleasant. So it would be interesting to see the next round of patches to 
> check how "hacky" those really are.

I've looked into cleaning up "migratable aliases",
so far it works fine (well in configurations I was able to test,
there were no regressions in x86 machines which use aliases quite a bit).
As I've written before, aliases could be used for x86 later but
that yet to be proved, so I'd prefer to delay this patch if possible.

However, I'd prefer to intentionally break migration with >8TB
guests to simpler code without keepeing around compat mode
that won't/isn't used in practice.

As for new round of patches (including missing KVM fixup),
I'm going to post them now-ish for you to check it out.

> 
> >   
> >>
> >> In order to replace these several RAM chunks with a single memdev and keep it
> >> working with KVM memslot size limit and migration compatible, following was done:
> >>    * [2/2] use memory region aliases to partition hostmem backend RAM on
> >>            KVM_SLOT_MAX_BYTES chunks, which should keep KVM side working
> >>    * [1/2] hacked memory region aliases (to ram memory regions only) to have
> >>            its own RAMBlocks pointing to RAM chunks owned by aliased memory
> >>            region. While it's admittedly a hack, but it's relatively simple and
> >>            allows board code rashape migration stream as necessary
> >>
> >>            I haven't tried to use migratable aliases on x86 machines, but with it
> >>            it could be possible to drop legacy RAM allocation and compat knob
> >>            (cd5ff8333a) dropping '-numa node,mem' completely even for old machines.
> >>
> >> PS:
> >>    Tested with ping pong cross version migration on s390 machine 
> >>    (with reduced KVM_SLOT_MAX_BYTES since I don't have access to large
> >>     enough host)
> >>      
> >>
> >> Igor Mammedov (2):
> >>   memory: make MemoryRegion alias migratable
> >>   s390: do not call memory_region_allocate_system_memory() multiple
> >>     times
> >>
> >>  exec.c                     |  7 ++++---
> >>  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
> >>  memory.c                   |  5 +++++
> >>  3 files changed, 24 insertions(+), 8 deletions(-)
> >>  
> > 
> >   
> 


