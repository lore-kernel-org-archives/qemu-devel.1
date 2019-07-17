Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF95C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1562321743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1562321743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngzk-0007m2-Iu
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hngzY-0007Gt-5n
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hngzX-00065w-4d
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:16:56 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:59477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hngzW-00065C-Tc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:16:55 -0400
Received: from player695.ha.ovh.net (unknown [10.109.160.93])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id AE8791FDED6
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 12:16:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id B367B7EAC5A5;
 Wed, 17 Jul 2019 10:16:44 +0000 (UTC)
To: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dcb80cc9-b282-dd27-5e09-1f96751be689@kaod.org>
Date: Wed, 17 Jul 2019 12:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717053952.13729-3-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17695768838096980889
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.33.73
Subject: Re: [Qemu-devel] [PATCH v5 2/4] spapr: Implement H_PROD
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2019 07:39, Nicholas Piggin wrote:
> H_PROD is added, and H_CEDE is modified to test the prod bit
> according to PAPR.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index e615881ac4..8b208ab259 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1050,14 +1050,41 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
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
> +    CPUState *cs;
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);

shouldn't we grab the SpaprCpuState of 'target' instead ?  

> +    cs = CPU(spapr_find_cpu(target));
> +    if (!cs) {
> +        return H_PARAMETER;
> +    }
> +
> +    spapr_cpu->prod = true;
> +    cs->halted = 0;
> +    qemu_cpu_kick(cs);
> +
>      return H_SUCCESS;
>  }
>  
> @@ -1882,6 +1909,8 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_PROD, h_prod);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
>  
>      /* processor register resource access h-calls */
> 


