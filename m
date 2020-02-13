Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638BC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B029217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B029217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2A4W-0004Ob-ED
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 03:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j2A3t-0003oE-NO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j2A3s-0008Tn-CO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:41:29 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:40788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j2A3s-0008SI-7X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:41:28 -0500
Received: from player687.ha.ovh.net (unknown [10.108.57.50])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id D9BE2123152
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:41:25 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 6ACDAF4621C1;
 Thu, 13 Feb 2020 08:41:19 +0000 (UTC)
Date: Thu, 13 Feb 2020 09:41:16 +0100
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v6 2/6] ppc/spapr: Move GPRs setup to one place
Message-ID: <20200213094116.50a862b8@bahia.lan>
In-Reply-To: <20200203032943.121178-3-aik@ozlabs.ru>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-3-aik@ozlabs.ru>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 843580509350566389
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.238
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Feb 2020 14:29:39 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment "pseries" starts in SLOF which only expects the FDT blob
> pointer in r3. As we are going to introduce a OpenFirmware support in
> QEMU, we will be booting OF clients directly and these expect a stack
> pointer in r1, the OF entry point in r5 and in addition to this, Linux
> looks at r3/r4 for the initramdisk location (although vmlinux can find
> this from the device tree but zImage from distro kernels cannot).
> 
> This extends spapr_cpu_set_entry_state() to take more registers. This
> should cause no behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_cpu_core.h | 4 +++-
>  hw/ppc/spapr.c                  | 4 ++--
>  hw/ppc/spapr_cpu_core.c         | 7 ++++++-
>  hw/ppc/spapr_rtas.c             | 2 +-
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 1c4cc6559c52..edd7214fafcf 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
>  } SpaprCpuCoreClass;
>  
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
> -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> +                               target_ulong r1, target_ulong r3,
> +                               target_ulong r4, target_ulong r5);
>  
>  typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c9b2e0a5e060..660a4b60e072 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1674,8 +1674,8 @@ static void spapr_machine_reset(MachineState *machine)
>      spapr->fdt_blob = fdt;
>  
>      /* Set up the entry state */
> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
> -    first_ppc_cpu->env.gpr[5] = 0;
> +    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
> +                              0, fdt_addr, 0, 0);
>  
>      spapr->cas_reboot = false;
>  
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d09125d9afd4..696b76598dd7 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -84,13 +84,18 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>      spapr_irq_cpu_intc_reset(spapr, cpu);
>  }
>  
> -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> +                               target_ulong r1, target_ulong r3,
> +                               target_ulong r4, target_ulong r5)
>  {
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
>  
>      env->nip = nip;
> +    env->gpr[1] = r1;
>      env->gpr[3] = r3;
> +    env->gpr[4] = r4;
> +    env->gpr[5] = r5;
>      kvmppc_set_reg_ppc_online(cpu, 1);
>      CPU(cpu)->halted = 0;
>      /* Enable Power-saving mode Exit Cause exceptions */
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 656fdd221665..9e3cbd70bbd9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
>       */
>      newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
>  
> -    spapr_cpu_set_entry_state(newcpu, start, r3);
> +    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0, 0);
>  
>      qemu_cpu_kick(CPU(newcpu));
>  


