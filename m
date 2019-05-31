Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF10C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096D826819
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 11:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HVmAu4f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096D826819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfT9-0003uO-BJ
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 07:13:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWfRu-0003AV-S5
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hWfRs-0006Ap-Pq
	for qemu-devel@nongnu.org; Fri, 31 May 2019 07:11:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40485 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hWfRr-00067M-Af; Fri, 31 May 2019 07:11:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45Fhbg5vkWz9sCJ; Fri, 31 May 2019 21:11:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559301103;
	bh=v/Sb0tCQTbrwAkJhotRl9GIbuZLXg7JVOk5cTI8nfhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVmAu4f76VP6R6961CgSG9+kO5qDhhAX9EpRx1/bHatsRFo9oNOoAePXr3xlDur4J
	oIQn4ZgudI6VNty+OlyvvUg6ZQky9gE5ix7chRKVrIOI8H/vUJv21r/6SYSNF0LShH
	Dex/zop8NmBCfzVnfm7coeySWY+pTR4tw61j9rgc=
Date: Fri, 31 May 2019 20:24:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190531102428.GI2017@umbus.fritz.box>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190523052918.1129-3-david@gibson.dropbear.id.au>
	<5d839aa6-5308-2612-05fb-2ba446b293d7@ozlabs.ru>
	<20190530053316.GF2017@umbus.fritz.box>
	<3e0e0805-42ac-5fcd-012a-e428bafbec16@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Content-Disposition: inline
In-Reply-To: <3e0e0805-42ac-5fcd-012a-e428bafbec16@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2019 at 03:43:26PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 30/05/2019 15:33, David Gibson wrote:
> > On Fri, May 24, 2019 at 03:31:54PM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 23/05/2019 15:29, David Gibson wrote:
> >>> Device nodes for PCI bridges (both host and P2P) describe both the br=
idge
> >>> device itself and the bus hanging off it, handling of this is a bit o=
f a
> >>> mess.
> >>>
> >>> spapr_dt_pci_device() has a few things it only adds for non-bridges, =
but
> >>> always adds #address-cells and #size-cells which should only appear f=
or
> >>> bridges.  But the walking down the subordinate PCI bus is done in one=
 of
> >>> its callers spapr_populate_pci_devices_dt().  The PHB dt creation in
> >>> spapr_populate_pci_dt() open codes some similar logic to the bridge c=
ase.
> >>>
> >>> This patch consolidates things in a bunch of ways:
> >>>  * Bus specific dt info is now created in spapr_dt_pci_bus() used for=
 both
> >>>    P2P bridges and the host bridge.  This includes walking subordinate
> >>>    devices
> >>>  * spapr_dt_pci_device() now calls spapr_dt_pci_bus() when called on a
> >>>    P2P bridge
> >>>  * We do detection of bridges with the is_bridge field of the device =
class,
> >>>    rather than checking PCI config space directly, for consistency wi=
th
> >>>    qemu's core PCI code.
> >>>  * Several things are renamed for brevity and clarity
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/ppc/spapr.c              |   7 +-
> >>>  hw/ppc/spapr_pci.c          | 140 +++++++++++++++++++---------------=
--
> >>>  include/hw/pci-host/spapr.h |   4 +-
> >>>  3 files changed, 79 insertions(+), 72 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index e2b33e5890..44573adce7 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -1309,8 +1309,7 @@ static void *spapr_build_fdt(SpaprMachineState =
*spapr)
> >>>      }
> >>> =20
> >>>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> >>> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
> >>> -                                    spapr->irq->nr_msis, NULL);
> >>> +        ret =3D spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_=
msis, NULL);
> >>>          if (ret < 0) {
> >>>              error_report("couldn't setup PCI devices in fdt");
> >>>              exit(1);
> >>> @@ -3917,8 +3916,8 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprM=
achineState *spapr,
> >>>          return -1;
> >>>      }
> >>> =20
> >>> -    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->n=
r_msis,
> >>> -                              fdt_start_offset)) {
> >>> +    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
> >>> +                     fdt_start_offset)) {
> >>>          error_setg(errp, "unable to create FDT node for PHB %d", sph=
b->index);
> >>>          return -1;
> >>>      }
> >>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> >>> index 4075b433fd..c166df4145 100644
> >>> --- a/hw/ppc/spapr_pci.c
> >>> +++ b/hw/ppc/spapr_pci.c
> >>> @@ -1219,6 +1219,60 @@ static const char *dt_name_from_class(uint8_t =
class, uint8_t subclass,
> >>>  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
> >>>                                              PCIDevice *pdev);
> >>> =20
> >>> +typedef struct PciWalkFdt {
> >>> +    void *fdt;
> >>> +    int offset;
> >>> +    SpaprPhbState *sphb;
> >>> +    int err;
> >>> +} PciWalkFdt;
> >>> +
> >>> +static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
> >>> +                               void *fdt, int parent_offset);
> >>> +
> >>> +static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
> >>> +                                   void *opaque)
> >>> +{
> >>> +    PciWalkFdt *p =3D opaque;
> >>> +    int err;
> >>> +
> >>> +    if (p->err) {
> >>> +        /* Something's already broken, don't keep going */
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    err =3D spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
> >>> +    if (err < 0) {
> >>> +        p->err =3D err;
> >>> +    }
> >>> +}
> >>> +
> >>> +/* Augment PCI device node with bridge specific information */
> >>> +static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
> >>> +                               void *fdt, int offset)
> >>> +{
> >>> +    PciWalkFdt cbinfo =3D {
> >>> +        .fdt =3D fdt,
> >>> +        .offset =3D offset,
> >>> +        .sphb =3D sphb,
> >>> +        .err =3D 0,
> >>> +    };
> >>> +
> >>> +    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
> >>> +                          RESOURCE_CELLS_ADDRESS));
> >>> +    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
> >>> +                          RESOURCE_CELLS_SIZE));
> >>> +
> >>> +    if (bus) {
> >>> +        pci_for_each_device_reverse(bus, pci_bus_num(bus),
> >>> +                                    spapr_dt_pci_device_cb, &cbinfo);
> >>> +        if (cbinfo.err) {
> >>> +            return cbinfo.err;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    return offset;
> >>
> >>
> >> This spapr_dt_pci_bus() returns 0 or an offset or an error.
> >>
> >> But:
> >> spapr_dt_phb() returns 0 or error; and so does spapr_dt_drc().
> >>
> >> Not extremely consistent.
> >=20
> > No, it's not.  But the inconsistency is already there between the
> > device function which needs to return an offset and the PHB function
> > and others which don't.
> >=20
> > I have some ideas for how to clean this up, along with a bunch of
> > other dt creation stuff, but I don't think it's reasonably in scope
> > for this series.
> >=20
> >> It looks like spapr_dt_pci_bus() does not need to return @offset as it
> >> does not change it and the caller - spapr_dt_pci_device() - can have 1
> >> "return offset" in the end.
> >=20
> > True, but changing this here just shuffles the inconsistency around
> > without really improving it.  I've put cleaning this up more widely on
> > my list of things to tackle when I have time.
> >=20
> >>
> >>
> >>> +}
> >>> +
> >>>  /* create OF node for pci device and required OF DT properties */
> >>>  static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
> >>>                                 void *fdt, int parent_offset)
> >>> @@ -1228,10 +1282,9 @@ static int spapr_dt_pci_device(SpaprPhbState *=
sphb, PCIDevice *dev,
> >>>      char *nodename;
> >>>      int slot =3D PCI_SLOT(dev->devfn);
> >>>      int func =3D PCI_FUNC(dev->devfn);
> >>> +    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> >>>      ResourceProps rp;
> >>>      uint32_t drc_index =3D spapr_phb_get_pci_drc_index(sphb, dev);
> >>> -    uint32_t header_type =3D pci_default_read_config(dev, PCI_HEADER=
_TYPE, 1);
> >>> -    bool is_bridge =3D (header_type =3D=3D PCI_HEADER_TYPE_BRIDGE);
> >>>      uint32_t vendor_id =3D pci_default_read_config(dev, PCI_VENDOR_I=
D, 2);
> >>>      uint32_t device_id =3D pci_default_read_config(dev, PCI_DEVICE_I=
D, 2);
> >>>      uint32_t revision_id =3D pci_default_read_config(dev, PCI_REVISI=
ON_ID, 1);
> >>> @@ -1268,13 +1321,6 @@ static int spapr_dt_pci_device(SpaprPhbState *=
sphb, PCIDevice *dev,
> >>>          _FDT(fdt_setprop_cell(fdt, offset, "interrupts", irq_pin));
> >>>      }
> >>> =20
> >>> -    if (!is_bridge) {
> >>> -        uint32_t min_grant =3D pci_default_read_config(dev, PCI_MIN_=
GNT, 1);
> >>> -        uint32_t max_latency =3D pci_default_read_config(dev, PCI_MA=
X_LAT, 1);
> >>> -        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
> >>> -        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latenc=
y));
> >>> -    }
> >>> -
> >>>      if (subsystem_id) {
> >>>          _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id", subsystem=
_id));
> >>>      }
> >>> @@ -1309,11 +1355,6 @@ static int spapr_dt_pci_device(SpaprPhbState *=
sphb, PCIDevice *dev,
> >>>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_i=
ndex));
> >>>      }
> >>> =20
> >>> -    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells",
> >>> -                          RESOURCE_CELLS_ADDRESS));
> >>> -    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
> >>> -                          RESOURCE_CELLS_SIZE));
> >>> -
> >>>      if (msi_present(dev)) {
> >>>          uint32_t max_msi =3D msi_nr_vectors_allocated(dev);
> >>>          if (max_msi) {
> >>> @@ -1338,7 +1379,18 @@ static int spapr_dt_pci_device(SpaprPhbState *=
sphb, PCIDevice *dev,
> >>> =20
> >>>      spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
> >>> =20
> >>> -    return offset;
> >>> +    if (!pc->is_bridge) {
> >>> +        /* Properties only for non-bridges */
> >>> +        uint32_t min_grant =3D pci_default_read_config(dev, PCI_MIN_=
GNT, 1);
> >>> +        uint32_t max_latency =3D pci_default_read_config(dev, PCI_MA=
X_LAT, 1);
> >>> +        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
> >>> +        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latenc=
y));
> >>> +        return offset;
> >>> +    } else {
> >>> +        PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> >>> +
> >>> +        return spapr_dt_pci_bus(sphb, sec_bus, fdt, offset);
> >>> +    }
> >>>  }
> >>> =20
> >>>  /* Callback to be called during DRC release. */
> >>> @@ -2063,44 +2115,6 @@ static const TypeInfo spapr_phb_info =3D {
> >>>      }
> >>>  };
> >>> =20
> >>> -typedef struct SpaprFdt {
> >>> -    void *fdt;
> >>> -    int node_off;
> >>> -    SpaprPhbState *sphb;
> >>> -} SpaprFdt;
> >>> -
> >>> -static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pd=
ev,
> >>> -                                          void *opaque)
> >>> -{
> >>> -    PCIBus *sec_bus;
> >>> -    SpaprFdt *p =3D opaque;
> >>> -    int offset;
> >>> -    SpaprFdt s_fdt;
> >>> -
> >>> -    offset =3D spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->node_of=
f);
> >>> -    if (!offset) {
> >>> -        error_report("Failed to create pci child device tree node");
> >>> -        return;
> >>> -    }
> >>> -
> >>> -    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
> >>> -         PCI_HEADER_TYPE_BRIDGE)) {
> >>> -        return;
> >>> -    }
> >>> -
> >>> -    sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >>> -    if (!sec_bus) {
> >>> -        return;
> >>> -    }
> >>> -
> >>> -    s_fdt.fdt =3D p->fdt;
> >>> -    s_fdt.node_off =3D offset;
> >>> -    s_fdt.sphb =3D p->sphb;
> >>> -    pci_for_each_device_reverse(sec_bus, pci_bus_num(sec_bus),
> >>> -                                spapr_populate_pci_devices_dt,
> >>> -                                &s_fdt);
> >>> -}
> >>> -
> >>>  static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *p=
dev,
> >>>                                             void *opaque)
> >>>  {
> >>> @@ -2138,8 +2152,8 @@ static void spapr_phb_pci_enumerate(SpaprPhbSta=
te *phb)
> >>> =20
> >>>  }
> >>> =20
> >>> -int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle,=
 void *fdt,
> >>> -                          uint32_t nr_msis, int *node_offset)
> >>> +int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fd=
t,
> >>> +                 uint32_t nr_msis, int *node_offset)
> >>>  {
> >>>      int bus_off, i, j, ret;
> >>>      uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
> >>> @@ -2186,8 +2200,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, u=
int32_t intc_phandle, void *fdt,
> >>>                                  cpu_to_be32(0x0),
> >>>                                  cpu_to_be32(phb->numa_node)};
> >>>      SpaprTceTable *tcet;
> >>> -    PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
> >>> -    SpaprFdt s_fdt;
> >>>      SpaprDrc *drc;
> >>>      Error *errp =3D NULL;
> >>> =20
> >>> @@ -2200,8 +2212,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, u=
int32_t intc_phandle, void *fdt,
> >>>      /* Write PHB properties */
> >>>      _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
> >>>      _FDT(fdt_setprop_string(fdt, bus_off, "compatible", "IBM,Logical=
_PHB"));
> >>> -    _FDT(fdt_setprop_cell(fdt, bus_off, "#address-cells", 0x3));
> >>> -    _FDT(fdt_setprop_cell(fdt, bus_off, "#size-cells", 0x2));
> >>>      _FDT(fdt_setprop_cell(fdt, bus_off, "#interrupt-cells", 0x1));
> >>>      _FDT(fdt_setprop(fdt, bus_off, "used-by-rtas", NULL, 0));
> >>>      _FDT(fdt_setprop(fdt, bus_off, "bus-range", &bus_range, sizeof(b=
us_range)));
> >>> @@ -2266,13 +2276,11 @@ int spapr_populate_pci_dt(SpaprPhbState *phb,=
 uint32_t intc_phandle, void *fdt,
> >>>      spapr_phb_pci_enumerate(phb);
> >>>      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
> >>> =20
> >>> -    /* Populate tree nodes with PCI devices attached */
> >>> -    s_fdt.fdt =3D fdt;
> >>> -    s_fdt.node_off =3D bus_off;
> >>> -    s_fdt.sphb =3D phb;
> >>> -    pci_for_each_device_reverse(bus, pci_bus_num(bus),
> >>> -                                spapr_populate_pci_devices_dt,
> >>> -                                &s_fdt);
> >>> +    /* Walk the bridge and subordinate buses */
> >>> +    ret =3D spapr_dt_pci_bus(phb, PCI_HOST_BRIDGE(phb)->bus, fdt, bu=
s_off);
> >>> +    if (ret) {
> >>
> >>
> >> if (ret < 0)
> >>
> >> otherwise it returns prematurely and NVLink stuff does not make it to
> >> the FDT.
> >>
> >>
> >> Otherwise the whole patchset is a good cleanup and seems working fine.
>=20
>=20
> Just to double check you have not missed this bit :)

Bother, I did miss this bit.  Fixed now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzxANoACgkQbDjKyiDZ
s5ImHRAAmWYbegF3iiDMd7O1PzXsm8OhROAZAnuZaGyvk9jamB3WLgyegFQ0T97T
8C1dD6KFz8VfM0LzPBBWkXLmctQLEEk3ZU9qghvfMq18/7g7ndRye4TP64VmcvAn
BWjG+yWgkOrOMvNpHXZtPYB1eSk5E7f2Rt7Gus9iHGIEnRFrkhN7F9aW+ieyIVPG
tRDlVLgtsjNgCWRNQxFbDHDv0Lb370MgYhAUFE0aqLi91VWUvt2vZfgQpfGNtW+b
RQb9Vpc/Wsuv/D7Z1Zq8mCeQGQ8Q+GZgqS41gfOuDhI8IPS+p9uKqaOSYyyTFOcI
Kg1tvadKSSLr5PR2nUk4mpXGx4cioOz9hHlThWS3nh3GVrLSDROCeuqr3sMaMJwK
E/vmqqBOpUytA1I2EooP5++VFxeSErs3uUNywQqp6QkH7EiAsPk3W0+MNRnx7HI0
9I/Xnjk2Eo/Pw9e5EsUliJ3N8j2GQbH5M1DXLghvj3Oadjy+QT2QeLOlwBb8uE4b
IBegftXXVhzFCXEITa3Wwk4/NWv6RbDEffXlXmIyjDglKGbkc4C7fOiSz6nqaxZt
F0kC77WexPKWls32fp1VZjsI66flwzXpcbZrnaSOSAnwMu37BQz9wv8u4M+DcO5I
Y2WdRYNNHG9++CKVydRQ60/rE8SFp7v2pLgGXXhY/vde4AhkOzQ=
=OaK3
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--

