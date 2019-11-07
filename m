Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F83BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D812166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D812166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSk0p-00038G-AV
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iSk04-0002dv-23
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iSk01-0003OY-8Y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:47:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iSk00-0003OA-UV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:47:05 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4AE286679
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 15:47:02 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id s3so2710748qkd.6
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 07:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=GB3QKBMo5iZml+hRwKOYs6l/9tX93r6xIgqrY7uZiDw=;
 b=iiI+9LrkdzaZzMihEklSEusxErX5ZrjIeDwsAoNV2YRK4uDMr7dpOdojE7MbIfk8UB
 gL5/vK53lKyceI5CabpIQlZaxLXYC2DUP7ERm8pH6C0gLUfUocx9SSf7z1hfX06qEXpI
 ydwjU6uhZwb8Kcf/ETh0U5sFzrCjc1jvOS2eZU063105ZCG23ILcyskhHSNAV65+deVP
 9Waz0SIH0iF7xvVyuA1o+emIDhomQSL66aO7DSt8wAUQ2tUXmzOVV5H/5SGvOR3x1xfq
 JA+RKZ9mXTbrsGx2G58fOTiGA3D4Pt81/Z+J5AE4qcmZJ+yV/IAYmdvO0z6pt6C01Dva
 GdCA==
X-Gm-Message-State: APjAAAUlWjc1+1v1kWaOOVZR7R6WYJPJUZ1mkPqRom31q/pU3WdbD6Hv
 5hcXu6OjId8RTQIRkvSqEOW1p3WLVWjJEG+AilrK3+Rgha7NeKhWOr0NFNzEj5OOBNuDeDNlMNt
 8Ge0Jdhj4nzbv1sA=
X-Received: by 2002:a37:dc44:: with SMTP id v65mr3357606qki.72.1573141621646; 
 Thu, 07 Nov 2019 07:47:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJPKalEqeCFeuIrXUvkcg63eS/nCuCIu0w5/zcYyxeMhQoLTXyCv5B1lO2nzipG43fOWGUNA==
X-Received: by 2002:a37:dc44:: with SMTP id v65mr3357553qki.72.1573141620909; 
 Thu, 07 Nov 2019 07:47:00 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id x10sm1646926qtj.25.2019.11.07.07.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 07:46:59 -0800 (PST)
Date: Thu, 7 Nov 2019 10:46:58 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20191107154658.GA9031@xz-x1>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-14-git-send-email-yi.l.liu@intel.com>
 <20191104200647.GA8825@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A0EEF2C@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EEF2C@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 07:56:21AM +0000, Liu, Yi L wrote:
> > > +static inline struct pasid_key *vtd_get_pasid_key(uint32_t pasid,
> > > +                                                  uint16_t sid)
> > > +{
> > > +    struct pasid_key *key =3D g_malloc0(sizeof(*key));
> >=20
> > I think you can simply return the pasid_key directly maybe otherwise
> > should be careful on mem leak.  Actually I think it's leaked below...
>=20
> sure, I can do it. For the leak, it is a known issue as below comment
> indicates. Not sure why it was left as it is. Perhaps, the key point is
> used in the hash table. Per my understanding, hash table should have
> its own field to store the key content. Do you have any idea?
>=20
>     if (!vtd_bus) {
>         uintptr_t *new_key =3D g_malloc(sizeof(*new_key));

This declares new_key as a "uintptr_t *" type.  Note, it's "new_key"
that gets the malloced region not "*new_key".

>         *new_key =3D (uintptr_t)bus;

This assigns the value of the bus to *newkey.

>         /* No corresponding free() */

So this does not need to be freed because the key will be inserted
very soon.  In your case below, you need to free it when it's only
used for lookup, or you can simply declare the key as stack variable
like what it did in vtd_find_add_as:

VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int dev=
fn)
{
    uintptr_t key =3D (uintptr_t)bus;
    ...
}

>=20
> >=20
> > > +    key->pasid =3D pasid;
> > > +    key->sid =3D sid;
> > > +    return key;
> > > +}
> > > +
> > > +static guint vtd_pasid_as_key_hash(gconstpointer v)
> > > +{
> > > +    struct pasid_key *key =3D (struct pasid_key *)v;
> > > +    uint32_t a, b, c;
> > > +
> > > +    /* Jenkins hash */
> > > +    a =3D b =3D c =3D JHASH_INITVAL + sizeof(*key);
> > > +    a +=3D key->sid;
> > > +    b +=3D extract32(key->pasid, 0, 16);
> > > +    c +=3D extract32(key->pasid, 16, 16);
> > > +
> > > +    __jhash_mix(a, b, c);
> > > +    __jhash_final(a, b, c);
> >=20
> > I'm totally not good at hash, but I'm curious why no one wants to
> > introduce at least a jhash() so we don't need to call these internals
> > (I believe that's how kernel did it).=20
>=20
> well, I'm also curious about it.
>=20
> > At the meantime I don't see how
> > it would be better than things like g_str_hash() too so I'd be glad i=
f
> > anyone could help explain a bit...
>=20
> I used to use g_str_hash(), and used string as key.
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02128.html
>=20
> Do you want me to keep the pasid_key structure here and switch to
> use g_str_hash()? Then the pasid key content would be compared as
> strings. I think it should work. But, I may be wrong all the same.

Oh ok so no length can be specified with that.  Do you like to
introduce the jhash() with your series and use it?

>=20
> > > +
> > > +    return c;
> > > +}
> > > +
> > > +static gboolean vtd_pasid_as_key_equal(gconstpointer v1, gconstpoi=
nter v2)
> > > +{
> > > +    const struct pasid_key *k1 =3D v1;
> > > +    const struct pasid_key *k2 =3D v2;
> > > +
> > > +    return (k1->pasid =3D=3D k2->pasid) && (k1->sid =3D=3D k2->sid=
);
> > > +}
> > > +
> > > +static inline bool vtd_pc_is_dom_si(struct VTDPASIDCacheInfo *pc_i=
nfo)
> > > +{
> > > +    return pc_info->flags & VTD_PASID_CACHE_DOMSI;
> > > +}
> > > +
> > > +static inline bool vtd_pc_is_pasid_si(struct VTDPASIDCacheInfo *pc=
_info)
> > > +{
> > > +    return pc_info->flags & VTD_PASID_CACHE_PASIDSI;
> >=20
> > AFAIS these only used once.  How about removing these helpers?  I
> > don't see much on helping readability or anything...  please see belo=
w
> > at [1].
>=20
> Agreed. Will do it. BTW. I failed to locate [1]. May you point it out. =
Surely
> I don=E2=80=99t want to miss any comments.

No worry, it's a comment left below and you didn't miss anything. I
just forgot to mark it out in my previous reply.

>=20
> > > +}
> > > +
> > > +static inline int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s,
> > > +                                            uint8_t bus_num,
> > > +                                            uint8_t devfn,
> > > +                                            uint32_t pasid,
> > > +                                            VTDPASIDEntry *pe)
> > > +{
> > > +    VTDContextEntry ce;
> > > +    int ret;
> > > +    dma_addr_t pasid_dir_base;
> > > +
> > > +    if (!s->root_scalable) {
> > > +        return -VTD_FR_PASID_TABLE_INV;
> > > +    }
> > > +
> > > +    ret =3D vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(&ce);
> > > +    ret =3D vtd_get_pe_from_pasid_table(s,
> > > +                                  pasid_dir_base, pasid, pe);
> > > +
> > > +    return ret;
> > > +}
> > > +
> > > +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEnt=
ry *p2)
> > > +{
> > > +    int i =3D 0;
> > > +    while (i < sizeof(*p1) / sizeof(p1->val)) {
> > > +        if (p1->val[i] !=3D p2->val[i]) {
> > > +            return false;
> > > +        }
> > > +        i++;
> > > +    }
> > > +    return true;
> >=20
> > Will this work?
> >=20
> >   return !memcmp(p1, p2, sizeof(*p1));
>=20
> oh, yes. Will replace with it.
>=20
> > > +}
> > > +
> > > +/**
> > > + * This function is used to clear pasid_cache_gen of cached pasid
> > > + * entry in vtd_pasid_as instances. Caller of this function should
> > > + * hold iommu_lock.
> > > + */
> > > +static gboolean vtd_flush_pasid(gpointer key, gpointer value,
> > > +                                gpointer user_data)
> > > +{
> > > +    VTDPASIDCacheInfo *pc_info =3D user_data;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as =3D value;
> > > +    IntelIOMMUState *s =3D vtd_pasid_as->iommu_state;
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_en=
try;
> > > +    VTDBus *vtd_bus =3D vtd_pasid_as->vtd_bus;
> > > +    VTDPASIDEntry pe;
> > > +    uint16_t did;
> > > +    uint32_t pasid;
> > > +    uint16_t devfn;
> > > +    gboolean remove =3D false;
> > > +
> > > +    did =3D vtd_pe_get_domain_id(&pc_entry->pasid_entry);
> > > +    pasid =3D vtd_pasid_as->pasid;
> > > +    devfn =3D vtd_pasid_as->devfn;
> > > +
> > > +    if (pc_entry->pasid_cache_gen &&
> > > +        (vtd_pc_is_dom_si(pc_info) ? (pc_info->domain_id =3D=3D di=
d) : 1) &&
> > > +        (vtd_pc_is_pasid_si(pc_info) ? (pc_info->pasid =3D=3D pasi=
d) : 1)) {
> >=20
> > This chunk is a bit odd to me.  How about something like this?
> >=20
> >   ...
> >=20
> >   if (!pc_entry->pasid_cache_gen)
> >     return false;
> >=20
> >   switch (pc_info->flags) {
> >     case DOMAIN:
> >       if (pc_info->domain_id !=3D did) {
> >         return false;
> >       }
> >       break;
> >     case PASID:
> >       if (pc_info->pasid !=3D pasid) {
> >         return false;
> >       }
> >       break;
> >     ... (I think you'll add more in the follow up patches)
> >   }
>=20
> yep, I can do it.
>=20
> > > +        /*
> > > +         * Modify pasid_cache_gen to be 0, the cached pasid entry =
in
> > > +         * vtd_pasid_as instance is invalid. And vtd_pasid_as inst=
ance
> > > +         * would be treated as invalid in QEMU scope until the pas=
id
> > > +         * cache gen is updated in a new pasid binding or updated =
in
> > > +         * below logic if found guest pasid entry exists.
> > > +         */
> > > +        remove =3D true;
> >=20
> > Why set remove here?  Should we set it only if we found that the entr=
y
> > is cleared?
>=20
> Yes, you are right. But it is only for passthru devices. For emulated
> sva-capable device, I think it would simple to always remove cached
> pasid-entry if guest issues pasid cache invalidation. This is because
> caching-mode is not necessary for emulated devices, which means pasid
> cache invalidation for emulated devices only means cache flush. This
> is enough as the pasid entry can be re-cached during PASID tagged DMA
> translation in do_translate(). Although it is not yet added as I
> mentioned in the patch commit message. While for passthru devices,
> pasid cache invalidation does not only mean cache flush. Instead, it
> relies on the latest guest pasid entry presence status.
>=20
> Based on the above idea, I make the remove=3Dtrue at the beginning, and
> if the subsequent logic finds out it is for passthru devices, it will
> check guest pasid entry and then decide how to handle the pasid cache
> invalidation request. "remove" will be set to be false when guest pasid
> entry exists.

So if you use the logic as [1] below imho it'll both work for emulated
and assigned devices.  It's a bit odd to add "fast path" for emulated
device to me because emulated device is destined to be slow already
and mostly for debugging purpose, rather than any real use in
production, afaiu...

>=20
> >=20
> > > +        pc_entry->pasid_cache_gen =3D 0;
> > > +        if (vtd_bus->dev_ic[devfn]) {
> > > +            if (!vtd_dev_get_pe_from_pasid(s,
> > > +                      pci_bus_num(vtd_bus->bus), devfn, pasid, &pe=
)) {
> > > +                /*
> > > +                 * pasid entry exists, so keep the vtd_pasid_as, a=
nd needs
> > > +                 * update the pasid entry cached in vtd_pasid_as. =
Also, if
> > > +                 * the guest pasid entry doesn't equal to cached p=
asid entry
> > > +                 * needs to issue a pasid bind to host for passthr=
u devies.
> > > +                 */
> > > +                remove =3D false;
> > > +                pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;
> > > +                if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid=
_entry)) {
> > > +                    pc_entry->pasid_entry =3D pe;
> >=20
> > What if the pasid entry changed from valid to all zeros?  Should we
> > unbind/remove it as well?
>=20
> If it is from valid to all zero, vtd_dev_get_pe_from_pasid() should
> return non-zero.

Why?  Shouldn't it returns zero but with a &pe that contains all zero ins=
tead?

Feel free to skip this question if you're going to refactor this piece
of code, then we can review that.

> Then it would keep "remove"=3Dtrue and pasid_cache_gen=3D0.
> Unbind will be added with bind in patch 15. Here just handle the cached
> pasid entry within vIOMMU.
>=20
> 0015-intel_iommu-bind-unbind-guest-page-table-to-host.patch
>=20
> >=20
> > > +                    /*
> > > +                     * TODO: when pasid-base-iotlb(piotlb) infrast=
ructure is
> > > +                     * ready, should invalidate QEMU piotlb togeht=
er with this
> > > +                     * change.
> > > +                     */
> > > +                }
> > > +            }
> > > +        }
> > > +    }
> > > +
> > > +    return remove;
> >=20
> > In summary, IMHO this chunk could be clearer if like this:
> >=20
> >   ... (continues with above pesudo code)
> >=20
> >   ret =3D vtd_dev_get_pe_from_pasid(..., &pe);
> >   if (ret) {
> >     goto remove;
> >   }
> >   // detected correct pasid entry
> >   if (!vtd_pasid_entry_compare(&pe, ...)) {
> >      // pasid entry changed
> >      if (vtd_pasid_cleared(&pe)) {
> >        // the pasid is cleared to all zero, drop
> >        goto remove;
> >      }
> >      // a new pasid is setup
> >=20
> >      // Send UNBIND if cache valid
> >      ...
> >      // Send BIND
> >      ...
> >      // Update cache
> >      pc_entry->pasid_entry =3D pe;
> >      pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;

(I think I missed a "return false" here...)

> >   }
> >=20
> > remove:
> >   // Send UNBIND if cache valid
> >   ...
> >   return true;
>=20
> yep, I can do it. nice idea. :-)

[1]

>=20
> > I feel like you shouldn't bother checking against
> > vtd_bus->dev_ic[devfn] at all here because if that was set then it
> > means we need to pass these information down to host, and it'll be
> > checked automatically because when we send BIND/UNBIND event we'll
> > definitely check that too otherwise those events will be noops.
>=20
> I need it. Because I want to differ passthru devices and emulated
> devices. Ideally, emulated devices won't have vtd_bus->dev_ic[devfn].

I've commented above with the same topic - IMHO we don't need fast
path for emulated devices.  Readability could matter more at least to me.
Better readability could also mean less chance of bugs.

>=20
> > > +}
> > > +
> > >  static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t domain=
_id)
> > >  {
> > > +    VTDPASIDCacheInfo pc_info;
> > > +
> > > +    trace_vtd_pasid_cache_dsi(domain_id);
> > > +
> > > +    pc_info.flags =3D VTD_PASID_CACHE_DOMSI;
> > > +    pc_info.domain_id =3D domain_id;
> > > +
> > > +    /*
> > > +     * Loop all existing pasid caches and update them.
> > > +     */
> > > +    vtd_iommu_lock(s);
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as, vtd_flush_pasid, =
&pc_info);
> > > +    vtd_iommu_unlock(s);
> > > +
> > > +    /*
> > > +     * TODO: Domain selective PASID cache invalidation
> > > +     * may be issued wrongly by programmer, to be safe,
> >=20
> > IMHO it's not wrong even if the guest sends that, because logically
> > the guest can send invalidation as it wishes, and we should have
> > similar issue before on the 2nd level page table invalidations... and
> > that's why we need to keep the iova mapping inside qemu I suppose...
>=20
> yes, we are aligned on this point. I can update the description above.
>=20
> >=20
> > > +     * after invalidating the pasid caches, emulator
> > > +     * needs to replay the pasid bindings by walking guest
> > > +     * pasid dir and pasid table.
> >=20
> > This is true...
>=20
> handshake here.
>=20
> >=20
> > > +     */
> > >      return 0;
> > >  }
> > >
> > > +/**
> > > + * This function finds or adds a VTDPASIDAddressSpace for a device
> > > + * when it is bound to a pasid. Caller of this function should hol=
d
> > > + * iommu_lock.
> > > + */
> > > +static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState=
 *s,
> > > +                                                   VTDBus *vtd_bus=
,
> > > +                                                   int devfn,
> > > +                                                   uint32_t pasid,
> > > +                                                   bool allocate)
> > > +{
> > > +    struct pasid_key *key;
> > > +    struct pasid_key *new_key;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as;
> > > +    uint16_t sid;
> > > +
> > > +    sid =3D vtd_make_source_id(pci_bus_num(vtd_bus->bus), devfn);
> > > +    key =3D vtd_get_pasid_key(pasid, sid);
> > > +    vtd_pasid_as =3D g_hash_table_lookup(s->vtd_pasid_as, key);
> > > +
> > > +    if (!vtd_pasid_as && allocate) {
> > > +        new_key =3D vtd_get_pasid_key(pasid, sid);
> >=20
> > Is this the same as key no matter what?
>=20
> It is the key content matters. I'd need to refine the key alloc/free in
> next version.
>=20
> >=20
> > > +        /*
> > > +         * Initiate the vtd_pasid_as structure.
> > > +         *
> > > +         * This structure here is used to track the guest pasid
> > > +         * binding and also serves as pasid-cache mangement entry.
> > > +         *
> > > +         * TODO: in future, if wants to support the SVA-aware DMA
> > > +         *       emulation, the vtd_pasid_as should be fully initi=
alized.
> > > +         *       e.g. the address_space and memory region fields.
> > > +         */
> > > +        vtd_pasid_as =3D g_malloc0(sizeof(VTDPASIDAddressSpace));
> > > +        vtd_pasid_as->iommu_state =3D s;
> > > +        vtd_pasid_as->vtd_bus =3D vtd_bus;
> > > +        vtd_pasid_as->devfn =3D devfn;
> > > +        vtd_pasid_as->context_cache_entry.context_cache_gen =3D 0;
> > > +        vtd_pasid_as->pasid =3D pasid;
> > > +        vtd_pasid_as->pasid_cache_entry.pasid_cache_gen =3D 0;
> > > +        g_hash_table_insert(s->vtd_pasid_as, new_key, vtd_pasid_as=
);
> > > +    }
> > > +    return vtd_pasid_as;
> > > +}
> > > +
> > > + /**
> > > +  * This function updates the pasid entry cached in &vtd_pasid_as.
> > > +  * Caller of this function should hold iommu_lock.
> > > +  */
> > > +static inline void vtd_fill_in_pe_cache(
> > > +              VTDPASIDAddressSpace *vtd_pasid_as, VTDPASIDEntry *p=
e)
> > > +{
> > > +    IntelIOMMUState *s =3D vtd_pasid_as->iommu_state;
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_en=
try;
> > > +
> > > +    pc_entry->pasid_entry =3D *pe;
> > > +    pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;
> > > +}
> > > +
> > >  static int vtd_pasid_cache_psi(IntelIOMMUState *s,
> > >                                 uint16_t domain_id, uint32_t pasid)
> > >  {
> > > +    VTDPASIDCacheInfo pc_info;
> > > +    VTDPASIDEntry pe;
> > > +    VTDBus *vtd_bus;
> > > +    int bus_n, devfn;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as;
> > > +    VTDIOMMUContext *vtd_ic;
> > > +
> > > +    pc_info.flags =3D VTD_PASID_CACHE_DOMSI;
> > > +    pc_info.domain_id =3D domain_id;
> > > +    pc_info.flags |=3D VTD_PASID_CACHE_PASIDSI;
> > > +    pc_info.pasid =3D pasid;
> > > +
> > > +    /*
> > > +     * Regards to a pasid selective pasid cache invalidation (PSI)=
, it
> > > +     * could be either cases of below:
> > > +     * a) a present pasid entry moved to non-present
> > > +     * b) a present pasid entry to be a present entry
> > > +     * c) a non-present pasid entry moved to present
> > > +     *
> > > +     * Here the handling of a PSI is:
> > > +     * 1) loop all the exisitng vtd_pasid_as instances to update t=
hem
> > > +     *    according to the latest guest pasid entry in pasid table=
.
> > > +     *    this will make sure affected existing vtd_pasid_as insta=
nces
> > > +     *    cached the latest pasid entries. Also, during the loop, =
the
> > > +     *    host should be notified if needed. e.g. pasid unbind or =
pasid
> > > +     *    update. Should be able to cover case a) and case b).
> > > +     *
> > > +     * 2) loop all devices to cover case c)
> > > +     *    However, it is not good to always loop all devices. In t=
his
> > > +     *    implementation. We do it in this ways:
> > > +     *    - For devices which have VTDIOMMUContext instances, we l=
oop
> > > +     *      them and check if guest pasid entry exists. If yes, it=
 is
> > > +     *      case c), we update the pasid cache and also notify hos=
t.
> > > +     *    - For devices which have no VTDIOMMUContext instances, i=
t is
> > > +     *      not necessary to create pasid cache at this phase sinc=
e it
> > > +     *      could be created when vIOMMU do DMA address translatio=
n.
> > > +     *      This is not implemented yet since no PASID-capable emu=
lated
> > > +     *      devices today. If we have it in future, the pasid cach=
e shall
> > > +     *      be created there.
> > > +     */
> > > +
> > > +    vtd_iommu_lock(s);
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as, vtd_flush_pasid, =
&pc_info);
> > > +    vtd_iommu_unlock(s);
> >=20
> > [2]
> >=20
> > > +
> > > +    vtd_iommu_lock(s);
> >=20
> > Do you want to explicitly release the lock for other thread?
> > Otherwise I don't see a point to unlock/lock in sequence..
>=20
> I felt like to have shorter protected snippets. But, I don=E2=80=99t ha=
ve strong
> reason either after reconsidering it. I'll remove it anyhow.
>=20
> > > +    QLIST_FOREACH(vtd_ic, &s->vtd_dev_ic_list, next) {
> > > +        vtd_bus =3D vtd_ic->vtd_bus;
> > > +        devfn =3D vtd_ic->devfn;
> > > +        bus_n =3D pci_bus_num(vtd_bus->bus);
> > > +
> > > +        /* Step 1: fetch vtd_pasid_as and check if it is valid */
> > > +        vtd_pasid_as =3D vtd_add_find_pasid_as(s, vtd_bus,
> > > +                                        devfn, pasid, true);
> > > +        if (vtd_pasid_as &&
> > > +            (s->pasid_cache_gen =3D=3D
> > > +             vtd_pasid_as->pasid_cache_entry.pasid_cache_gen)) {
> > > +            /*
> > > +             * pasid_cache_gen equals to s->pasid_cache_gen means
> > > +             * vtd_pasid_as is valid after the above s->vtd_pasid_=
as
> > > +             * updates. Thus no need for the below steps.
> > > +             */
> > > +            continue;
> > > +        }
> > > +
> > > +        /*
> > > +         * Step 2: vtd_pasid_as is not valid, it's potentailly a
> > > +         * new pasid bind. Fetch guest pasid entry.
> > > +         */
> > > +        if (vtd_dev_get_pe_from_pasid(s, bus_n, devfn, pasid, &pe)=
) {
> > > +            continue;
> > > +        }
> > > +
> > > +        /*
> > > +         * Step 3: pasid entry exists, update pasid cache
> > > +         *
> > > +         * Here need to check domain ID since guest pasid entry
> > > +         * exists. What needs to do are:
> > > +         *   - update the pc_entry in the vtd_pasid_as
> > > +         *   - set proper pc_entry.pasid_cache_gen
> > > +         *   - passdown the latest guest pasid entry config to hos=
t
> > > +         *     (will be added in later patch)
> > > +         */
> > > +        if (domain_id =3D=3D vtd_pe_get_domain_id(&pe)) {
> > > +            vtd_fill_in_pe_cache(vtd_pasid_as, &pe);
> > > +        }
> > > +    }
> >=20
> > Could you explain why do we need this whole chunk if with [2] above?
> > I feel like that'll do all the things we need already (send
> > BIND/UNBIND, update pasid entry cache).
>=20
> You may refer to the comments added for this function in the patch
> itself. Also, I'd like to talk more to assist your review. The basic
> idea is that the above chunk [2] only handles the already cached
> pasid-entries. right? It covers the modifications from present pasid
> entry to be either non-present or present modifications. While for a
> non-present pasid entry to present modification, chunk [2] has no idea.
> To cover such possibilities, needs to loop all devices and check the
> corresponding pasid entries. This is what I proposed in RFC v1. But I
> don=E2=80=99t like it. To be more efficient, I think we can just loop a=
ll
> passthru devices since only passthru devices care about the
> non-present to present changes. For emulated devices, its pasid cache
> can be created in do_translate() for emulated PASID tagged DMAs.

Ok I see your point, thanks for explaining!

Two loops are still a bit messy though.  How about we do this:

  - add another patch to keep a list of all the devices that are under
    the IOMMU (e.g. link the VTDAddressSpace in vtd_find_add_as when
    created), then

  - in this patch instead of looping over two, we just loop over all
    the devices (emulated + assigned), we do vtd_flush_pasid() or
    similar thing to update the pasid cache in a common way

Then I think we don't need two loops, but only once to traverse the
list that contains all devices.  Do you think it could be a bit cleaner?

Thanks,

>=20
> >=20
> > > +    vtd_iommu_unlock(s);
> > >      return 0;
> > >  }

--=20
Peter Xu

