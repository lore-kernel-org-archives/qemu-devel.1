Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35DAC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AA42173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AA42173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58163 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlNw-00019d-VN
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnlNl-0000Z8-D0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnlNk-0002Ud-Cp
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:58:13 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:52623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnlNk-0002TU-6B
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:58:12 -0400
Received: from player772.ha.ovh.net (unknown [10.108.35.197])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8039810F102
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 16:58:09 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 8D4828039468;
 Wed, 17 Jul 2019 14:58:04 +0000 (UTC)
Date: Wed, 17 Jul 2019 16:58:02 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190717165802.7798c2e8@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156335163818.82682.7196904841379833409.stgit@lep8c.aus.stglabs.ibm.com>
References: <156335150620.82682.9535735857478533420.stgit@lep8c.aus.stglabs.ibm.com>
 <156335163818.82682.7196904841379833409.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3999196471792933205
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.180
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 4/4] ppc: dont overwrite
 initialized idle_timer
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

On Wed, 17 Jul 2019 03:20:55 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> The check to see if the idle_timer is already initialized is
> missing. Every vcpu thread would call kvm_arch_init_vcpu()
> and overwrite the idle_timer resulting in a memory leak.
> Patch fixes that.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  target/ppc/kvm.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..498ca6d53b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -491,7 +491,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>  
> -    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> +    if (!idle_timer)
> +        idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
>  

This timer is a per-cpu thingy, but it is stored in a global :-\ which
means it is broken if there's more than one vcpu.

Also timer_new_*() aren't the preferred way to create timers as stated
in the header of timer_new_full():

/*
...
 * This is not the preferred interface unless you know you
 * are going to call timer_free. Use timer_init or timer_init_full instead.
...
*/

I think you'd rather add a QEMUTimer idle_timer field to PowerPCCPU and
call initialize it with timer_init() instead.

>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
> 
> 


