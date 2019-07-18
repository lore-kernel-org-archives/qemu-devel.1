Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F9AC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF79B21783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF79B21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3yf-0005u2-Nd
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1ho3yK-00057s-SE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ho3yG-0008L3-LN
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:49:11 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:60492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ho3yB-00088K-3q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:49:04 -0400
Received: from player788.ha.ovh.net (unknown [10.109.143.249])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 874E021FBF0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 12:48:58 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 8A4D6809C33B;
 Thu, 18 Jul 2019 10:48:51 +0000 (UTC)
Date: Thu, 18 Jul 2019 12:48:50 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190718124850.77af2f44@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190718034214.14948-5-npiggin@gmail.com>
References: <20190718034214.14948-1-npiggin@gmail.com>
 <20190718034214.14948-5-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5663839484174244291
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.46.10
Subject: Re: [Qemu-devel] [PATCH v6 4/4] spapr: Implement H_JOIN
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
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jul 2019 13:42:14 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> This has been useful to modify and test the Linux pseries suspend
> code but it requires modification to the guest to call it (due to
> being gated by other unimplemented features). It is not otherwise
> used by Linux yet, but work is slowly progressing there.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> Changes since v5:
> - Fix prod bit semantics.
> - Factor out the h_confer_self common code
> 
> Changes since v4:
> - Style
> 
>  hw/ppc/spapr.c       |  1 +
>  hw/ppc/spapr_hcall.c | 74 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 62 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 68341c128d..00f7735a31 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1066,6 +1066,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>      add_str(hypertas, "hcall-tce");
>      add_str(hypertas, "hcall-vio");
>      add_str(hypertas, "hcall-splpar");
> +    add_str(hypertas, "hcall-join");
>      add_str(hypertas, "hcall-bulk");
>      add_str(hypertas, "hcall-set-mode");
>      add_str(hypertas, "hcall-sprg0");
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 7c659dc75c..9b72ea8b68 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1069,6 +1069,62 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      return H_SUCCESS;
>  }
>  
> +/*
> + * Confer to self, aka join. Cede could use the same pattern as well, if
> + * EXCP_HLT can be changed to ECXP_HALTED.
> + */
> +static target_ulong h_confer_self(PowerPCCPU *cpu)
> +{
> +    CPUState *cs = CPU(cpu);
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    if (spapr_cpu->prod) {
> +        spapr_cpu->prod = false;
> +        return H_SUCCESS;
> +    }
> +    cs->halted = 1;
> +    cs->exception_index = EXCP_HALTED;
> +    cs->exit_request = 1;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    CPUPPCState *env = &cpu->env;
> +    CPUState *cs;
> +    bool last_unjoined = true;
> +
> +    if (env->msr & (1ULL << MSR_EE)) {
> +        return H_BAD_MODE;
> +    }
> +
> +    /*
> +     * Must not join the last CPU running. Interestingly, no such restriction
> +     * for H_CONFER-to-self, but that is probably not intended to be used
> +     * when H_JOIN is available.
> +     */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *c = POWERPC_CPU(cs);
> +        CPUPPCState *e = &c->env;
> +        if (c == cpu) {
> +            continue;
> +        }
> +
> +        /* Don't have a way to indicate joined, so use halted && MSR[EE]=0 */
> +        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
> +            last_unjoined = false;
> +            break;
> +        }
> +    }
> +    if (last_unjoined) {
> +        return H_CONTINUE;
> +    }
> +
> +    return h_confer_self(cpu);
> +}
> +
>  static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1089,26 +1145,15 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>              return H_PARAMETER;
>          }
>  
> -        spapr_cpu = spapr_cpu_state(target_cpu);
> -
>          /*
>           * target == self is a special case, we wait until prodded, without
>           * dispatch counter check.
>           */
>          if (cpu == target_cpu) {
> -            if (spapr_cpu->prod) {
> -                spapr_cpu->prod = false;
> -
> -                return H_SUCCESS;
> -            }
> -
> -            cs->halted = 1;
> -            cs->exception_index = EXCP_HALTED;
> -            cs->exit_request = 1;
> -
> -            return H_SUCCESS;
> +            return h_confer_self(cpu);
>          }
>  
> +        spapr_cpu = spapr_cpu_state(target_cpu);
>          if (!spapr_cpu->vpa_addr || ((dispatch & 1) == 0)) {
>              return H_SUCCESS;
>          }
> @@ -1981,6 +2026,9 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(H_CONFER, h_confer);
>      spapr_register_hypercall(H_PROD, h_prod);
>  
> +    /* hcall-join */
> +    spapr_register_hypercall(H_JOIN, h_join);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
>  
>      /* processor register resource access h-calls */


