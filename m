Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BEC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72A220848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72A220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgoD-0007H9-R2
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:38:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hRgnK-0006uU-WC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hRgnJ-0005Bd-Ee
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hRgnJ-00053z-6Q; Fri, 17 May 2019 13:37:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20017772DD;
	Fri, 17 May 2019 17:37:12 +0000 (UTC)
Received: from [10.40.205.57] (unknown [10.40.205.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C146B60BE0;
	Fri, 17 May 2019 17:37:05 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
	<20190426060627.18153-2-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <2187f170-8a8b-356d-78e0-fb010443df3b@redhat.com>
Date: Fri, 17 May 2019 19:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426060627.18153-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 17 May 2019 17:37:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, gkurz@kaod.org, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/04/2019 08:05, David Gibson wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
> space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driver
> implements special regions for such GPUs and emulates an NVLink bridge.
> NVLink2-enabled POWER9 CPUs also provide address translation services
> which includes an ATS shootdown (ATSD) register exported via the NVLink
> bridge device.
> 
> This adds a quirk to VFIO to map the GPU memory and create an MR;
> the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
> this to get the MR and map it to the system address space.
> Another quirk does the same for ATSD.
> 
> This adds additional steps to sPAPR PHB setup:
> 
> 1. Search for specific GPUs and NPUs, collect findings in
> sPAPRPHBState::nvgpus, manage system address space mappings;
> 
> 2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
> "memory-block", "link-speed" to advertise the NVLink2 function to
> the guest;
> 
> 3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;
> 
> 4. Add new memory blocks (with extra "linux,memory-usable" to prevent
> the guest OS from accessing the new memory until it is onlined) and
> npuphb# nodes representing an NPU unit for every vPHB as the GPU driver
> uses it for link discovery.
> 
> This allocates space for GPU RAM and ATSD like we do for MMIOs by
> adding 2 new parameters to the phb_placement() hook. Older machine types
> set these to zero.
> 
> This puts new memory nodes in a separate NUMA node to as the GPU RAM
> needs to be configured equally distant from any other node in the system.
> Unlike the host setup which assigns numa ids from 255 downwards, this
> adds new NUMA nodes after the user configures nodes or from 1 if none
> were configured.
> 
> This adds requirement similar to EEH - one IOMMU group per vPHB.
> The reason for this is that ATSD registers belong to a physical NPU
> so they cannot invalidate translations on GPUs attached to another NPU.
> It is guaranteed by the host platform as it does not mix NVLink bridges
> or GPUs from different NPU in the same IOMMU group. If more than one
> IOMMU group is detected on a vPHB, this disables ATSD support for that
> vPHB and prints a warning.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for vfio portions]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Message-Id: <20190312082103.130561-1-aik@ozlabs.ru>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/Makefile.objs        |   2 +-
>  hw/ppc/spapr.c              |  48 +++-
>  hw/ppc/spapr_pci.c          |  19 ++
>  hw/ppc/spapr_pci_nvlink2.c  | 450 ++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci-quirks.c        | 131 +++++++++++
>  hw/vfio/pci.c               |  14 ++
>  hw/vfio/pci.h               |   2 +
>  hw/vfio/trace-events        |   4 +
>  include/hw/pci-host/spapr.h |  45 ++++
>  include/hw/ppc/spapr.h      |   5 +-
>  10 files changed, 711 insertions(+), 9 deletions(-)
>  create mode 100644 hw/ppc/spapr_pci_nvlink2.c
> 
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 1111b218a0..636e717f20 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> -obj-y += spapr_pci_vfio.o
> +obj-y += spapr_pci_vfio.o spapr_pci_nvlink2.o
>  endif
>  obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
>  # PowerPC 4xx boards
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b52b82d298..b81e237635 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1034,12 +1034,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
>          cpu_to_be32(max_cpus / smp_threads),
>      };
> +    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
>      uint32_t maxdomains[] = {
>          cpu_to_be32(4),
> -        cpu_to_be32(0),
> -        cpu_to_be32(0),
> -        cpu_to_be32(0),
> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1),
> +        maxdomain,
> +        maxdomain,
> +        maxdomain,
> +        cpu_to_be32(spapr->gpu_numa_id),
>      };
>  
>      _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
> @@ -1698,6 +1699,16 @@ static void spapr_machine_reset(void)
>          spapr_irq_msi_reset(spapr);
>      }
>  
> +    /*
> +     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
> +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
> +     * called from vPHB reset handler so we initialize the counter here.
> +     * If no NUMA is configured from the QEMU side, we start from 1 as GPU RAM
> +     * must be equally distant from any other node.
> +     * The final value of spapr->gpu_numa_id is going to be written to
> +     * max-associativity-domains in spapr_build_fdt().
> +     */
> +    spapr->gpu_numa_id = MAX(1, nb_numa_nodes);
>      qemu_devices_reset();
>  
>      /*
> @@ -3907,7 +3918,9 @@ static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      smc->phb_placement(spapr, sphb->index,
>                         &sphb->buid, &sphb->io_win_addr,
>                         &sphb->mem_win_addr, &sphb->mem64_win_addr,
> -                       windows_supported, sphb->dma_liobn, errp);
> +                       windows_supported, sphb->dma_liobn,
> +                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_addr,
> +                       errp);
>  }
>  
>  static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> @@ -4108,7 +4121,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
>  static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
>                                  uint64_t *buid, hwaddr *pio,
>                                  hwaddr *mmio32, hwaddr *mmio64,
> -                                unsigned n_dma, uint32_t *liobns, Error **errp)
> +                                unsigned n_dma, uint32_t *liobns,
> +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
>  {
>      /*
>       * New-style PHB window placement.
> @@ -4153,6 +4167,9 @@ static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
>      *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
>      *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
>      *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
> +
> +    *nv2gpa = SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64_WIN_SIZE;
> +    *nv2atsd = SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_WIN_SIZE;
>  }
>  
>  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
> @@ -4357,6 +4374,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>  /*
>   * pseries-3.1
>   */
> +static void phb_placement_3_1(SpaprMachineState *spapr, uint32_t index,
> +                              uint64_t *buid, hwaddr *pio,
> +                              hwaddr *mmio32, hwaddr *mmio64,
> +                              unsigned n_dma, uint32_t *liobns,
> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
> +{
> +    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma, liobns,
> +                        nv2gpa, nv2atsd, errp);
> +    *nv2gpa = 0;
> +    *nv2atsd = 0;
> +}
> +
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
>      SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> @@ -4372,6 +4401,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
> +    smc->phb_placement = phb_placement_3_1;

I think this should be renamed and go into the 4.0 machine type as it
has already been released.

Thanks,
Laurent

