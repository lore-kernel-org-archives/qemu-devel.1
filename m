Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B5C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05458206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05458206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGlbZ-0001c3-Ui
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 10:32:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hGla3-0000lu-4P
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hGla1-0007Oi-9K
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hGlZz-0007F6-CA; Wed, 17 Apr 2019 10:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 809C1356DE;
	Wed, 17 Apr 2019 14:30:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E95855D6A6;
	Wed, 17 Apr 2019 14:30:07 +0000 (UTC)
Date: Wed, 17 Apr 2019 16:30:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190417163003.49d3fca3@redhat.com>
In-Reply-To: <89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
	<89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 17 Apr 2019 14:30:17 +0000 (UTC)
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
Cc: David Hildenbrand <david@redhat.com>, Helge Deller <deller@gmx.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417143003.jNO9wY744d49_VD04XmQOwP2e_RAjkEP-_id7xsjjEQ@z>

On Tue, 16 Apr 2019 13:09:08 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This fails with more than 8TB, e.g.  "-m 9T "
> 
> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffc8500000}) = 0
> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=9895604649984, userspace_addr=0x3ffc8500000}) = -1 EINVAL (Invalid argument)
> 
> seems that the 2nd memslot gets the full size (and not 9TB-size of first slot).

I'm able to simulate issue on s390 host with KVM enabled, it looks like
memory region aliases are broken on s390 host (aliasing works as expected with
x86 where where it for splitting RAM on low and high mem).
I'll try to debug and find out where it goes off on a tangent.

> 
> 
> On 15.04.19 15:27, Igor Mammedov wrote:
> > s390 was trying to solve limited memslot size issue by abusing
> > memory_region_allocate_system_memory(), which breaks API contract
> > where the function might be called only once.
> > 
> > s390 should have used memory aliases to fragment inital memory into
> > smaller chunks to satisfy KVM's memslot limitation. But its a bit
> > late now, since allocated pieces are transfered in migration stream
> > separately, so it's not possible to just replace broken layout with
> > correct one. Previous patch made MemoryRegion alases migratable and
> > this patch switches to use them to split big initial RAM chunk into
> > smaller pieces up to KVM_SLOT_MAX_BYTES each and registers aliases
> > for migration.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > A don't have access to a suitable system to test it, so I've simulated
> > it with smaller chunks on x84 host. Ping-pong migration between old
> > and new QEMU worked fine.  KVM part should be fine as memslots
> > using mapped MemoryRegions (in this case it would be aliases) as
> > far as I know but is someone could test it on big enough host it
> > would be nice.
> > ---
> >  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index d11069b..12ca3a9 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -161,20 +161,30 @@ static void virtio_ccw_register_hcalls(void)
> >  static void s390_memory_init(ram_addr_t mem_size)
> >  {
> >      MemoryRegion *sysmem = get_system_memory();
> > +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> >      ram_addr_t chunk, offset = 0;
> >      unsigned int number = 0;
> >      gchar *name;
> >  
> >      /* allocate RAM for core */
> > +    memory_region_allocate_system_memory(ram, NULL, "s390.whole.ram", mem_size);
> > +    /*
> > +     * memory_region_allocate_system_memory() registers allocated RAM for
> > +     * migration, however for compat reasons the RAM should be passed over
> > +     * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
> > +     * allocated RAM so it won't be migrated directly. Aliases will take
> > +     * of segmenting RAM into legacy chunks.
> > +     */
> > +    vmstate_unregister_ram(ram, NULL);
> >      name = g_strdup_printf("s390.ram");
> >      while (mem_size) {
> > -        MemoryRegion *ram = g_new(MemoryRegion, 1);
> > -        uint64_t size = mem_size;
> > +        MemoryRegion *alias = g_new(MemoryRegion, 1);
> >  
> >          /* KVM does not allow memslots >= 8 TB */
> > -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> > -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> > -        memory_region_add_subregion(sysmem, offset, ram);
> > +        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> > +        memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
> > +        vmstate_register_ram_global(alias);
> > +        memory_region_add_subregion(sysmem, offset, alias);
> >          mem_size -= chunk;
> >          offset += chunk;
> >          g_free(name);
> >   
> 
> 


