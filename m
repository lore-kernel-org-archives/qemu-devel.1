Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3543C2D0F2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9062166E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9062166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFyo-00065S-Pg
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJFy9-0005ex-6b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJFy6-0003OK-O2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:26:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:14982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jJFy3-0003Ig-9M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:26:10 -0400
IronPort-SDR: +l0tih5o95WraKyfm150uNTFWEanTPdCwWcZGn3FrAB/mW+QsczYYgyGsybSN9eJZkX2HiLm+8
 SS4sP2mQ3bEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 05:26:04 -0700
IronPort-SDR: nnRd3nWz2wwxzw5xsvy8i6hxIiUie4b+GlxMpReJPIIc0gHBU7cpP/G6fjypOYSEKxlFYEWI9P
 aWaUZzLaz2mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="328067933"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga001.jf.intel.com with ESMTP; 31 Mar 2020 05:26:04 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 05:26:04 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 05:26:03 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 20:26:00 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 07/22] intel_iommu: add set/unset_iommu_context callback
Thread-Topic: [PATCH v2 07/22] intel_iommu: add set/unset_iommu_context
 callback
Thread-Index: AQHWBkpjC0u1RP4NDUSzp1PXmPweUahhD5IAgAGPy7A=
Date: Tue, 31 Mar 2020 12:25:59 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21AF24@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-8-git-send-email-yi.l.liu@intel.com>
 <a444318b-32c7-d43c-112a-d35a870b162d@redhat.com>
In-Reply-To: <a444318b-32c7-d43c-112a-d35a870b162d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> From: Auger Eric < eric.auger@redhat.com>
> Sent: Tuesday, March 31, 2020 4:24 AM
> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> Subject: Re: [PATCH v2 07/22] intel_iommu: add set/unset_iommu_context ca=
llback
>=20
> Yi,
>=20
> On 3/30/20 6:24 AM, Liu Yi L wrote:
> > This patch adds set/unset_iommu_context() impelementation in Intel
> This patch implements the set/unset_iommu_context() ops for Intel vIOMMU.
> > vIOMMU. For Intel platform, pass-through modules (e.g. VFIO) could
> > set HostIOMMUContext to Intel vIOMMU emulator.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  hw/i386/intel_iommu.c         | 71
> ++++++++++++++++++++++++++++++++++++++++---
> >  include/hw/i386/intel_iommu.h | 21 ++++++++++---
> >  2 files changed, 83 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 4b22910..fd349c6 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -3354,23 +3354,33 @@ static const MemoryRegionOps vtd_mem_ir_ops =3D=
 {
> >      },
> >  };
> >
> > -VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int =
devfn)
> > +/**
> > + * Fetch a VTDBus instance for given PCIBus. If no existing instance,
> > + * allocate one.
> > + */
> > +static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
> >  {
> >      uintptr_t key =3D (uintptr_t)bus;
> >      VTDBus *vtd_bus =3D g_hash_table_lookup(s->vtd_as_by_busptr, &key)=
;
> > -    VTDAddressSpace *vtd_dev_as;
> > -    char name[128];
> >
> >      if (!vtd_bus) {
> >          uintptr_t *new_key =3D g_malloc(sizeof(*new_key));
> >          *new_key =3D (uintptr_t)bus;
> >          /* No corresponding free() */
> > -        vtd_bus =3D g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace =
*) * \
> > -                            PCI_DEVFN_MAX);
> > +        vtd_bus =3D g_malloc0(sizeof(VTDBus));
> >          vtd_bus->bus =3D bus;
> >          g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
> >      }
> > +    return vtd_bus;
> > +}
> >
> > +VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int =
devfn)
> > +{
> > +    VTDBus *vtd_bus;
> > +    VTDAddressSpace *vtd_dev_as;
> > +    char name[128];
> > +
> > +    vtd_bus =3D vtd_find_add_bus(s, bus);
> >      vtd_dev_as =3D vtd_bus->dev_as[devfn];
> >
> >      if (!vtd_dev_as) {
> > @@ -3436,6 +3446,55 @@ VTDAddressSpace
> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
> >      return vtd_dev_as;
> >  }
> >
> > +static int vtd_dev_set_iommu_context(PCIBus *bus, void *opaque,
> > +                                     int devfn,
> > +                                     HostIOMMUContext *iommu_ctx)
> > +{
> > +    IntelIOMMUState *s =3D opaque;
> > +    VTDBus *vtd_bus;
> > +    VTDHostIOMMUContext *vtd_dev_icx;
> > +
> > +    assert(0 <=3D devfn && devfn < PCI_DEVFN_MAX);
> > +
> > +    vtd_bus =3D vtd_find_add_bus(s, bus);
> > +
> > +    vtd_iommu_lock(s);
> > +
> > +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> > +
> > +    assert(!vtd_dev_icx);
> > +
> > +    vtd_bus->dev_icx[devfn] =3D vtd_dev_icx =3D
> > +                    g_malloc0(sizeof(VTDHostIOMMUContext));
> > +    vtd_dev_icx->vtd_bus =3D vtd_bus;
> > +    vtd_dev_icx->devfn =3D (uint8_t)devfn;
> > +    vtd_dev_icx->iommu_state =3D s;
> > +    vtd_dev_icx->iommu_ctx =3D iommu_ctx;
> > +
> > +    vtd_iommu_unlock(s);
> > +
> > +    return 0;
> > +}
> > +
> > +static void vtd_dev_unset_iommu_context(PCIBus *bus, void *opaque, int=
 devfn)
> > +{
> > +    IntelIOMMUState *s =3D opaque;
> > +    VTDBus *vtd_bus;
> > +    VTDHostIOMMUContext *vtd_dev_icx;
> > +
> > +    assert(0 <=3D devfn && devfn < PCI_DEVFN_MAX);
> > +
> > +    vtd_bus =3D vtd_find_add_bus(s, bus);
> > +
> > +    vtd_iommu_lock(s);
> > +
> > +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> > +    g_free(vtd_dev_icx);
> > +    vtd_bus->dev_icx[devfn] =3D NULL;
> > +
> > +    vtd_iommu_unlock(s);
> > +}
> > +
> >  static uint64_t get_naturally_aligned_size(uint64_t start,
> >                                             uint64_t size, int gaw)
> >  {
> > @@ -3731,6 +3790,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus
> *bus, void *opaque, int devfn)
> >
> >  static PCIIOMMUOps vtd_iommu_ops =3D {
> >      .get_address_space =3D vtd_host_dma_iommu,
> > +    .set_iommu_context =3D vtd_dev_set_iommu_context,
> > +    .unset_iommu_context =3D vtd_dev_unset_iommu_context,
> >  };
> >
> >  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iomm=
u.h
> > index 3870052..b5fefb9 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -64,6 +64,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
> >  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
> >  typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
> >  typedef struct VTDPASIDEntry VTDPASIDEntry;
> > +typedef struct VTDHostIOMMUContext VTDHostIOMMUContext;
> >
> >  /* Context-Entry */
> >  struct VTDContextEntry {
> > @@ -112,10 +113,20 @@ struct VTDAddressSpace {
> >      IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
> >  };
> >
> > +struct VTDHostIOMMUContext {
>=20
>=20
> > +    VTDBus *vtd_bus;
> > +    uint8_t devfn;
> > +    HostIOMMUContext *iommu_ctx;
> I don't get why we don't have standard QOM inheritance instead of this
> handle?
> VTDHostContext parent_obj;
>=20
> like IOMMUMemoryRegion <- MemoryRegion <- Object

Here it is not inherit the object. It's just cache the HostIOMMUContext
pointer in vIOMMU. Just like AddressSpace, it has a MemoryRegion pointer.
Here is the same, VTDHostIOMMUContext is just a wrapper to better manage
it in vVT-d. It's not inheriting.

> > +    IntelIOMMUState *iommu_state;
> > +};
> > +
> >  struct VTDBus {
> > -    PCIBus* bus;		/* A reference to the bus to provide translation for
> */
> > +    /* A reference to the bus to provide translation for */
> > +    PCIBus *bus;
> >      /* A table of VTDAddressSpace objects indexed by devfn */
> > -    VTDAddressSpace *dev_as[];
> > +    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
> > +    /* A table of VTDHostIOMMUContext objects indexed by devfn */
> > +    VTDHostIOMMUContext *dev_icx[PCI_DEVFN_MAX];
> At this point of the review, it is unclear to me why the context is
> associated to a device.

HostIOMMUContext can be per-device or not. It depends on how vIOMMU
manage it. For vVT-d, it's per device as the container is per-device.

> Up to now you have not explained it should. If
> so why isn't it part of VTDAddressSpace?

Ah, I did have considered it. But I chose to use a separate one as
context is not really tied with an addresspace. It's better to mange
it with a separate structure.

Regards,
Yi Liu

