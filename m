Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB12C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B7220740
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7220740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH94Z-000280-Ud
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jH93v-0001LP-U8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jH93u-0006SW-KU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:39:27 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:47582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jH93u-0006R9-FM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:39:26 -0400
Received: from player759.ha.ovh.net (unknown [10.110.115.113])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id CEBDD96611
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:39:23 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 8330210CF0F24;
 Wed, 25 Mar 2020 16:39:15 +0000 (UTC)
Subject: Re: [EXTERNAL] [PATCH 5/5] ppc/pnv: Implement mce injection
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2724f082-dcfe-1d64-cd8c-43f45d2313db@kaod.org>
Date: Wed, 25 Mar 2020 17:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325144147.221875-6-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9888497410972945316
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.171
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:41 PM, Nicholas Piggin wrote:
> This implements mce injection for pnv.

This would be the command to use ? 

(qemu) mce 0 0x100000 0x80 0xdeadbeef 1

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/pnv.c             | 55 ++++++++++++++++++++++++++++++++++++++++
>  target/ppc/cpu.h         |  1 +
>  target/ppc/excp_helper.c | 12 +++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 671535ebe6..9c515bfeed 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -38,6 +38,7 @@
>  #include "hw/nmi.h"
>  #include "exec/address-spaces.h"
>  #include "qapi/visitor.h"
> +#include "qapi/qmp/qdict.h"
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
>  #include "hw/ipmi/ipmi.h"
> @@ -1981,11 +1982,63 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
>      }
>  }
> 
> +typedef struct MCEInjectionParams {
> +    uint64_t srr1_mask;
> +    uint32_t dsisr;
> +    uint64_t dar;
> +    bool recovered;
> +} MCEInjectionParams;
> +
> +static void pnv_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
> +{
> +    MCEInjectionParams *params = data.host_ptr;
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    uint64_t srr1_mce_bits = PPC_BITMASK(42, 45) | PPC_BIT(36);
> +
> +    cpu_synchronize_state(cs);

I think this call is superfluous as we don't support any accelerators 
on this machine (but we might one day).
 
> +    ppc_cpu_do_machine_check(cs);
> +
> +    env->spr[SPR_SRR1] |= (params->srr1_mask & srr1_mce_bits);

Don't  we need to clear the previous settings like on spapr ? 

> +    if (params->dsisr) {
> +        env->spr[SPR_DSISR] = params->dsisr;
> +        env->spr[SPR_DAR] = params->dar;
> +    }
> +
> +    if (!params->recovered) {
> +        env->msr &= ~MSR_RI;
> +    }
> +}
> +
> +static void pnv_mce(MCEState *m, const QDict *qdict, Error **errp)
> +{
> +    int cpu_index = qdict_get_int(qdict, "cpu_index");
> +    uint64_t srr1_mask = qdict_get_int(qdict, "srr1_mask");
> +    uint32_t dsisr = qdict_get_int(qdict, "dsisr");
> +    uint64_t dar = qdict_get_int(qdict, "dar");
> +    bool recovered = qdict_get_int(qdict, "recovered");
> +    CPUState *cs;
> +
> +    cs = qemu_get_cpu(cpu_index);
> +
> +    if (cs != NULL) {
> +        MCEInjectionParams params = {
> +            .srr1_mask = srr1_mask,
> +            .dsisr = dsisr,
> +            .dar = dar,
> +            .recovered = recovered,
> +        };
> +
> +        run_on_cpu(cs, pnv_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&params));
> +    }
> +}
> +
>  static void pnv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
>      InterruptStatsProviderClass *ispc = INTERRUPT_STATS_PROVIDER_CLASS(oc);
>      NMIClass *nc = NMI_CLASS(oc);
> +    MCEClass *mcec = MCE_CLASS(oc);
> 
>      mc->desc = "IBM PowerNV (Non-Virtualized)";
>      mc->init = pnv_init;
> @@ -2003,6 +2056,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_id = "pnv.ram";
>      ispc->print_info = pnv_pic_print_info;
>      nc->nmi_monitor_handler = pnv_nmi;
> +    mcec->mce_monitor_handler = pnv_mce;
> 
>      object_class_property_add_bool(oc, "hb-mode",
>                                     pnv_machine_get_hb, pnv_machine_set_hb,
> @@ -2067,6 +2121,7 @@ static const TypeInfo types[] = {
>          .interfaces = (InterfaceInfo[]) {
>              { TYPE_INTERRUPT_STATS_PROVIDER },
>              { TYPE_NMI },
> +            { TYPE_MCE },
>          },
>      },
>      {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f4a5304d43..9be27f59c5 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1221,6 +1221,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
>  void ppc_cpu_do_system_reset(CPUState *cs);
> +void ppc_cpu_do_machine_check(CPUState *cs);
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
>  extern const VMStateDescription vmstate_ppc_cpu;
>  #endif
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 7f2b5899d3..81dd8b6f8e 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -279,6 +279,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>              cs->halted = 1;
>              cpu_interrupt_exittb(cs);
>          }
> +        if (msr_pow) {
> +            /* indicate that we resumed from power save mode */
> +            msr |= 0x10000;

#define ? 

> +        }
>          if (env->msr_mask & MSR_HVB) {
>              /*
>               * ISA specifies HV, but can be delivered to guest with HV
> @@ -969,6 +973,14 @@ void ppc_cpu_do_system_reset(CPUState *cs)
>      powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
>  }
> 
> +void ppc_cpu_do_machine_check(CPUState *cs)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +
> +    powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_MCHECK);
> +}
> +
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
> 


