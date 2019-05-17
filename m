Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD952C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E93A21773
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E93A21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51915 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRh9E-0000aG-N4
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:00:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRh7f-0008CL-HM
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRh7d-000425-Ud
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:58:23 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:42048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRh7d-00040P-Nq
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:58:21 -0400
Received: from player758.ha.ovh.net (unknown [10.108.57.178])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id C7AAB214A91
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 19:58:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player758.ha.ovh.net (Postfix) with ESMTPSA id 402675EC8071;
	Fri, 17 May 2019 17:58:09 +0000 (UTC)
Date: Fri, 17 May 2019 19:58:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190517195808.4312a040@bahia.lan>
In-Reply-To: <2187f170-8a8b-356d-78e0-fb010443df3b@redhat.com>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
	<20190426060627.18153-2-david@gibson.dropbear.id.au>
	<2187f170-8a8b-356d-78e0-fb010443df3b@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17742493683093444902
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.202
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
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 19:37:04 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 26/04/2019 08:05, David Gibson wrote:
> > From: Alexey Kardashevskiy <aik@ozlabs.ru>
> > 
> > NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
> > space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driver
> > implements special regions for such GPUs and emulates an NVLink bridge.
> > NVLink2-enabled POWER9 CPUs also provide address translation services
> > which includes an ATS shootdown (ATSD) register exported via the NVLink
> > bridge device.
> > 
> > This adds a quirk to VFIO to map the GPU memory and create an MR;
> > the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
> > this to get the MR and map it to the system address space.
> > Another quirk does the same for ATSD.
> > 
> > This adds additional steps to sPAPR PHB setup:
> > 
> > 1. Search for specific GPUs and NPUs, collect findings in
> > sPAPRPHBState::nvgpus, manage system address space mappings;
> > 
> > 2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
> > "memory-block", "link-speed" to advertise the NVLink2 function to
> > the guest;
> > 
> > 3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;
> > 
> > 4. Add new memory blocks (with extra "linux,memory-usable" to prevent
> > the guest OS from accessing the new memory until it is onlined) and
> > npuphb# nodes representing an NPU unit for every vPHB as the GPU driver
> > uses it for link discovery.
> > 
> > This allocates space for GPU RAM and ATSD like we do for MMIOs by
> > adding 2 new parameters to the phb_placement() hook. Older machine types
> > set these to zero.
> > 
> > This puts new memory nodes in a separate NUMA node to as the GPU RAM
> > needs to be configured equally distant from any other node in the system.
> > Unlike the host setup which assigns numa ids from 255 downwards, this
> > adds new NUMA nodes after the user configures nodes or from 1 if none
> > were configured.
> > 
> > This adds requirement similar to EEH - one IOMMU group per vPHB.
> > The reason for this is that ATSD registers belong to a physical NPU
> > so they cannot invalidate translations on GPUs attached to another NPU.
> > It is guaranteed by the host platform as it does not mix NVLink bridges
> > or GPUs from different NPU in the same IOMMU group. If more than one
> > IOMMU group is detected on a vPHB, this disables ATSD support for that
> > vPHB and prints a warning.
> > 
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
> > 
> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index 1111b218a0..636e717f20 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
> >  # IBM PowerNV
> >  obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
> >  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> > -obj-y += spapr_pci_vfio.o
> > +obj-y += spapr_pci_vfio.o spapr_pci_nvlink2.o
> >  endif
> >  obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
> >  # PowerPC 4xx boards
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index b52b82d298..b81e237635 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1034,12 +1034,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> >          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> >          cpu_to_be32(max_cpus / smp_threads),
> >      };
> > +    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
> >      uint32_t maxdomains[] = {
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
> >  
> >      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
> > @@ -1698,6 +1699,16 @@ static void spapr_machine_reset(void)
> >          spapr_irq_msi_reset(spapr);
> >      }
> >  
> > +    /*
> > +     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
> > +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
> > +     * called from vPHB reset handler so we initialize the counter here.
> > +     * If no NUMA is configured from the QEMU side, we start from 1 as GPU RAM
> > +     * must be equally distant from any other node.
> > +     * The final value of spapr->gpu_numa_id is going to be written to
> > +     * max-associativity-domains in spapr_build_fdt().
> > +     */
> > +    spapr->gpu_numa_id = MAX(1, nb_numa_nodes);
> >      qemu_devices_reset();
> >  
> >      /*
> > @@ -3907,7 +3918,9 @@ static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      smc->phb_placement(spapr, sphb->index,
> >                         &sphb->buid, &sphb->io_win_addr,
> >                         &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > -                       windows_supported, sphb->dma_liobn, errp);
> > +                       windows_supported, sphb->dma_liobn,
> > +                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_addr,
> > +                       errp);
> >  }
> >  
> >  static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > @@ -4108,7 +4121,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
> >  static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
> >                                  uint64_t *buid, hwaddr *pio,
> >                                  hwaddr *mmio32, hwaddr *mmio64,
> > -                                unsigned n_dma, uint32_t *liobns, Error **errp)
> > +                                unsigned n_dma, uint32_t *liobns,
> > +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
> >  {
> >      /*
> >       * New-style PHB window placement.
> > @@ -4153,6 +4167,9 @@ static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
> >      *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
> >      *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
> >      *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
> > +
> > +    *nv2gpa = SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64_WIN_SIZE;
> > +    *nv2atsd = SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_WIN_SIZE;
> >  }
> >  
> >  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
> > @@ -4357,6 +4374,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> >  /*
> >   * pseries-3.1
> >   */
> > +static void phb_placement_3_1(SpaprMachineState *spapr, uint32_t index,
> > +                              uint64_t *buid, hwaddr *pio,
> > +                              hwaddr *mmio32, hwaddr *mmio64,
> > +                              unsigned n_dma, uint32_t *liobns,
> > +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
> > +{
> > +    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma, liobns,
> > +                        nv2gpa, nv2atsd, errp);
> > +    *nv2gpa = 0;
> > +    *nv2atsd = 0;
> > +}
> > +
> >  static void spapr_machine_3_1_class_options(MachineClass *mc)
> >  {
> >      SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> > @@ -4372,6 +4401,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
> >      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
> > +    smc->phb_placement = phb_placement_3_1;  
> 
> I think this should be renamed and go into the 4.0 machine type as it
> has already been released.
> 

I agree. It looks like this patch was initially targeting 4.0, as it still
appears to be the default version (visible a couple of lines above), but
finally got merged after 4.0 was released...

> Thanks,
> Laurent


