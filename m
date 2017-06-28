Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dQBVB-00081B-22
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dQBV7-0003wR-TB
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:51:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60055
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dQBV7-0003vC-M3
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:51:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5SBn1GQ113436
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 07:51:16 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bc24471ep-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 07:51:16 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 12:51:14 +0100
References: <20170623144823.42936-1-pasic@linux.vnet.ibm.com>
	<87shik5ou5.fsf@secure.mitica>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 13:51:10 +0200
MIME-Version: 1.0
In-Reply-To: <87shik5ou5.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5c360d07-ea8a-88e3-2297-d570042364cc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] vmstate: error hint for failed equal
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>



On 06/28/2017 01:33 PM, Juan Quintela wrote:
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>> In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug,
>> but it's actually the best we can do. Especially in these cases a verbose
>> error message is required.
>>
>> Let's introduce infrastructure for specifying a error hint to be used if
>> equal check fails. Let's do this by adding a parameter to the _EQUAL
>> macros called _err_hint. Also change all current users to pass NULL as
>> last parameter so nothing changes for them.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> Hi
> 
> I have had to add this to your patch to make it compile.
> 
> Later, Juan.
> 

Oops. Seems I have gone by compiler and missed out some targets.
Sorry for that! Many thanks!

Halil

> 
> From 74573a4190af8a357054493d5451e2b51c553498 Mon Sep 17 00:00:00 2001
> From: Juan Quintela <quintela@redhat.com>
> Date: Wed, 28 Jun 2017 10:19:25 +0200
> Subject: [PATCH] fix missing Macro applications
> 
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/block/fdc.c          | 2 +-
>  hw/display/qxl.c        | 4 ++--
>  hw/display/vga.c        | 2 +-
>  hw/display/vmware_vga.c | 2 +-
>  hw/ide/ahci.c           | 2 +-
>  hw/input/vmmouse.c      | 2 +-
>  hw/intc/openpic.c       | 2 +-
>  hw/intc/xics.c          | 2 +-
>  hw/misc/max111x.c       | 2 +-
>  hw/ppc/spapr_iommu.c    | 2 +-
>  hw/ppc/spapr_pci.c      | 4 ++--
>  hw/ppc/spapr_vio.c      | 4 ++--
>  hw/usb/hcd-uhci.c       | 2 +-
>  target/ppc/machine.c    | 8 ++++----
>  14 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 28f6b6e..4011290 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1217,7 +1217,7 @@ static const VMStateDescription vmstate_fdc = {
>          VMSTATE_UINT8(config, FDCtrl),
>          VMSTATE_UINT8(lock, FDCtrl),
>          VMSTATE_UINT8(pwrd, FDCtrl),
> -        VMSTATE_UINT8_EQUAL(num_floppies, FDCtrl),
> +        VMSTATE_UINT8_EQUAL(num_floppies, FDCtrl, NULL),
>          VMSTATE_STRUCT_ARRAY(drives, FDCtrl, MAX_FD, 1,
>                               vmstate_fdrive, FDrive),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index ad09bb9..3c1688e 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2373,12 +2373,12 @@ static VMStateDescription qxl_vmstate = {
>          VMSTATE_UINT32(last_release_offset, PCIQXLDevice),
>          VMSTATE_UINT32(mode, PCIQXLDevice),
>          VMSTATE_UINT32(ssd.unique, PCIQXLDevice),
> -        VMSTATE_INT32_EQUAL(num_memslots, PCIQXLDevice),
> +        VMSTATE_INT32_EQUAL(num_memslots, PCIQXLDevice, NULL),
>          VMSTATE_STRUCT_ARRAY(guest_slots, PCIQXLDevice, NUM_MEMSLOTS, 0,
>                               qxl_memslot, struct guest_slots),
>          VMSTATE_STRUCT(guest_primary.surface, PCIQXLDevice, 0,
>                         qxl_surface, QXLSurfaceCreate),
> -        VMSTATE_INT32_EQUAL(ssd.num_surfaces, PCIQXLDevice),
> +        VMSTATE_INT32_EQUAL(ssd.num_surfaces, PCIQXLDevice, NULL),
>          VMSTATE_VARRAY_INT32(guest_surfaces.cmds, PCIQXLDevice,
>                               ssd.num_surfaces, 0,
>                               vmstate_info_uint64, uint64_t),
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index dcc95f8..80508b8 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2099,7 +2099,7 @@ const VMStateDescription vmstate_vga_common = {
>          VMSTATE_BUFFER(palette, VGACommonState),
> 
>          VMSTATE_INT32(bank_offset, VGACommonState),
> -        VMSTATE_UINT8_EQUAL(is_vbe_vmstate, VGACommonState),
> +        VMSTATE_UINT8_EQUAL(is_vbe_vmstate, VGACommonState, NULL),
>          VMSTATE_UINT16(vbe_index, VGACommonState),
>          VMSTATE_UINT16_ARRAY(vbe_regs, VGACommonState, VBE_DISPI_INDEX_NB),
>          VMSTATE_UINT32(vbe_start_addr, VGACommonState),
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index ec5f27d..c989cef 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -1192,7 +1192,7 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
>      .minimum_version_id = 0,
>      .post_load = vmsvga_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s),
> +        VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s, NULL),
>          VMSTATE_INT32(enable, struct vmsvga_state_s),
>          VMSTATE_INT32(config, struct vmsvga_state_s),
>          VMSTATE_INT32(cursor.id, struct vmsvga_state_s),
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index f60826d..874d3fe 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1669,7 +1669,7 @@ const VMStateDescription vmstate_ahci = {
>          VMSTATE_UINT32(control_regs.impl, AHCIState),
>          VMSTATE_UINT32(control_regs.version, AHCIState),
>          VMSTATE_UINT32(idp_index, AHCIState),
> -        VMSTATE_INT32_EQUAL(ports, AHCIState),
> +        VMSTATE_INT32_EQUAL(ports, AHCIState, NULL),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/hw/input/vmmouse.c b/hw/input/vmmouse.c
> index 4747da9..b6d2208 100644
> --- a/hw/input/vmmouse.c
> +++ b/hw/input/vmmouse.c
> @@ -243,7 +243,7 @@ static const VMStateDescription vmstate_vmmouse = {
>      .minimum_version_id = 0,
>      .post_load = vmmouse_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(queue_size, VMMouseState),
> +        VMSTATE_INT32_EQUAL(queue_size, VMMouseState, NULL),
>          VMSTATE_UINT32_ARRAY(queue, VMMouseState, VMMOUSE_QUEUE_SIZE),
>          VMSTATE_UINT16(nb_queue, VMMouseState),
>          VMSTATE_UINT16(status, VMMouseState),
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index f966d06..5595bb2 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1499,7 +1499,7 @@ static const VMStateDescription vmstate_openpic = {
>          VMSTATE_UINT32(max_irq, OpenPICState),
>          VMSTATE_STRUCT_VARRAY_UINT32(src, OpenPICState, max_irq, 0,
>                                       vmstate_openpic_irqsource, IRQSource),
> -        VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState),
> +        VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState, NULL),
>          VMSTATE_STRUCT_VARRAY_UINT32(dst, OpenPICState, nb_cpus, 0,
>                                       vmstate_openpic_irqdest, IRQDest),
>          VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 0,
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 7ccfb53..d4194d6 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -574,7 +574,7 @@ static const VMStateDescription vmstate_ics_simple = {
>      .post_load = ics_simple_dispatch_post_load,
>      .fields = (VMStateField[]) {
>          /* Sanity check */
> -        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState),
> +        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> 
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
>                                               vmstate_ics_simple_irq,
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index 2a277bd..6dbdc03 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -116,7 +116,7 @@ static const VMStateDescription vmstate_max111x = {
>          VMSTATE_UINT8(tb1, MAX111xState),
>          VMSTATE_UINT8(rb2, MAX111xState),
>          VMSTATE_UINT8(rb3, MAX111xState),
> -        VMSTATE_INT32_EQUAL(inputs, MAX111xState),
> +        VMSTATE_INT32_EQUAL(inputs, MAX111xState, NULL),
>          VMSTATE_INT32(com, MAX111xState),
>          VMSTATE_ARRAY_INT32_UNSAFE(input, MAX111xState, inputs,
>                                     vmstate_info_uint8, uint8_t),
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 0341bc0..8656a54 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -231,7 +231,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
>      .post_load = spapr_tce_table_post_load,
>      .fields      = (VMStateField []) {
>          /* Sanity check */
> -        VMSTATE_UINT32_EQUAL(liobn, sPAPRTCETable),
> +        VMSTATE_UINT32_EQUAL(liobn, sPAPRTCETable, NULL),
> 
>          /* IOMMU state */
>          VMSTATE_UINT32(mig_nb_table, sPAPRTCETable),
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0b447f2..3b37dcd 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1848,7 +1848,7 @@ static const VMStateDescription vmstate_spapr_pci_lsi = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi),
> +        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
> 
>          VMSTATE_END_OF_LIST()
>      },
> @@ -1936,7 +1936,7 @@ static const VMStateDescription vmstate_spapr_pci = {
>      .pre_save = spapr_pci_pre_save,
>      .post_load = spapr_pci_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT64_EQUAL(buid, sPAPRPHBState),
> +        VMSTATE_UINT64_EQUAL(buid, sPAPRPHBState, NULL),
>          VMSTATE_UINT32_TEST(mig_liobn, sPAPRPHBState, pre_2_8_migration),
>          VMSTATE_UINT64_TEST(mig_mem_win_addr, sPAPRPHBState, pre_2_8_migration),
>          VMSTATE_UINT64_TEST(mig_mem_win_size, sPAPRPHBState, pre_2_8_migration),
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index a0ee4fd..ea3bc8b 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -557,8 +557,8 @@ const VMStateDescription vmstate_spapr_vio = {
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
>          /* Sanity check */
> -        VMSTATE_UINT32_EQUAL(reg, VIOsPAPRDevice),
> -        VMSTATE_UINT32_EQUAL(irq, VIOsPAPRDevice),
> +        VMSTATE_UINT32_EQUAL(reg, VIOsPAPRDevice, NULL),
> +        VMSTATE_UINT32_EQUAL(irq, VIOsPAPRDevice, NULL),
> 
>          /* General VIO device state */
>          VMSTATE_UINT64(signal_state, VIOsPAPRDevice),
> diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
> index ca72a80..e3562a4 100644
> --- a/hw/usb/hcd-uhci.c
> +++ b/hw/usb/hcd-uhci.c
> @@ -415,7 +415,7 @@ static const VMStateDescription vmstate_uhci = {
>      .post_load = uhci_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(dev, UHCIState),
> -        VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState),
> +        VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState, NULL),
>          VMSTATE_STRUCT_ARRAY(ports, UHCIState, NB_PORTS, 1,
>                               vmstate_uhci_port, UHCIPort),
>          VMSTATE_UINT16(cmd, UHCIState),
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 6cb3a48..445f489 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -419,7 +419,7 @@ static const VMStateDescription vmstate_slb = {
>      .needed = slb_needed,
>      .post_load = slb_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(env.slb_nr, PowerPCCPU),
> +        VMSTATE_INT32_EQUAL(env.slb_nr, PowerPCCPU, NULL),
>          VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -452,7 +452,7 @@ static const VMStateDescription vmstate_tlb6xx = {
>      .minimum_version_id = 1,
>      .needed = tlb6xx_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
> +        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
>          VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlb6, PowerPCCPU,
>                                              env.nb_tlb,
>                                              vmstate_tlb6xx_entry,
> @@ -510,7 +510,7 @@ static const VMStateDescription vmstate_tlbemb = {
>      .minimum_version_id = 1,
>      .needed = tlbemb_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
> +        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
>          VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbe, PowerPCCPU,
>                                              env.nb_tlb,
>                                              vmstate_tlbemb_entry,
> @@ -551,7 +551,7 @@ static const VMStateDescription vmstate_tlbmas = {
>      .minimum_version_id = 1,
>      .needed = tlbmas_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
> +        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
>          VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbm, PowerPCCPU,
>                                              env.nb_tlb,
>                                              vmstate_tlbmas_entry,
> 
