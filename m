Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC91C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F8221743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F8221743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnh4T-0004p5-QZ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnh4J-0004QK-EF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnh4H-0008Ly-Se
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:21:51 -0400
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:60134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnh4H-0008KU-LK
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:21:49 -0400
Received: from player797.ha.ovh.net (unknown [10.108.57.50])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7569B1D7DB1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 12:21:46 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id AEAA2820C4D6;
 Wed, 17 Jul 2019 10:21:42 +0000 (UTC)
Date: Wed, 17 Jul 2019 12:21:41 +0200
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190717122141.53d6bd53@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190717070637.101776-1-aik@ozlabs.ru>
References: <20190717070637.101776-1-aik@ozlabs.ru>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17778522483056876021
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.139.208
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu v2] spapr_pci: Advertise
 BAR reallocation capability
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 17:06:36 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The pseries guests do not normally allocate PCI resources and rely on
> the system firmware doing so. Furthermore at least at some point in
> the past the pseries guests won't even allowed to change BARs, probably
> it is still the case for phyp. So since the initial commit we have [1]
> which prevents resource reallocation.
> 
> This is not a problem until we want specific BAR alignments, for example,
> PAGE_SIZE==64k to make sure we can still map MMIO BARs directly. For
> the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
> does not allocate BARs, the guest does this instead and does not align
> BARs even if Linux is given pci=resource_alignment=16@pci:0:0 as
> PCI_PROBE_ONLY makes Linux ignore alignment requests.
> 
> ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [3].
> This makes use of the dial to advertise to the guest that we can handle
> BAR reassignments. This limits the change to the latest pseries machine
> to avoid old guests explosion.
> 
> We do not remove the flag from [1] as pseries guests are still supported
> under phyp so having that removed may cause problems.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/pseries/setup.c?h=v5.1#n773
> [2] https://git.qemu.org/?p=SLOF.git;a=blob;f=board-qemu/slof/pci-phb.fs;h=06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=HEAD#l338
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f81c11af
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * limited the change by a machine version
> 
> ---
>  include/hw/ppc/spapr.h |  1 +
>  hw/ppc/spapr.c         | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 60553d32c4fa..11c8185b94a1 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -120,6 +120,7 @@ struct SpaprMachineClass {
>      bool legacy_irq_allocation;
>      bool broken_host_serial_model; /* present real host info to the guest */
>      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> +    bool linux_pci_probe;
>  
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio, 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8783b433960c..734d759d65b3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1162,6 +1162,7 @@ static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void *fdt,
>  static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *machine = MACHINE(spapr);
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
>      int chosen;
>      const char *boot_device = machine->boot_order;
>      char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
> @@ -1219,6 +1220,11 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path));
>      }
>  
> +    /* We can deal with BAR reallocation just fine, advertise it to the guest */
> +    if (smc->linux_pci_probe) {
> +        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
> +    }
> +
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>  
>      g_free(stdout_path);
> @@ -4432,6 +4438,9 @@ static const TypeInfo spapr_machine_info = {
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
>      /* Defaults for the latest behaviour inherited from the base class */
> +    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
> +    smc->linux_pci_probe = true;

As written in the comment, defaults for the latest behavior belong to the
base class, ie. this should go to spapr_machine_class_init().

>  }
>  
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
> @@ -4441,12 +4450,14 @@ DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
>   */
>  static void spapr_machine_4_1_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>      static GlobalProperty compat[] = {
>          /* Only allow 4kiB and 64kiB IOMMU pagesizes */
>          { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
>      };
>  
>      spapr_machine_4_2_class_options(mc);
> +    smc->linux_pci_probe = false;
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  


