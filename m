Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41695C072B1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06872541F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 05:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FF3raaI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06872541F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWDtv-0004gw-B6
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 01:46:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDm1-0006Y2-JP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWDlz-00049B-Gh
	for qemu-devel@nongnu.org; Thu, 30 May 2019 01:38:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWDly-00045u-Og; Thu, 30 May 2019 01:38:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DxFk5v1Vz9s3Z; Thu, 30 May 2019 15:38:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559194714;
	bh=Fc/95guM/RQU0nle+cNCsK2Y+t4qf7DltzAlHaEqgn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FF3raaI0WLs8I65mIpp/406lTSfDKVJdcyZCkvnD6C5Jc0a5Mb0/9DedRv2qpXreY
	Zu2SJQHeD88Pv7gV7MtqtrN3pkIMkujhmG3C7cHMrxhCW613GAvQorta0iwzF05WlD
	gSy59i8m0nGOoseZtMZ2dyg9BRFOFafdwDMXFNLE=
Date: Thu, 30 May 2019 15:33:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190530053316.GF2017@umbus.fritz.box>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190523052918.1129-3-david@gibson.dropbear.id.au>
	<5d839aa6-5308-2612-05fb-2ba446b293d7@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <5d839aa6-5308-2612-05fb-2ba446b293d7@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/8] spapr: Clean up dt creation
 for PCI buses
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
Cc: mst@redhat.com, groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	clg@kaod.org, mdroth@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 03:31:54PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 23/05/2019 15:29, David Gibson wrote:
> > Device nodes for PCI bridges (both host and P2P) describe both the brid=
ge
> > device itself and the bus hanging off it, handling of this is a bit of a
> > mess.
> >=20
> > spapr_dt_pci_device() has a few things it only adds for non-bridges, but
> > always adds #address-cells and #size-cells which should only appear for
> > bridges.  But the walking down the subordinate PCI bus is done in one of
> > its callers spapr_populate_pci_devices_dt().  The PHB dt creation in
> > spapr_populate_pci_dt() open codes some similar logic to the bridge cas=
e.
> >=20
> > This patch consolidates things in a bunch of ways:
> >  * Bus specific dt info is now created in spapr_dt_pci_bus() used for b=
oth
> >    P2P bridges and the host bridge.  This includes walking subordinate
> >    devices
> >  * spapr_dt_pci_device() now calls spapr_dt_pci_bus() when called on a
> >    P2P bridge
> >  * We do detection of bridges with the is_bridge field of the device cl=
ass,
> >    rather than checking PCI config space directly, for consistency with
> >    qemu's core PCI code.
> >  * Several things are renamed for brevity and clarity
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c              |   7 +-
> >  hw/ppc/spapr_pci.c          | 140 +++++++++++++++++++-----------------
> >  include/hw/pci-host/spapr.h |   4 +-
> >  3 files changed, 79 insertions(+), 72 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e2b33e5890..44573adce7 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1309,8 +1309,7 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
> >      }
> > =20
> >      QLIST_FOREACH(phb, &spapr->phbs, list) {
> > -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
> > -                                    spapr->irq->nr_msis, NULL);
> > +        ret =3D spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_ms=
is, NULL);
> >          if (ret < 0) {
> >              error_report("couldn't setup PCI devices in fdt");
> >              exit(1);
> > @@ -3917,8 +3916,8 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMac=
hineState *spapr,
> >          return -1;
> >      }
> > =20
> > -    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_=
msis,
> > -                              fdt_start_offset)) {
> > +    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
> > +                     fdt_start_offset)) {
> >          error_setg(errp, "unable to create FDT node for PHB %d", sphb-=
>index);
> >          return -1;
> >      }
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 4075b433fd..c166df4145 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1219,6 +1219,60 @@ static const char *dt_name_from_class(uint8_t cl=
ass, uint8_t subclass,
> >  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
> >                                              PCIDevice *pdev);
> > =20
> > +typedef struct PciWalkFdt {
> > +    void *fdt;
> > +    int offset;
> > +    SpaprPhbState *sphb;
> > +    int err;
> > +} PciWalkFdt;
> > +
> > +static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
> > +                               void *fdt, int parent_offset);
> > +
> > +static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
> > +                                   void *opaque)
> > +{
> > +    PciWalkFdt *p =3D opaque;
> > +    int err;
> > +
> > +    if (p->err) {
> > +        /* Something's already broken, don't keep going */
> > +        return;
> > +    }
> > +
> > +    err =3D spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
> > +    if (err < 0) {
> > +        p->err =3D err;
> > +    }
> > +}
> > +
> > +/* Augment PCI device node with bridge specific information */
> > +static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
> > +                               void *fdt, int offset)
> > +{
> > +    PciWalkFdt cbinfo =3D {
> > +        .fdt =3D fdt,
> > +        .offset =3D offset,
> > +        .sphb =3D sphb,
> > +        .err =3D 0,
> > +    };
> > +
> > +    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
> > +                          RESOURCE_CELLS_ADDRESS));
> > +    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
> > +                          RESOURCE_CELLS_SIZE));
> > +
> > +    if (bus) {
> > +        pci_for_each_device_reverse(bus, pci_bus_num(bus),
> > +                                    spapr_dt_pci_device_cb, &cbinfo);
> > +        if (cbinfo.err) {
> > +            return cbinfo.err;
> > +        }
> > +    }
> > +
> > +    return offset;
>=20
>=20
> This spapr_dt_pci_bus() returns 0 or an offset or an error.
>=20
> But:
> spapr_dt_phb() returns 0 or error; and so does spapr_dt_drc().
>=20
> Not extremely consistent.

No, it's not.  But the inconsistency is already there between the
device function which needs to return an offset and the PHB function
and others which don't.

I have some ideas for how to clean this up, along with a bunch of
other dt creation stuff, but I don't think it's reasonably in scope
for this series.

> It looks like spapr_dt_pci_bus() does not need to return @offset as it
> does not change it and the caller - spapr_dt_pci_device() - can have 1
> "return offset" in the end.

True, but changing this here just shuffles the inconsistency around
without really improving it.  I've put cleaning this up more widely on
my list of things to tackle when I have time.

>=20
>=20
> > +}
> > +
> >  /* create OF node for pci device and required OF DT properties */
> >  static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
> >                                 void *fdt, int parent_offset)
> > @@ -1228,10 +1282,9 @@ static int spapr_dt_pci_device(SpaprPhbState *sp=
hb, PCIDevice *dev,
> >      char *nodename;
> >      int slot =3D PCI_SLOT(dev->devfn);
> >      int func =3D PCI_FUNC(dev->devfn);
> > +    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> >      ResourceProps rp;
> >      uint32_t drc_index =3D spapr_phb_get_pci_drc_index(sphb, dev);
> > -    uint32_t header_type =3D pci_default_read_config(dev, PCI_HEADER_T=
YPE, 1);
> > -    bool is_bridge =3D (header_type =3D=3D PCI_HEADER_TYPE_BRIDGE);
> >      uint32_t vendor_id =3D pci_default_read_config(dev, PCI_VENDOR_ID,=
 2);
> >      uint32_t device_id =3D pci_default_read_config(dev, PCI_DEVICE_ID,=
 2);
> >      uint32_t revision_id =3D pci_default_read_config(dev, PCI_REVISION=
_ID, 1);
> > @@ -1268,13 +1321,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sp=
hb, PCIDevice *dev,
> >          _FDT(fdt_setprop_cell(fdt, offset, "interrupts", irq_pin));
> >      }
> > =20
> > -    if (!is_bridge) {
> > -        uint32_t min_grant =3D pci_default_read_config(dev, PCI_MIN_GN=
T, 1);
> > -        uint32_t max_latency =3D pci_default_read_config(dev, PCI_MAX_=
LAT, 1);
> > -        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
> > -        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latency)=
);
> > -    }
> > -
> >      if (subsystem_id) {
> >          _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id", subsystem_i=
d));
> >      }
> > @@ -1309,11 +1355,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sp=
hb, PCIDevice *dev,
> >          _FDT(fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_ind=
ex));
> >      }
> > =20
> > -    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
> > -                          RESOURCE_CELLS_ADDRESS));
> > -    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
> > -                          RESOURCE_CELLS_SIZE));
> > -
> >      if (msi_present(dev)) {
> >          uint32_t max_msi =3D msi_nr_vectors_allocated(dev);
> >          if (max_msi) {
> > @@ -1338,7 +1379,18 @@ static int spapr_dt_pci_device(SpaprPhbState *sp=
hb, PCIDevice *dev,
> > =20
> >      spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
> > =20
> > -    return offset;
> > +    if (!pc->is_bridge) {
> > +        /* Properties only for non-bridges */
> > +        uint32_t min_grant =3D pci_default_read_config(dev, PCI_MIN_GN=
T, 1);
> > +        uint32_t max_latency =3D pci_default_read_config(dev, PCI_MAX_=
LAT, 1);
> > +        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
> > +        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latency)=
);
> > +        return offset;
> > +    } else {
> > +        PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> > +
> > +        return spapr_dt_pci_bus(sphb, sec_bus, fdt, offset);
> > +    }
> >  }
> > =20
> >  /* Callback to be called during DRC release. */
> > @@ -2063,44 +2115,6 @@ static const TypeInfo spapr_phb_info =3D {
> >      }
> >  };
> > =20
> > -typedef struct SpaprFdt {
> > -    void *fdt;
> > -    int node_off;
> > -    SpaprPhbState *sphb;
> > -} SpaprFdt;
> > -
> > -static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pdev,
> > -                                          void *opaque)
> > -{
> > -    PCIBus *sec_bus;
> > -    SpaprFdt *p =3D opaque;
> > -    int offset;
> > -    SpaprFdt s_fdt;
> > -
> > -    offset =3D spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->node_off);
> > -    if (!offset) {
> > -        error_report("Failed to create pci child device tree node");
> > -        return;
> > -    }
> > -
> > -    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
> > -         PCI_HEADER_TYPE_BRIDGE)) {
> > -        return;
> > -    }
> > -
> > -    sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> > -    if (!sec_bus) {
> > -        return;
> > -    }
> > -
> > -    s_fdt.fdt =3D p->fdt;
> > -    s_fdt.node_off =3D offset;
> > -    s_fdt.sphb =3D p->sphb;
> > -    pci_for_each_device_reverse(sec_bus, pci_bus_num(sec_bus),
> > -                                spapr_populate_pci_devices_dt,
> > -                                &s_fdt);
> > -}
> > -
> >  static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pde=
v,
> >                                             void *opaque)
> >  {
> > @@ -2138,8 +2152,8 @@ static void spapr_phb_pci_enumerate(SpaprPhbState=
 *phb)
> > =20
> >  }
> > =20
> > -int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, v=
oid *fdt,
> > -                          uint32_t nr_msis, int *node_offset)
> > +int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
> > +                 uint32_t nr_msis, int *node_offset)
> >  {
> >      int bus_off, i, j, ret;
> >      uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
> > @@ -2186,8 +2200,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uin=
t32_t intc_phandle, void *fdt,
> >                                  cpu_to_be32(0x0),
> >                                  cpu_to_be32(phb->numa_node)};
> >      SpaprTceTable *tcet;
> > -    PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
> > -    SpaprFdt s_fdt;
> >      SpaprDrc *drc;
> >      Error *errp =3D NULL;
> > =20
> > @@ -2200,8 +2212,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uin=
t32_t intc_phandle, void *fdt,
> >      /* Write PHB properties */
> >      _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
> >      _FDT(fdt_setprop_string(fdt, bus_off, "compatible", "IBM,Logical_P=
HB"));
> > -    _FDT(fdt_setprop_cell(fdt, bus_off, "#address-cells", 0x3));
> > -    _FDT(fdt_setprop_cell(fdt, bus_off, "#size-cells", 0x2));
> >      _FDT(fdt_setprop_cell(fdt, bus_off, "#interrupt-cells", 0x1));
> >      _FDT(fdt_setprop(fdt, bus_off, "used-by-rtas", NULL, 0));
> >      _FDT(fdt_setprop(fdt, bus_off, "bus-range", &bus_range, sizeof(bus=
_range)));
> > @@ -2266,13 +2276,11 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, u=
int32_t intc_phandle, void *fdt,
> >      spapr_phb_pci_enumerate(phb);
> >      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
> > =20
> > -    /* Populate tree nodes with PCI devices attached */
> > -    s_fdt.fdt =3D fdt;
> > -    s_fdt.node_off =3D bus_off;
> > -    s_fdt.sphb =3D phb;
> > -    pci_for_each_device_reverse(bus, pci_bus_num(bus),
> > -                                spapr_populate_pci_devices_dt,
> > -                                &s_fdt);
> > +    /* Walk the bridge and subordinate buses */
> > +    ret =3D spapr_dt_pci_bus(phb, PCI_HOST_BRIDGE(phb)->bus, fdt, bus_=
off);
> > +    if (ret) {
>=20
>=20
> if (ret < 0)
>=20
> otherwise it returns prematurely and NVLink stuff does not make it to
> the FDT.
>=20
>=20
> Otherwise the whole patchset is a good cleanup and seems working fine.
>=20
>=20
> > +        return ret;
> > +    }
> > =20
> >      ret =3D spapr_drc_populate_dt(fdt, bus_off, OBJECT(phb),
> >                                  SPAPR_DR_CONNECTOR_TYPE_PCI);
> > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > index 53519c835e..1b61162f91 100644
> > --- a/include/hw/pci-host/spapr.h
> > +++ b/include/hw/pci-host/spapr.h
> > @@ -131,8 +131,8 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct Sp=
aprPhbState *phb, int pin)
> >      return spapr_qirq(spapr, phb->lsi_table[pin].irq);
> >  }
> > =20
> > -int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, v=
oid *fdt,
> > -                          uint32_t nr_msis, int *node_offset);
> > +int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
> > +                 uint32_t nr_msis, int *node_offset);
> > =20
> >  void spapr_pci_rtas_init(void);
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzvaxoACgkQbDjKyiDZ
s5KEDg/8Dxj+1Uf+z+ydRErqtb4sNgli4erFFIZYmC3yxJxD+xIwbZR80zjJkP7Y
q9lZYPqXMUIF37tS2s2kSMOxKTtIi6tatknPc80mo/UcUOSy1g02Dz+DpYjCqp+y
+gYCWBlhghjoax/rWB32k+PuXaS7adwN8sRl0bA65L4NO+eU6kkvOWW90it5XVBA
lgl3kRMToOzGt3fUW45Zo5ILG3lBFxuzrZdeVMXPju5bGpBDx6+YzZY8lnI81Bv/
bpHcFtf5Q0SESSadop0YTAu1pe5p/rDGuzjv/lInar0tYRXnXBwYCo0EkkBoiJQU
1QOQzhvTD/NUk0SUoP4zcOrERxQFiRcbw/3wJu800C6KFEAcAQA3RlKCVWhrLYYR
IFwFICzgnCV0fovxolgDjgrnNXjGFjKkp4Ok14qjTAfFw4j/KgYw1mn+imqM+wF5
ClUawf4SS3zdffAmW076t1AI/x1CSg7Amvtk79VsCXvMtq3Fic66slQsc5PGh+Kv
C/pQFuQT20/d7UzkFmo3pXxlnWHIJ2QF9Uq4qqtwaH/gzJmEKk/W9txHj9uGVcC0
PKQ3siNREsCGXUKez68YB7kTmiNi7uOCpCX2aidOAvzdBl2WK7hJCH5WqMrbYfbe
lO6zDFOw4v2Ec2yad4ZpynUQT8gK0yPoT36U1/XZz8pr5bAD2oU=
=Gyb6
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

