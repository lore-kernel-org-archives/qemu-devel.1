Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8788AC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 17:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF3821848
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF3821848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnnJ3-0006Iu-Fq
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 13:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnnIq-0005oH-6D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnnIp-0001oz-2b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:01:16 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:40062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnnIo-0001k3-SW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:01:15 -0400
Received: from player739.ha.ovh.net (unknown [10.109.146.76])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 242F41865EA
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 19:01:05 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id A80008292245;
 Wed, 17 Jul 2019 17:00:59 +0000 (UTC)
Date: Wed, 17 Jul 2019 19:00:58 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190717190058.269862ea@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190717053952.13729-4-npiggin@gmail.com>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-4-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6075637374735260099
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.205
Subject: Re: [Qemu-devel] [PATCH v5 3/4] spapr: Implement H_CONFER
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

On Wed, 17 Jul 2019 15:39:51 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> This does not do directed yielding and is not quite as strict as PAPR
> specifies in terms of precise dispatch behaviour. This generally will
> mean suboptimal performance, rather than guest misbehaviour. Linux
> does not rely on exact dispatch behaviour.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

LGTM.

Reviewed-by: Greg Kurz <groug@kaod.org>

Just two minor comments, see below.

> Changes since v4:
> - Style, added justification comments, spelling.
> - Fixed trying to dereference spapr_cpu for a -1 target.
> 
>  hw/ppc/spapr_hcall.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8b208ab259..5e655172b2 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1069,6 +1069,73 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      return H_SUCCESS;
>  }
>  
> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target = args[0];
> +    uint32_t dispatch = args[1];
> +    CPUState *cs = CPU(cpu);
> +    SpaprCpuState *spapr_cpu;
> +
> +    /*
> +     * -1 means confer to all other CPUs without dispatch counter check,
> +     *  otherwise it's a targeted confer.
> +     */
> +    if (target != -1) {
> +        PowerPCCPU *target_cpu = spapr_find_cpu(target);
> +        CPUState *target_cs = CPU(target_cpu);
> +        unsigned int target_dispatch;

Maybe make it uint32_t to be consistent with dispatch above, and this
is the actual return type of ldl_be_phys() ?

> +
> +        if (!target_cs) {

This is the only user of target_cs, maybe drop it and use target_cpu
instead ?

> +            return H_PARAMETER;
> +        }
> +
> +        spapr_cpu = spapr_cpu_state(target_cpu);
> +
> +        /*
> +         * target == self is a special case, we wait until prodded, without
> +         * dispatch counter check.
> +         */
> +        if (cpu == target_cpu) {
> +            if (spapr_cpu->prod) {
> +                spapr_cpu->prod = false;
> +
> +                return H_SUCCESS;
> +            }
> +
> +            cs->halted = 1;
> +            cs->exception_index = EXCP_HALTED;
> +            cs->exit_request = 1;
> +
> +            return H_SUCCESS;
> +        }
> +
> +        if (!spapr_cpu->vpa_addr || ((dispatch & 1) == 0)) {
> +            return H_SUCCESS;
> +        }
> +
> +        target_dispatch = ldl_be_phys(cs->as,
> +                                  spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
> +        if (target_dispatch != dispatch) {
> +            return H_SUCCESS;
> +        }
> +
> +        /*
> +         * The targeted confer does not do anything special beyond yielding
> +         * the current vCPU, but even this should be better than nothing.
> +         * At least for single-threaded tcg, it gives the target a chance to
> +         * run before we run again. Multi-threaded tcg does not really do
> +         * anything with EXCP_YIELD yet.
> +         */
> +    }
> +
> +    cs->exception_index = EXCP_YIELD;
> +    cs->exit_request = 1;
> +    cpu_loop_exit(cs);
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1909,6 +1976,7 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_CONFER, h_confer);
>      spapr_register_hypercall(H_PROD, h_prod);
>  
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);


