Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2DC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAA720851
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZQw5emVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAA720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbtf-0005XE-6C
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:35:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbqf-0003qv-4j
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbqd-000079-Gy
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:32:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSbqb-0008Ve-H6; Mon, 20 May 2019 02:32:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 456pwQ3SfGz9s9N; Mon, 20 May 2019 16:32:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558333942;
	bh=K+lDJZgjNbqb9bGeKEk/01LeGcb2gl8D7IVL1DVnpZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQw5emVMnvUZ2t7rX1romH7ElrQbbQ9N9G5xhoNNMtdfVk3dNBRLgLcM//4czUn2N
	/iBdtQRWjTCJ08lBv6p8HCvp4mClBbs0scAzTP8jupxnLcii4+qPKUJ9kNwJy2vSaI
	ZTdR7H4aBeJ1gDkISKKBFjIxTDzXI4G9R8uyhp70=
Date: Mon, 20 May 2019 16:06:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190520060609.GB27407@umbus.fritz.box>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
	<20190426060627.18153-2-david@gibson.dropbear.id.au>
	<2187f170-8a8b-356d-78e0-fb010443df3b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <2187f170-8a8b-356d-78e0-fb010443df3b@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PULL 01/36] spapr: Support NVIDIA V100 GPU with
 NVLink2
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
Cc: peter.maydell@linaro.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
	gkurz@kaod.org, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 07:37:04PM +0200, Laurent Vivier wrote:
> On 26/04/2019 08:05, David Gibson wrote:
> > From: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
> > space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driv=
er
> > implements special regions for such GPUs and emulates an NVLink bridge.
> > NVLink2-enabled POWER9 CPUs also provide address translation services
> > which includes an ATS shootdown (ATSD) register exported via the NVLink
> > bridge device.
> >=20
> > This adds a quirk to VFIO to map the GPU memory and create an MR;
> > the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
> > this to get the MR and map it to the system address space.
> > Another quirk does the same for ATSD.
> >=20
> > This adds additional steps to sPAPR PHB setup:
> >=20
> > 1. Search for specific GPUs and NPUs, collect findings in
> > sPAPRPHBState::nvgpus, manage system address space mappings;
> >=20
> > 2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
> > "memory-block", "link-speed" to advertise the NVLink2 function to
> > the guest;
> >=20
> > 3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;
> >=20
> > 4. Add new memory blocks (with extra "linux,memory-usable" to prevent
> > the guest OS from accessing the new memory until it is onlined) and
> > npuphb# nodes representing an NPU unit for every vPHB as the GPU driver
> > uses it for link discovery.
> >=20
> > This allocates space for GPU RAM and ATSD like we do for MMIOs by
> > adding 2 new parameters to the phb_placement() hook. Older machine types
> > set these to zero.
> >=20
> > This puts new memory nodes in a separate NUMA node to as the GPU RAM
> > needs to be configured equally distant from any other node in the syste=
m.
> > Unlike the host setup which assigns numa ids from 255 downwards, this
> > adds new NUMA nodes after the user configures nodes or from 1 if none
> > were configured.
> >=20
> > This adds requirement similar to EEH - one IOMMU group per vPHB.
> > The reason for this is that ATSD registers belong to a physical NPU
> > so they cannot invalidate translations on GPUs attached to another NPU.
> > It is guaranteed by the host platform as it does not mix NVLink bridges
> > or GPUs from different NPU in the same IOMMU group. If more than one
> > IOMMU group is detected on a vPHB, this disables ATSD support for that
> > vPHB and prints a warning.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > [aw: for vfio portions]
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > Message-Id: <20190312082103.130561-1-aik@ozlabs.ru>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/Makefile.objs        |   2 +-
> >  hw/ppc/spapr.c              |  48 +++-
> >  hw/ppc/spapr_pci.c          |  19 ++
> >  hw/ppc/spapr_pci_nvlink2.c  | 450 ++++++++++++++++++++++++++++++++++++
> >  hw/vfio/pci-quirks.c        | 131 +++++++++++
> >  hw/vfio/pci.c               |  14 ++
> >  hw/vfio/pci.h               |   2 +
> >  hw/vfio/trace-events        |   4 +
> >  include/hw/pci-host/spapr.h |  45 ++++
> >  include/hw/ppc/spapr.h      |   5 +-
> >  10 files changed, 711 insertions(+), 9 deletions(-)
> >  create mode 100644 hw/ppc/spapr_pci_nvlink2.c
> >=20
> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index 1111b218a0..636e717f20 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> >  # IBM PowerNV
> >  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_=
psi.o pnv_occ.o pnv_bmc.o
> >  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> > -obj-y +=3D spapr_pci_vfio.o
> > +obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
> >  endif
> >  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
> >  # PowerPC 4xx boards
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index b52b82d298..b81e237635 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1034,12 +1034,13 @@ static void spapr_dt_rtas(SpaprMachineState *sp=
apr, void *fdt)
> >          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> >          cpu_to_be32(max_cpus / smp_threads),
> >      };
> > +    uint32_t maxdomain =3D cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
> >      uint32_t maxdomains[] =3D {
> >          cpu_to_be32(4),
> > -        cpu_to_be32(0),
> > -        cpu_to_be32(0),
> > -        cpu_to_be32(0),
> > -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1),
> > +        maxdomain,
> > +        maxdomain,
> > +        maxdomain,
> > +        cpu_to_be32(spapr->gpu_numa_id),
> >      };
> > =20
> >      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
> > @@ -1698,6 +1699,16 @@ static void spapr_machine_reset(void)
> >          spapr_irq_msi_reset(spapr);
> >      }
> > =20
> > +    /*
> > +     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
> > +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> > +     * called from vPHB reset handler so we initialize the counter her=
e.
> > +     * If no NUMA is configured from the QEMU side, we start from 1 as=
 GPU RAM
> > +     * must be equally distant from any other node.
> > +     * The final value of spapr->gpu_numa_id is going to be written to
> > +     * max-associativity-domains in spapr_build_fdt().
> > +     */
> > +    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> >      qemu_devices_reset();
> > =20
> >      /*
> > @@ -3907,7 +3918,9 @@ static void spapr_phb_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
> >      smc->phb_placement(spapr, sphb->index,
> >                         &sphb->buid, &sphb->io_win_addr,
> >                         &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > -                       windows_supported, sphb->dma_liobn, errp);
> > +                       windows_supported, sphb->dma_liobn,
> > +                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_ad=
dr,
> > +                       errp);
> >  }
> > =20
> >  static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
> > @@ -4108,7 +4121,8 @@ static const CPUArchIdList *spapr_possible_cpu_ar=
ch_ids(MachineState *machine)
> >  static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t ind=
ex,
> >                                  uint64_t *buid, hwaddr *pio,
> >                                  hwaddr *mmio32, hwaddr *mmio64,
> > -                                unsigned n_dma, uint32_t *liobns, Erro=
r **errp)
> > +                                unsigned n_dma, uint32_t *liobns,
> > +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error=
 **errp)
> >  {
> >      /*
> >       * New-style PHB window placement.
> > @@ -4153,6 +4167,9 @@ static void spapr_phb_placement(SpaprMachineState=
 *spapr, uint32_t index,
> >      *pio =3D SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
> >      *mmio32 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZ=
E;
> >      *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZ=
E;
> > +
> > +    *nv2gpa =3D SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM=
64_WIN_SIZE;
> > +    *nv2atsd =3D SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATS=
D_WIN_SIZE;
> >  }
> > =20
> >  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
> > @@ -4357,6 +4374,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> >  /*
> >   * pseries-3.1
> >   */
> > +static void phb_placement_3_1(SpaprMachineState *spapr, uint32_t index,
> > +                              uint64_t *buid, hwaddr *pio,
> > +                              hwaddr *mmio32, hwaddr *mmio64,
> > +                              unsigned n_dma, uint32_t *liobns,
> > +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error *=
*errp)
> > +{
> > +    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma=
, liobns,
> > +                        nv2gpa, nv2atsd, errp);
> > +    *nv2gpa =3D 0;
> > +    *nv2atsd =3D 0;
> > +}
> > +
> >  static void spapr_machine_3_1_class_options(MachineClass *mc)
> >  {
> >      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > @@ -4372,6 +4401,7 @@ static void spapr_machine_3_1_class_options(Machi=
neClass *mc)
> >      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_=
OFF;
> > +    smc->phb_placement =3D phb_placement_3_1;
>=20
> I think this should be renamed and go into the 4.0 machine type as it
> has already been released.

Drat, good point.  The patch is already merged, but I'm writing a
followup to correct this.  We haven't released since the wrong one was
merged, so that should be ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlziQ9EACgkQbDjKyiDZ
s5LOKBAA2F3cevTzCdPQsjfRcPyMScVHvBfQ4iwLMESE2qg64+NbkuQC48UdcHW1
aLWu7P3y96VQwMEtvLuQzCohs6+5qmvW/3Fvk5gL/DedQk/cQxbiBKNpNgz0O8QT
KzCxw/VQU4USB0s1eCt+C2uFMNjGb9DNc1RdFD456qyT9+mnaEclk+RmFenL/zsb
st8v6POJPJsbgZYM01BXa8oTZVp+wyuVGhOeCVG3aVBTRRl+8CnqVfJy8EuLqsLf
BA9SqUZvy7ubX3Z0fDJJdEhgUtoLoKrl7sKotsUhP3NrjzAi3XZMbF5nxfuJeJKO
dndYQ9/uzRplBl/Apn/U3vDqfn0Z51XG59mnZ8AwfOALfNw0tCfffF4PRZMZGWRK
L05RSiNINebON7y0krbsPffqLXzg7aZw4e5e9DcNN8+oXE7IdbUk3ipvliy39Ilc
Qm0goxZgG88Kk9LZg4wWIba6OQw2ukMW6qr8LPDDGUeH6FDQD2l96bdAaiAFHIY1
0wY+Bh+Gzj5Deh2quOShWFGaVWAJtwgy2SlNU/nviH+KqLoKOgxzAo4CDEg2d3R0
N+ABXfMlckvoSUaayb6UzohgM15NEyxRn7hXOPu4BNEKxNO9q3IZtRHFJnHSy4E+
OtSDWdcSQmXHeycN4jNlf5aBX+yFW5reFpi+fr6a3Izlh+8hi0E=
=YsWt
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

