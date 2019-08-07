Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C99C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA77C21E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA77C21E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIgL-0006DI-Sd
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hvIfw-0005kD-MC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hvIfv-0000QL-2e
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:56:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hvIfu-0000LV-Qb; Wed, 07 Aug 2019 05:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1517058;
 Wed,  7 Aug 2019 09:56:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9973D5D9CD;
 Wed,  7 Aug 2019 09:56:00 +0000 (UTC)
Date: Wed, 7 Aug 2019 11:55:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190807115559.660f3e6c@redhat.com>
In-Reply-To: <b90f1fc0-782c-b454-b999-48e88fac4cb9@redhat.com>
References: <20190806094834.7691-1-imammedo@redhat.com>
 <20190806094834.7691-2-imammedo@redhat.com>
 <b90f1fc0-782c-b454-b999-48e88fac4cb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 09:56:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.2 v4 1/2] kvm: s390:
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
Cc: thuth@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 09:54:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 06.08.19 11:48, Igor Mammedov wrote:
> > Max memslot size supported by kvm on s390 is 8Tb,
> > move logic of splitting RAM in chunks upto 8T to KVM code.
> >=20
> > This way it will hide KVM specific restrictions in KVM code
> > and won't affect baord level design decisions. Which would allow
> > us to avoid misusing memory_region_allocate_system_memory() API
> > and eventually use a single hostmem backend for guest RAM.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v4:
> >   * fix compilation issue
> >           (Christian Borntraeger <borntraeger@de.ibm.com>)
> >   * advance HVA along with GPA in kvm_set_phys_mem()
> >           (Christian Borntraeger <borntraeger@de.ibm.com>)
> >=20
> > patch prepares only KVM side for switching to single RAM memory region
> > another patch will take care of  dropping manual RAM partitioning in
> > s390 code.
> > ---
> >  include/sysemu/kvm_int.h   |  1 +
> >  accel/kvm/kvm-all.c        | 80 +++++++++++++++++++++++---------------
> >  hw/s390x/s390-virtio-ccw.c |  9 -----
> >  target/s390x/kvm.c         | 12 ++++++
> >  4 files changed, 62 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> > index 31df465fdc..7f7520bce2 100644
> > --- a/include/sysemu/kvm_int.h
> > +++ b/include/sysemu/kvm_int.h
> > @@ -41,4 +41,5 @@ typedef struct KVMMemoryListener {
> >  void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
> >                                    AddressSpace *as, int as_id);
> > =20
> > +void kvm_set_max_memslot_size(hwaddr max_slot_size);
> >  #endif
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index f450f25295..d87f855ea4 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -138,6 +138,7 @@ bool kvm_direct_msi_allowed;
> >  bool kvm_ioeventfd_any_length_allowed;
> >  bool kvm_msi_use_devid;
> >  static bool kvm_immediate_exit;
> > +static hwaddr kvm_max_slot_size =3D ~0;
> > =20
> >  static const KVMCapabilityInfo kvm_required_capabilites[] =3D {
> >      KVM_CAP_INFO(USER_MEMORY),
> > @@ -951,6 +952,14 @@ kvm_check_extension_list(KVMState *s, const KVMCap=
abilityInfo *list)
> >      return NULL;
> >  }
> > =20
> > +void kvm_set_max_memslot_size(hwaddr max_slot_size)
> > +{
> > +    g_assert(
> > +        ROUND_UP(max_slot_size, qemu_real_host_page_size) =3D=3D max_s=
lot_size
> > +    );
> > +    kvm_max_slot_size =3D max_slot_size;
> > +}
> > +
> >  static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >                               MemoryRegionSection *section, bool add)
> >  {
> > @@ -958,7 +967,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >      int err;
> >      MemoryRegion *mr =3D section->mr;
> >      bool writeable =3D !mr->readonly && !mr->rom_device;
> > -    hwaddr start_addr, size;
> > +    hwaddr start_addr, size, slot_size;
> >      void *ram;
> > =20
> >      if (!memory_region_is_ram(mr)) {
> > @@ -983,41 +992,50 @@ static void kvm_set_phys_mem(KVMMemoryListener *k=
ml,
> >      kvm_slots_lock(kml);
> > =20
> >      if (!add) {
> > -        mem =3D kvm_lookup_matching_slot(kml, start_addr, size);
> > -        if (!mem) {
> > -            goto out;
> > -        }
> > -        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> > -            kvm_physical_sync_dirty_bitmap(kml, section);
> > -        }
> > +        do {
> > +            slot_size =3D kvm_max_slot_size < size ? kvm_max_slot_size=
 : size;
> > +            mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_siz=
e);
> > +            if (!mem) {
> > +                goto out; =20
>=20
> I wonder if this can trigger for the first, but not the second slot (or
> the other way around). In that case you would want to continue the loop
> (incrementing counters). But most probably there would something be
> wrong in the caller if that would happen.

I couldn't come up with scenario where it would be possible
(unless flatview rendering is broken)

>=20
> > +            }
> > +            if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> > +                kvm_physical_sync_dirty_bitmap(kml, section);
> > +            }
> > =20
> > -        /* unregister the slot */
> > -        g_free(mem->dirty_bmap);
> > -        mem->dirty_bmap =3D NULL;
> > -        mem->memory_size =3D 0;
> > -        mem->flags =3D 0;
> > -        err =3D kvm_set_user_memory_region(kml, mem, false);
> > -        if (err) {
> > -            fprintf(stderr, "%s: error unregistering slot: %s\n",
> > -                    __func__, strerror(-err));
> > -            abort();
> > -        }
> > +            /* unregister the slot */
> > +            g_free(mem->dirty_bmap);
> > +            mem->dirty_bmap =3D NULL;
> > +            mem->memory_size =3D 0;
> > +            mem->flags =3D 0;
> > +            err =3D kvm_set_user_memory_region(kml, mem, false);
> > +            if (err) {
> > +                fprintf(stderr, "%s: error unregistering slot: %s\n",
> > +                        __func__, strerror(-err));
> > +                abort();
> > +            }
> > +            start_addr +=3D slot_size;
> > +        } while ((size -=3D slot_size)); =20
>=20
> NIT: I think you can drop parentheses - but I would really prefer to not
> perform computations in the condition.
sure, I'll move computation within the loop

> >          goto out;
> >      }
> > =20
> >      /* register the new slot */
> > -    mem =3D kvm_alloc_slot(kml);
> > -    mem->memory_size =3D size;
> > -    mem->start_addr =3D start_addr;
> > -    mem->ram =3D ram;
> > -    mem->flags =3D kvm_mem_flags(mr);
> > -
> > -    err =3D kvm_set_user_memory_region(kml, mem, true);
> > -    if (err) {
> > -        fprintf(stderr, "%s: error registering slot: %s\n", __func__,
> > -                strerror(-err));
> > -        abort();
> > -    }
> > +    do {
> > +        slot_size =3D kvm_max_slot_size < size ? kvm_max_slot_size : s=
ize;
> > +        mem =3D kvm_alloc_slot(kml);
> > +        mem->memory_size =3D slot_size;
> > +        mem->start_addr =3D start_addr;
> > +        mem->ram =3D ram;
> > +        mem->flags =3D kvm_mem_flags(mr);
> > +
> > +        err =3D kvm_set_user_memory_region(kml, mem, true);
> > +        if (err) {
> > +            fprintf(stderr, "%s: error registering slot: %s\n", __func=
__,
> > +                    strerror(-err));
> > +            abort();
> > +        }
> > +        start_addr +=3D slot_size;
> > +        ram +=3D slot_size;
> > +    } while ((size -=3D slot_size)); =20
>=20
> dito
>=20
> One note:
>=20
> KVMState stores the number of slots in "nr_slots". We export that via
> kvm_get_max_memslots().
>
> E.g., spapr uses that to compare it against "machine->ram_slots".
this patch shouldn't affect spapr/arm or x86 machines as they do not have
limits on memslot size.

> Later (esp. for s390x), kvm_get_max_memslots() can no longer be compared =
to
> ram_slots directly. Could be that a ram slot would map to multiple KVM
> memory slots. There would be no easy way to detect if KVM is able to
> deal with "machine->ram_slots" as defined by the user, until the sizes
> of the slots are known.

If I recall correctly about kvm_foo_slots() APIs,
assumption 1 memory region =3D=3D 1 memslot didn't/doesn't hold true
in all cases (ex: x86) and it's only best effort to let us compare
the number of apples to oranges on a tree and works for current
usecases.

=46rom hotplug point of view kvm_has_free_slot() would be more important,
to allow for graceful abort. If s390 would ever need to hotplug
RAM MemoryRegion, anyway APIs should be changed to account for
1:N split when actual dependency arises.

