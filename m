Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B428EC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A422133F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A422133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQ59-0007O3-Pp
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hfPyt-00023M-Gt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hfPyr-0006Ri-R4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:30:03 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:37087)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hfPyq-00067s-Kq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:30:01 -0400
Received: from player693.ha.ovh.net (unknown [10.108.42.239])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 10ABA135F80
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 16:29:47 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id 40FB57286277;
 Mon, 24 Jun 2019 14:29:37 +0000 (UTC)
Date: Mon, 24 Jun 2019 16:29:35 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190624162935.02d08837@bahia.lan>
In-Reply-To: <156033129836.26635.3348706829139659071.stgit@aravinda>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16022400103085676948
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.250.45
Subject: Re: [Qemu-devel] [PATCH v10 6/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Jun 2019 14:51:38 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> This patch adds support in QEMU to handle "ibm,nmi-register"
> and "ibm,nmi-interlock" RTAS calls and sets the default
> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
> type 4.0.
> 

Next machine type is 4.1.

> The machine check notification address is saved when the
> OS issues "ibm,nmi-register" RTAS call.
> 
> This patch also handles the case when multiple processors
> experience machine check at or about the same time by
> handling "ibm,nmi-interlock" call. In such cases, as per
> PAPR, subsequent processors serialize waiting for the first
> processor to issue the "ibm,nmi-interlock" call. The second
> processor that also received a machine check error waits
> till the first processor is done reading the error log.
> The first processor issues "ibm,nmi-interlock" call
> when the error log is consumed.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    6 ++++-
>  hw/ppc/spapr_rtas.c    |   63 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |    5 +++-
>  3 files changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3d6d139..213d493 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *machine)
>          /* Create the error string for live migration blocker */
>          error_setg(&spapr->fwnmi_migration_blocker,
>                  "Live migration not supported during machine check handling");
> +
> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
> +        spapr_fwnmi_register();

IIRC this was supposed to depend on SPAPR_CAP_FWNMI_MCE being ON.

>      }
>  
>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;

This should have been put into spapr_machine_4_0_class_options().

But unless you manage to get this merged before soft-freeze (2019-07-02),
I'm afraid this will be a 4.2 feature.

>  }
>  
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index a015a80..e010cb2 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -49,6 +49,7 @@
>  #include "hw/ppc/fdt.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
> +#include "migration/blocker.h"
>  
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                                     uint32_t token, uint32_t nargs,
> @@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      rtas_st(rets, 1, 100);
>  }
>  
> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> +                                  SpaprMachineState *spapr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args,
> +                                  uint32_t nret, target_ulong rets)
> +{
> +    int ret;
> +    hwaddr rtas_addr = spapr_get_rtas_addr();
> +
> +    if (!rtas_addr) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    ret = kvmppc_fwnmi_enable(cpu);
> +    if (ret == 1) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    } else if (ret < 0) {
> +        error_report("Couldn't enable KVM FWNMI capability");
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +
> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    if (spapr->guest_machine_check_addr == -1) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    } else {
> +        /*
> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +         * hence unset mc_status.
> +         */
> +        spapr->mc_status = -1;
> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    }
> +}
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -496,6 +551,14 @@ hwaddr spapr_get_rtas_addr(void)
>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>  }
>  
> +void spapr_fwnmi_register(void)
> +{
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
> +}
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 0dedf0a..7ae53e2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -637,8 +637,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
>  
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
>  
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> @@ -894,4 +896,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>  
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +void spapr_fwnmi_register(void);
>  #endif /* HW_SPAPR_H */
> 


