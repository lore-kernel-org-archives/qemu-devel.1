Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DAAC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B81F20661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngq3j1ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B81F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1tvP-0007Rp-DG
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1tuW-0006mM-6D
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1tuR-0007Bd-L3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:26:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1tuR-0007Aq-3n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581521198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKD4AHdv0zT7mNNIKr0pjJd2T4H0aNL/uSVhpytY35k=;
 b=Ngq3j1eke0kzS2xyYYghUKzRp3Cdde8F0FfpaADfZO6GkZl0CzsVosixqvFiercdhs+C69
 AO8F/EEM6lk1sooG4BVQs0zDT4pV9CHRRproLPZRJl1XD2Lua18XzXvaGQ+cmhGqaJTsUy
 0raEPFM4ZSNwGlgKOYy6VGnZkTv9xgo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-8toA0aEdMiqkOj5aoA1yeA-1; Wed, 12 Feb 2020 10:26:33 -0500
Received: by mail-qt1-f200.google.com with SMTP id y3so1457605qti.15
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 07:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nN+Nen1qnF/hmeT2cjoQdc8yEisc6LBtLDIfuqBlRgI=;
 b=CkYkesqBgHSBE9FZ+ehiNR+HNmotJEYpej616/EkOAmkcw0lZRuuW1ui4cv0xyUNmq
 RbIMOd6zGJtthOLuQd09+2dzWNpulMPxl6+Ic3Om4QSKl4ausK1/deuWYZ7Z2SWesJv+
 F4Zdy19MB0wm8ZK8ymf5S6kk6UoeerIJ+LKyxPf/6EK6mSmnjpf0GhaDdOWeGy6Yl00L
 AcyvXHexxCk5NYWKYqwoseIvXyLeB/Y5jVNNScK6svwV8Dz9w833xPNHbmRDS3JhS7k7
 xHho3owNZU4Sgj2BCsAxtdakCKSzqTqerKQ1NH21OZlTRgwP5Cb92bqhqa7WxtUXP6Rj
 koNw==
X-Gm-Message-State: APjAAAWp3dXlrLBJFfv0LCdFAdZrU7rfwZEWfNJn9bFA5BS7wv/Bj4bY
 9zI7A/kxsVIfLDTUz3S0GYnL9nixYl0ylNbIy6XD9CkiNyD4hBCcc5vWFMeArGgWaQdVC9NgDt8
 b8a69KiXANyZ70Wg=
X-Received: by 2002:ac8:163c:: with SMTP id p57mr20256894qtj.106.1581521193286; 
 Wed, 12 Feb 2020 07:26:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqweX4QpxLiO9G5Me+uOthkSbX71hOfeyJt0XkeUZTV+EKi32VbRxF+BCdI3WNN51L5NVDv0Bg==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr20256838qtj.106.1581521192735; 
 Wed, 12 Feb 2020 07:26:32 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id v78sm364762qkb.48.2020.02.12.07.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 07:26:31 -0800 (PST)
Date: Wed, 12 Feb 2020 10:26:29 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 16/25] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20200212152629.GA1083891@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-17-git-send-email-yi.l.liu@intel.com>
 <20200211233548.GO984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA669@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1BA669@SHSMSX104.ccr.corp.intel.com>
X-MC-Unique: 8toA0aEdMiqkOj5aoA1yeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 08:37:30AM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, February 12, 2020 7:36 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v3 16/25] intel_iommu: add PASID cache management
> > infrastructure
> >=20
> > On Wed, Jan 29, 2020 at 04:16:47AM -0800, Liu, Yi L wrote:
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
> > > This patch adds a PASID cache management infrastructure based on
> > > new added structure VTDPASIDAddressSpace, which is used to track
> > > the PASID usage and future PASID tagged DMA address translation
> > > support in vIOMMU.
> > >
> > >     struct VTDPASIDAddressSpace {
> > >         VTDBus *vtd_bus;
> > >         uint8_t devfn;
> > >         AddressSpace as;
> > >         uint32_t pasid;
> > >         IntelIOMMUState *iommu_state;
> > >         VTDContextCacheEntry context_cache_entry;
> > >         QLIST_ENTRY(VTDPASIDAddressSpace) next;
> > >         VTDPASIDCacheEntry pasid_cache_entry;
> > >     };
> > >
> > > Ideally, a VTDPASIDAddressSpace instance is created when a PASID
> > > is bound with a DMA AddressSpace. Intel VT-d spec requires guest
> > > software to issue pasid cache invalidation when bind or unbind a
> > > pasid with an address space under caching-mode. However, as
> > > VTDPASIDAddressSpace instances also act as pasid cache in this
> > > implementation, its creation also happens during vIOMMU PASID
> > > tagged DMA translation. The creation in this path will not be
> > > added in this patch since no PASID-capable emulated devices for
> > > now.
> > >
> > > The implementation in this patch manages VTDPASIDAddressSpace
> > > instances per PASID+BDF (lookup and insert will use PASID and
> > > BDF) since Intel VT-d spec allows per-BDF PASID Table. When a
> > > guest bind a PASID with an AddressSpace, QEMU will capture the
> > > guest pasid selective pasid cache invalidation, and allocate
> > > remove a VTDPASIDAddressSpace instance per the invalidation
> > > reasons:
> > >
> > >     *) a present pasid entry moved to non-present
> > >     *) a present pasid entry to be a present entry
> > >     *) a non-present pasid entry moved to present
> > >
> > > vIOMMU emulator could figure out the reason by fetching latest
> > > guest pasid entry.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 367
> > +++++++++++++++++++++++++++++++++++++++++
> > >  hw/i386/intel_iommu_internal.h |  14 ++
> > >  hw/i386/trace-events           |   1 +
> > >  include/hw/i386/intel_iommu.h  |  36 +++-
> > >  4 files changed, 417 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index 58e7213..c75cb7b 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -40,6 +40,7 @@
> > >  #include "kvm_i386.h"
> > >  #include "migration/vmstate.h"
> > >  #include "trace.h"
> > > +#include "qemu/jhash.h"
> > >
> > >  /* context entry operations */
> > >  #define VTD_CE_GET_RID2PASID(ce) \
> > > @@ -65,6 +66,8 @@
> > >  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
> > >  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifi=
er
> > *n);
> > >
> > > +static void vtd_pasid_cache_reset(IntelIOMMUState *s);
> > > +
> > >  static void vtd_panic_require_caching_mode(void)
> > >  {
> > >      error_report("We need to set caching-mode=3Don for intel-iommu t=
o enable "
> > > @@ -276,6 +279,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
> > >      vtd_iommu_lock(s);
> > >      vtd_reset_iotlb_locked(s);
> > >      vtd_reset_context_cache_locked(s);
> > > +    vtd_pasid_cache_reset(s);
> > >      vtd_iommu_unlock(s);
> > >  }
> > >
> > > @@ -686,6 +690,11 @@ static inline bool vtd_pe_type_check(X86IOMMUSta=
te
> > *x86_iommu,
> > >      return true;
> > >  }
> > >
> > > +static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)
> > > +{
> > > +    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> > > +}
> > > +
> > >  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
> > >  {
> > >      return pdire->val & 1;
> > > @@ -2393,19 +2402,370 @@ static bool
> > vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
> > >      return true;
> > >  }
> > >
> > > +static inline void vtd_init_pasid_key(uint32_t pasid,
> > > +                                     uint16_t sid,
> > > +                                     struct pasid_key *key)
> > > +{
> > > +    key->pasid =3D pasid;
> > > +    key->sid =3D sid;
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
> > > +
> > > +    return c;
> > > +}
> > > +
> > > +static gboolean vtd_pasid_as_key_equal(gconstpointer v1, gconstpoint=
er v2)
> > > +{
> > > +    const struct pasid_key *k1 =3D v1;
> > > +    const struct pasid_key *k2 =3D v2;
> > > +
> > > +    return (k1->pasid =3D=3D k2->pasid) && (k1->sid =3D=3D k2->sid);
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
> > > +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry
> > *p2)
> > > +{
> > > +    return !memcmp(p1, p2, sizeof(*p1));
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
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_entr=
y;
> > > +    VTDBus *vtd_bus =3D vtd_pasid_as->vtd_bus;
> > > +    VTDPASIDEntry pe;
> > > +    uint16_t did;
> > > +    uint32_t pasid;
> > > +    uint16_t devfn;
> > > +    int ret;
> > > +
> > > +    did =3D vtd_pe_get_domain_id(&pc_entry->pasid_entry);
> > > +    pasid =3D vtd_pasid_as->pasid;
> > > +    devfn =3D vtd_pasid_as->devfn;
> > > +
> > > +    if (!(pc_entry->pasid_cache_gen =3D=3D s->pasid_cache_gen)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    switch (pc_info->flags & VTD_PASID_CACHE_INFO_MASK) {
> > > +    case VTD_PASID_CACHE_PASIDSI:
> > > +        if (pc_info->pasid !=3D pasid) {
> > > +            return false;
> > > +        }
> > > +        /* Fall through */
> >=20
> > Why fall through?
>=20
> For VTD_PASID_CACHE_PASIDSI, it implies domain selective, so it
> requires to check did just as VTD_PASID_CACHE_DOMSI.

Ah right. :)

>=20
> >=20
> > > +    case VTD_PASID_CACHE_DOMSI:
> > > +        if (pc_info->domain_id !=3D did) {
> > > +            return false;
> > > +        }
> > > +        /* Fall through */
> >=20
> > Same here.
>=20
> If code comes to here, it means the necessary checks are passed. Should
> add a break here. However, as the below case does nothing and just calls
> break. So I let the code fall through.

Yes this is fine too.

>=20
> >=20
> > > +    case VTD_PASID_CACHE_GLOBAL:
> > > +        break;
> > > +    default:
> >=20
> > Nevee reach here right?  If so we can abort.
>=20
> yes, should never reach here.
>=20
> > > +        return false;
> > > +    }
> > > +
> > > +    /*
> > > +     * pasid cache invalidation may indicate a present pasid
> > > +     * entry to present pasid entry modification. To cover such
> > > +     * case, vIOMMU emulator needs to fetch latest guest pasid
> > > +     * entry and check cached pasid entry, then update pasid
> > > +     * cache and send pasid bind/unbind to host properly.
> > > +     */
> > > +    ret =3D vtd_dev_get_pe_from_pasid(s,
> > > +                  pci_bus_num(vtd_bus->bus), devfn, pasid, &pe);
> > > +    if (ret) {
> > > +        /*
> > > +         * No valid pasid entry in guest memory. e.g. pasid entry
> > > +         * was modified to be either all-zero or non-present. Either
> > > +         * case means existing pasid cache should be removed.
> > > +         */
> > > +        goto remove;
> > > +    }
> > > +    /* Compare cached pasid entry and latest pasid entry */
> > > +    if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> > > +        /* pasid entry was updated, thus update the pasid cache */
> > > +        pc_entry->pasid_entry =3D pe;
> > > +        pc_entry->pasid_cache_gen =3D s->pasid_cache_gen;
> > > +        /*
> > > +         * TODO:
> > > +         * - send pasid bind to host for passthru devices
> > > +         * - when pasid-base-iotlb(piotlb) infrastructure is ready,
> > > +         *   should invalidate QEMU piotlb togehter with this change=
.
> > > +         */
> > > +    }
> > > +    return false;
> > > +remove:
> > > +    /*
> > > +     * TODO:
> > > +     * - send pasid unbind to host for passthru devices
> > > +     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
> > > +     *   should invalidate QEMU piotlb togehter with this change.
> > > +     */
> > > +    return true;
> > > +}
> > > +
> > >  static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t domain_i=
d)
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
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                                 vtd_flush_pasid, &pc_info);
> > > +
> > > +    /*
> > > +     * TODO: Domain selective PASID cache invalidation
> > > +     * flushes all the pasid caches within a domain. To
> > > +     * be safe, after invalidating the pasid caches, emulator
> > > +     * needs to replay the pasid bindings by walking guest
> > > +     * pasid dir and pasid table.
> >=20
> > Better spell out on what special case we're handling here: When the
> > guest setup a new PASID entry then send a PASID DSI.
>=20
> oh, yes.  will add it in new version. :-)
>=20
> >=20
> > > +     */
> > > +    vtd_iommu_unlock(s);
> > >      return 0;
> > >  }
> > >
> > > +/**
> > > + * This function finds or adds a VTDPASIDAddressSpace for a device
> > > + * when it is bound to a pasid. Caller of this function should hold
> > > + * iommu_lock.
> > > + */
> > > +static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *=
s,
> > > +                                                   VTDBus *vtd_bus,
> > > +                                                   int devfn,
> > > +                                                   uint32_t pasid,
> > > +                                                   bool allocate)
> > > +{
> > > +    struct pasid_key key;
> > > +    struct pasid_key *new_key;
> > > +    VTDPASIDAddressSpace *vtd_pasid_as;
> > > +    uint16_t sid;
> > > +
> > > +    sid =3D vtd_make_source_id(pci_bus_num(vtd_bus->bus), devfn);
> > > +    vtd_init_pasid_key(pasid, sid, &key);
> > > +    vtd_pasid_as =3D g_hash_table_lookup(s->vtd_pasid_as, &key);
> > > +
> > > +    if (!vtd_pasid_as && allocate) {
> > > +        new_key =3D g_malloc0(sizeof(*new_key));
> > > +        vtd_init_pasid_key(pasid, sid, new_key);
> > > +        /*
> > > +         * Initiate the vtd_pasid_as structure.
> > > +         *
> > > +         * This structure here is used to track the guest pasid
> > > +         * binding and also serves as pasid-cache mangement entry.
> > > +         *
> > > +         * TODO: in future, if wants to support the SVA-aware DMA
> > > +         *       emulation, the vtd_pasid_as should have include
> > > +         *       AddressSpace to support DMA emulation.
> > > +         */
> > > +        vtd_pasid_as =3D g_malloc0(sizeof(VTDPASIDAddressSpace));
> > > +        vtd_pasid_as->iommu_state =3D s;
> > > +        vtd_pasid_as->vtd_bus =3D vtd_bus;
> > > +        vtd_pasid_as->devfn =3D devfn;
> > > +        vtd_pasid_as->context_cache_entry.context_cache_gen =3D 0;
> > > +        vtd_pasid_as->pasid =3D pasid;
> > > +        vtd_pasid_as->pasid_cache_entry.pasid_cache_gen =3D 0;
> > > +        g_hash_table_insert(s->vtd_pasid_as, new_key, vtd_pasid_as);
> > > +    }
> > > +    return vtd_pasid_as;
> > > +}
> > > +
> > > + /**
> > > +  * This function updates the pasid entry cached in &vtd_pasid_as.
> > > +  * Caller of this function should hold iommu_lock.
> > > +  */
> > > +static inline void vtd_fill_in_pe_cache(
> > > +              VTDPASIDAddressSpace *vtd_pasid_as, VTDPASIDEntry *pe)
> > > +{
> > > +    IntelIOMMUState *s =3D vtd_pasid_as->iommu_state;
> > > +    VTDPASIDCacheEntry *pc_entry =3D &vtd_pasid_as->pasid_cache_entr=
y;
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
> > > +    VTDIOMMUContext *vtd_icx;
> > > +
> > > +    /* PASID selective implies a DID selective */
> > > +    pc_info.flags =3D VTD_PASID_CACHE_PASIDSI;
> > > +    pc_info.domain_id =3D domain_id;
> > > +    pc_info.pasid =3D pasid;
> > > +
> > > +    /*
> > > +     * Regards to a pasid selective pasid cache invalidation (PSI),
> > > +     * it could be either cases of below:
> > > +     * a) a present pasid entry moved to non-present
> > > +     * b) a present pasid entry to be a present entry
> > > +     * c) a non-present pasid entry moved to present
> > > +     *
> > > +     * Here the handling of a PSI is:
> > > +     * 1) loop all the exisitng vtd_pasid_as instances to update the=
m
> > > +     *    according to the latest guest pasid entry in pasid table.
> > > +     *    this will make sure affected existing vtd_pasid_as instanc=
es
> > > +     *    cached the latest pasid entries. Also, during the loop, th=
e
> > > +     *    host should be notified if needed. e.g. pasid unbind or pa=
sid
> > > +     *    update. Should be able to cover case a) and case b).
> > > +     *
> > > +     * 2) loop all devices to cover case c)
> > > +     *    However, it is not good to always loop all devices. In thi=
s
> > > +     *    implementation. We do it in this ways:
> > > +     *    - For devices which have VTDIOMMUContext instances,
> > > +     *      we loop them and check if guest pasid entry exists. If y=
es,
> > > +     *      it is case c), we update the pasid cache and also notify
> > > +     *      host.
> > > +     *    - For devices which have no VTDIOMMUContext
> > > +     *      instances, it is not necessary to create pasid cache at
> > > +     *      this phase since it could be created when vIOMMU do DMA
> > > +     *      address translation. This is not implemented yet since
> > > +     *      no PASID-capable emulated devices today. If we have it
> > > +     *      in future, the pasid cache shall be created there.
> > > +     */
> > > +
> > > +    vtd_iommu_lock(s);
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                                vtd_flush_pasid, &pc_info);
> > > +
> > > +    QLIST_FOREACH(vtd_icx, &s->vtd_dev_icx_list, next) {
> > > +        vtd_bus =3D vtd_icx->vtd_bus;
> > > +        devfn =3D vtd_icx->devfn;
> > > +        bus_n =3D pci_bus_num(vtd_bus->bus);
> > > +
> > > +        /* Step 1: fetch vtd_pasid_as and check if it is valid */
> > > +        vtd_pasid_as =3D vtd_add_find_pasid_as(s, vtd_bus,
> > > +                                        devfn, pasid, true);
> >=20
> > I feel like you wanted to pass "false" here for "allocate".
>=20
> emmm, yeah. It was "false" in draft code as step 1 is only to check if
> a valid vtd_pasid_as exists. And in step 3, it needs to call
> vtd_add_find_pasid_as() with "allocate" be "true". In vtd_add_find_pasid_=
as(),
> it will try search vtd_pasid_as first and then allocate a new one. In suc=
h
> logic, there will be two vtd_add_find_pasid_as() callig and means two has=
h
> table searching.
>=20
> So I mofified it to be "true" to save a vtd_add_find_pasid_as() calling. =
If
> a vtd_pasid_as is valid, its pasid_cache_gen will be equal to s->pasid_ca=
che_gen.
> If not, the vtd_pasid_as is a newly allocated and needs to go through ste=
p 2
> and step 3 to fulfill it. Looks like I missed to free the vtd_pasid_as wh=
en step
> 2 failed. Will add it if you are fine with the current logic.

I see.  Note that vtd_add_find_pasid_as() is fast for no allocation,
because hash lookup is O(1).  However I think current approach is ok,
but if with that, we can also:

- Remove the allocate parameter for vtd_add_find_pasid_as(), since it's
  always true even in future patches so useless,

- Remove the vtd_pasid_as check right below because it's not needed.

>=20
>=20
> > > +        if (vtd_pasid_as &&
                   ^^^^^^^^^^^^

> > > +            (s->pasid_cache_gen =3D=3D
> > > +             vtd_pasid_as->pasid_cache_entry.pasid_cache_gen)) {
> > > +            /*
> > > +             * pasid_cache_gen equals to s->pasid_cache_gen means
> > > +             * vtd_pasid_as is valid after the above s->vtd_pasid_as
> > > +             * updates. Thus no need for the below steps.
> > > +             */
> > > +            continue;
> > > +        }
> > > +
> > > +        /*
> > > +         * Step 2: vtd_pasid_as is not valid, it's potentailly a
> > > +         * new pasid bind. Fetch guest pasid entry.
> > > +         */
> > > +        if (vtd_dev_get_pe_from_pasid(s, bus_n, devfn, pasid, &pe)) =
{
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
> > > +         *   - pass down the latest guest pasid entry config to host
> > > +         *     (will be added in later patch)
> > > +         */
> > > +        if (domain_id =3D=3D vtd_pe_get_domain_id(&pe)) {
> > > +            vtd_fill_in_pe_cache(vtd_pasid_as, &pe);
> > > +        }
> > > +    }
> > > +    vtd_iommu_unlock(s);
> > >      return 0;
> > >  }
> > >
> > > +/**
> > > + * Caller of this function should hold iommu_lock
> > > + */
> > > +static void vtd_pasid_cache_reset(IntelIOMMUState *s)
> > > +{
> > > +    VTDPASIDCacheInfo pc_info;
> > > +
> > > +    trace_vtd_pasid_cache_reset();
> > > +
> > > +    pc_info.flags =3D VTD_PASID_CACHE_GLOBAL;
> > > +
> > > +    /*
> > > +     * Reset pasid cache is a big hammer, so use
> > > +     * g_hash_table_foreach_remove which will free
> > > +     * the vtd_pasid_as instances.
> > > +     */
> > > +    g_hash_table_foreach_remove(s->vtd_pasid_as,
> > > +                           vtd_flush_pasid, &pc_info);
> > > +    s->pasid_cache_gen =3D 1;
> > > +}
> > > +
> > >  static int vtd_pasid_cache_gsi(IntelIOMMUState *s)
> > >  {
> > > +    trace_vtd_pasid_cache_gsi();
> > > +
> > > +    vtd_iommu_lock(s);
> > > +    vtd_pasid_cache_reset(s);
> >=20
> > [1]
> >=20
> > > +
> > > +    /*
> > > +     * TODO: Global PASID cache invalidation may be
> > > +     * flushes all the pasid caches. To be safe, after
> > > +     * invalidating the pasid caches, emulator needs
> > > +     * to replay the pasid bindings by walking guest
> > > +     * pasid dir and pasid table.
> > > +     */
> > > +    vtd_iommu_unlock(s);
> > >      return 0;
> > >  }
> > >
> > > @@ -3659,8 +4019,11 @@ static int
> > vtd_icx_register_ds_iommu(IOMMUContext *iommu_ctx,
> > >      VTDIOMMUContext *vtd_dev_icx =3D container_of(iommu_ctx,
> > >                                                 VTDIOMMUContext,
> > >                                                 iommu_context);
> > > +    IntelIOMMUState *s =3D vtd_dev_icx->iommu_state;
> > >
> > >      vtd_dev_icx->dsi_obj =3D dsi_obj;
> > > +    QLIST_INSERT_HEAD(&s->vtd_dev_icx_list, vtd_dev_icx, next);
> > > +
> > >      return 0;
> > >  }
> > >
> > > @@ -3672,6 +4035,7 @@ static void
> > vtd_icx_unregister_ds_iommu(IOMMUContext *iommu_ctx,
> > >                                                 iommu_context);
> > >
> > >      vtd_dev_icx->dsi_obj =3D NULL;
> > > +    QLIST_REMOVE(vtd_dev_icx, next);
> > >  }
> > >
> > >  IOMMUContextOps vtd_iommu_context_ops =3D {
> > > @@ -4130,6 +4494,7 @@ static void vtd_realize(DeviceState *dev, Error=
 **errp)
> > >      }
> > >
> > >      QLIST_INIT(&s->vtd_as_with_notifiers);
> > > +    QLIST_INIT(&s->vtd_dev_icx_list);
> > >      qemu_mutex_init(&s->iommu_lock);
> > >      memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
> > >      memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
> > > @@ -4155,6 +4520,8 @@ static void vtd_realize(DeviceState *dev, Error=
 **errp)
> > >                                       g_free, g_free);
> > >      s->vtd_as_by_busptr =3D g_hash_table_new_full(vtd_uint64_hash,
> > vtd_uint64_equal,
> > >                                                g_free, g_free);
> > > +    s->vtd_pasid_as =3D g_hash_table_new_full(vtd_pasid_as_key_hash,
> > > +                                   vtd_pasid_as_key_equal, g_free, g=
_free);
> > >      vtd_init(s);
> > >      sysbus_mmio_map(SYS_BUS_DEVICE(s), 0,
> > Q35_HOST_BRIDGE_IOMMU_ADDR);
> > >      pci_setup_iommu(bus, &vtd_iommu_ops, dev);
> > > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_int=
ernal.h
> > > index 6c03560..18a9e50 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -311,6 +311,7 @@ typedef enum VTDFaultReason {
> > >      VTD_FR_IR_SID_ERR =3D 0x26,   /* Invalid Source-ID */
> > >
> > >      VTD_FR_PASID_TABLE_INV =3D 0x58,  /*Invalid PASID table entry */
> > > +    VTD_FR_PASID_ENTRY_P =3D 0x59, /* The Present(P) field of pasidt=
-entry is 0
> > */
> > >
> > >      /* This is not a normal fault reason. We use this to indicate so=
me faults
> > >       * that are not referenced by the VT-d specification.
> > > @@ -485,6 +486,19 @@ struct VTDRootEntry {
> > >  };
> > >  typedef struct VTDRootEntry VTDRootEntry;
> > >
> > > +struct VTDPASIDCacheInfo {
> > > +#define VTD_PASID_CACHE_GLOBAL   (1ULL << 0)
> > > +#define VTD_PASID_CACHE_DOMSI    (1ULL << 1)
> > > +#define VTD_PASID_CACHE_PASIDSI  (1ULL << 2)
> > > +    uint32_t flags;
> > > +    uint16_t domain_id;
> > > +    uint32_t pasid;
> > > +};
> > > +#define VTD_PASID_CACHE_INFO_MASK    (VTD_PASID_CACHE_GLOBAL | \
> > > +                                      VTD_PASID_CACHE_DOMSI  | \
> > > +                                      VTD_PASID_CACHE_PASIDSI)
> > > +typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
> > > +
> > >  /* Masks for struct VTDRootEntry */
> > >  #define VTD_ROOT_ENTRY_P            1ULL
> > >  #define VTD_ROOT_ENTRY_CTP          (~0xfffULL)
> > > diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> > > index f7cd4e5..87364a3 100644
> > > --- a/hw/i386/trace-events
> > > +++ b/hw/i386/trace-events
> > > @@ -22,6 +22,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
> > >  vtd_inv_qi_tail(uint16_t head) "write tail %d"
> > >  vtd_inv_qi_fetch(void) ""
> > >  vtd_context_cache_reset(void) ""
> > > +vtd_pasid_cache_reset(void) ""
> > >  vtd_pasid_cache_gsi(void) ""
> > >  vtd_pasid_cache_dsi(uint16_t domain) "Domian slective PC invalidatio=
n
> > domain 0x%"PRIx16
> > >  vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective=
 PC
> > invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
> > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_io=
mmu.h
> > > index 4158116..3cc4b74 100644
> > > --- a/include/hw/i386/intel_iommu.h
> > > +++ b/include/hw/i386/intel_iommu.h
> > > @@ -69,6 +69,8 @@ typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
> > >  typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
> > >  typedef struct VTDPASIDEntry VTDPASIDEntry;
> > >  typedef struct VTDIOMMUContext VTDIOMMUContext;
> > > +typedef struct VTDPASIDCacheEntry VTDPASIDCacheEntry;
> > > +typedef struct VTDPASIDAddressSpace VTDPASIDAddressSpace;
> > >
> > >  /* Context-Entry */
> > >  struct VTDContextEntry {
> > > @@ -101,6 +103,31 @@ struct VTDPASIDEntry {
> > >      uint64_t val[8];
> > >  };
> > >
> > > +struct pasid_key {
> > > +    uint32_t pasid;
> > > +    uint16_t sid;
> > > +};
> > > +
> > > +struct VTDPASIDCacheEntry {
> > > +    /*
> > > +     * The cache entry is obsolete if
> > > +     * pasid_cache_gen!=3DIntelIOMMUState.pasid_cache_gen
> > > +     */
> > > +    uint32_t pasid_cache_gen;
> > > +    struct VTDPASIDEntry pasid_entry;
> > > +};
> > > +
> > > +struct VTDPASIDAddressSpace {
> > > +    VTDBus *vtd_bus;
> > > +    uint8_t devfn;
> > > +    AddressSpace as;
> > > +    uint32_t pasid;
> > > +    IntelIOMMUState *iommu_state;
> > > +    VTDContextCacheEntry context_cache_entry;
> > > +    QLIST_ENTRY(VTDPASIDAddressSpace) next;
> > > +    VTDPASIDCacheEntry pasid_cache_entry;
> >=20
> > In vtd_pasid_cache_gsi() [1], you directly reset pasid_cache_gen for
> > each pasid address space.  You never increase
> > pasid_cache_entry.pasid_cache_gen.  Then IIUC the gen will always be
> > either 0 or 1.  And...
> >=20
> > > +};
> > > +
> > >  struct VTDAddressSpace {
> > >      PCIBus *bus;
> > >      uint8_t devfn;
> > > @@ -122,6 +149,7 @@ struct VTDIOMMUContext {
> > >      uint8_t devfn;
> > >      IOMMUContext iommu_context;
> > >      DualStageIOMMUObject *dsi_obj;
> > > +    QLIST_ENTRY(VTDIOMMUContext) next;
> > >      IntelIOMMUState *iommu_state;
> > >  };
> > >
> > > @@ -272,9 +300,14 @@ struct IntelIOMMUState {
> > >
> > >      GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCI=
Bus*
> > reference */
> > >      VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects
> > indexed by bus number */
> > > +    GHashTable *vtd_pasid_as;   /* VTDPASIDAddressSpace instances */
> > > +    uint32_t pasid_cache_gen;   /* Should be in [1,MAX] */
> >=20
> > ... This should always be 1.
> > IIUC you can drop both of the pasid_cache_gen, because in this whole
> > patchset you'll remove the pasid hash entry when it is invalidated,
> > right?  Then if the hash entry is there, it must be valid.  When it's
> > out-dated, it'll be removed from the hash.
>=20
> Oh, yes it is. However, it's not my intetion. I'd like to let [1] to
> increase the s->pasid_cache_gen instead of justing zero it. I think it
> will save some time as loop hash table takes time. Thanks for catching
> it. :-)

OK that's fine too.  Then remember to conditionally reset it:

static int vtd_pasid_cache_gsi(IntelIOMMUState *s)
{
    trace_vtd_pasid_cache_gsi();

    vtd_iommu_lock(s);
    s->pasid_cache_gen++;
    if (s->pasid_cache_gen >=3D THRESHOLD) {
        vtd_pasid_cache_reset(s);
    }
    vtd_iommu_unlock(s);

    return 0;
}

Thanks,

--=20
Peter Xu


