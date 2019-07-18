Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE228C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921A821783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921A821783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3wm-00032I-C2
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1ho3wT-00026Y-F0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ho3wS-0006y6-2w
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:47:17 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:44793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ho3wR-0006wj-QR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:47:15 -0400
Received: from player734.ha.ovh.net (unknown [10.108.35.90])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8E9D713B606
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 12:47:13 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id EC6C68034494;
 Thu, 18 Jul 2019 10:47:06 +0000 (UTC)
Date: Thu, 18 Jul 2019 12:47:05 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190718124705.2d18dc52@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190718034214.14948-3-npiggin@gmail.com>
References: <20190718034214.14948-1-npiggin@gmail.com>
 <20190718034214.14948-3-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5634284611086490051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.94
Subject: Re: [Qemu-devel] [PATCH v6 2/4] spapr: Implement H_PROD
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

On Thu, 18 Jul 2019 13:42:12 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> H_PROD is added, and H_CEDE is modified to test the prod bit
> according to PAPR.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> Changes since v5:
> - Add the prod bit here
> - Fix target CPU
> 
>  hw/ppc/spapr.c                  |  1 +
>  hw/ppc/spapr_hcall.c            | 32 ++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_cpu_core.h |  1 +
>  3 files changed, 34 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3e5678d467..68341c128d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4309,6 +4309,7 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
>  
>      /* These are only called by TCG, KVM maintains dispatch state */
>  
> +    spapr_cpu->prod = false;
>      if (spapr_cpu->vpa_addr) {
>          CPUState *cs = CPU(cpu);
>          uint32_t dispatch;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index e615881ac4..098b3dda22 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1050,14 +1050,44 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>  {
>      CPUPPCState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
>  
>      env->msr |= (1ULL << MSR_EE);
>      hreg_compute_hflags(env);
> +
> +    if (spapr_cpu->prod) {
> +        spapr_cpu->prod = false;
> +        return H_SUCCESS;
> +    }
> +
>      if (!cpu_has_work(cs)) {
>          cs->halted = 1;
>          cs->exception_index = EXCP_HLT;
>          cs->exit_request = 1;
>      }
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target = args[0];
> +    PowerPCCPU *tcpu;
> +    CPUState *cs;
> +    SpaprCpuState *spapr_cpu;
> +
> +    tcpu = spapr_find_cpu(target);
> +    cs = CPU(tcpu);
> +    if (!cs) {
> +        return H_PARAMETER;
> +    }
> +
> +    spapr_cpu = spapr_cpu_state(tcpu);
> +    spapr_cpu->prod = true;
> +    cs->halted = 0;
> +    qemu_cpu_kick(cs);
> +
>      return H_SUCCESS;
>  }
>  
> @@ -1882,6 +1912,8 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_PROD, h_prod);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
>  
>      /* processor register resource access h-calls */
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index f9645a7290..a40cd08ea0 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -46,6 +46,7 @@ typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
>      uint64_t slb_shadow_addr, slb_shadow_size;
>      uint64_t dtl_addr, dtl_size;
> +    bool prod; /* not migrated, only used to improve dispatch latencies */
>      struct ICPState *icp;
>      struct XiveTCTX *tctx;
>  } SpaprCpuState;


