Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325BAC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FED206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FED206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuu9-0001nU-6c
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jDuGu-0003oi-NF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jDuGt-0002t3-9C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:15:28 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:56835)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jDuGs-0002dT-W0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:15:27 -0400
Received: from player687.ha.ovh.net (unknown [10.108.42.239])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B24691CDFBE
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 19:15:24 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 13EB21070DDFC;
 Mon, 16 Mar 2020 18:15:17 +0000 (UTC)
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take
 an alternate vector
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-7-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <85cfff63-88e3-b5a5-75e3-aa29ac13ff60@kaod.org>
Date: Mon, 16 Mar 2020 19:15:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316142613.121089-7-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13996061746096409574
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.182
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> Provide for an alternate delivery location, -1 defaults to the
> architected address.

I don't know what is the best approach, to override the vector addr
computed by powerpc_excp() or use a machine class handler with 
cpu->vhyp.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr.c           | 2 +-
>  target/ppc/cpu.h         | 2 +-
>  target/ppc/excp_helper.c | 5 ++++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5f93c49706..25221d843c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3400,7 +3400,7 @@ static void spapr_machine_finalizefn(Object *obj)
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
>  {
>      cpu_synchronize_state(cs);
> -    ppc_cpu_do_system_reset(cs);
> +    ppc_cpu_do_system_reset(cs, -1);
>  }
>  
>  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3953680534..f8c7d6f19c 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
> -void ppc_cpu_do_system_reset(CPUState *cs);
> +void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
>  extern const VMStateDescription vmstate_ppc_cpu;
>  #endif
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 7f2b5899d3..08bc885ca6 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -961,12 +961,15 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>      }
>  }
>  
> -void ppc_cpu_do_system_reset(CPUState *cs)
> +void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      CPUPPCState *env = &cpu->env;
>  
>      powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
> +    if (vector != -1) {
> +        env->nip = vector;
> +    }
>  }
>  
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
> 


