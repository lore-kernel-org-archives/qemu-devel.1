Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A348C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAD522BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAD522BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgX9-0007Ya-IV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hqgWy-00073M-5J
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hqgWx-0000DV-2c
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:23:48 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:50698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hqgWw-0000B9-Nq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:23:47 -0400
Received: from player750.ha.ovh.net (unknown [10.109.160.153])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id A426713CA53
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 18:23:44 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 2DE7C869014F;
 Thu, 25 Jul 2019 16:23:40 +0000 (UTC)
Date: Thu, 25 Jul 2019 18:23:39 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190725182339.14b81387@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156406920211.26945.15588948639720429804.stgit@lep8c.aus.stglabs.ibm.com>
References: <156406920211.26945.15588948639720429804.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15532915118913919317
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkedvgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.219
Subject: Re: [Qemu-devel] [PATCH] ppc: remove redundant capability check for
 unset irq
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 10:40:11 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> The KVM_CAP_PPC_UNSET_IRQ is part of kernel since v2.6.36.
> Kernels older than that are not supported anymore.
> So, remove the checks.
> 

Ok to drop the dead paths but we do need this cap to be present.

int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
{
    unsigned virq = level ? KVM_INTERRUPT_SET_LEVEL : KVM_INTERRUPT_UNSET;
...
}

Please add an error message and exit in kvm_arch_init() like you did for
SET_LEVEL.

> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  target/ppc/kvm.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5ab5e6c6a9..94a2ecb84f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -55,7 +55,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>      KVM_CAP_LAST_INFO
>  };
>  
> -static int cap_interrupt_unset;
>  static int cap_segstate;
>  static int cap_booke_sregs;
>  static int cap_ppc_smt;
> @@ -104,7 +103,6 @@ static int kvmppc_get_dec_bits(void);
>  
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> -    cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
>      cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>      cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
>      cap_ppc_smt_possible = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
> @@ -1309,7 +1307,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
>          return 0;
>      }
>  
> -    if (!kvm_enabled() || !cap_interrupt_unset) {
> +    if (!kvm_enabled()) {
>          return 0;
>      }
>  
> 

