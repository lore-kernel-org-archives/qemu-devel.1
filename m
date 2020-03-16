Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1811CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D615A20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615A20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuv4-0003Dq-W5
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jDtvS-0007RI-Vq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jDtvL-0001kD-0f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:53:15 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:50605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jDtvK-0001TQ-OV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:53:10 -0400
Received: from player731.ha.ovh.net (unknown [10.110.208.183])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 580E8127A70
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 18:53:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 0F6131048987D;
 Mon, 16 Mar 2020 17:52:55 +0000 (UTC)
Date: Mon, 16 Mar 2020 18:52:54 +0100
From: Greg Kurz <groug@kaod.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 7/8] ppc/spapr: Implement FWNMI System Reset delivery
Message-ID: <20200316185254.1aca6e20@bahia.lan>
In-Reply-To: <20200316173500.576hdvush3fzvvef@in.ibm.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-8-npiggin@gmail.com>
 <20200316173500.576hdvush3fzvvef@in.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13620011176660343204
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.98
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
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 23:05:00 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 2020-03-17 00:26:12 Tue, Nicholas Piggin wrote:
> > PAPR requires that if "ibm,nmi-register" succeeds, then the hypervisor
> > delivers all system reset and machine check exceptions to the registered
> > addresses.
> > 
> > System Resets are delivered with registers set to the architected state,
> > and with no interlock.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 44 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 25221d843c..78e649f47d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -967,7 +967,29 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> >      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> >                       maxdomains, sizeof(maxdomains)));
> > 
> > -    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
> > +    /*
> > +     * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log,
> > +     * and 16 bytes per CPU for system reset error log plus an extra 8 bytes.
> > +     *
> > +     * The system reset requirements are driven by existing Linux and PowerVM
> > +     * implementation which (contrary to PAPR) saves r3 in the error log
> > +     * structure like machine check, so Linux expects to find the saved r3
> > +     * value at the address in r3 upon FWNMI-enabled sreset interrupt (and
> > +     * does not look at the error value).
> > +     *
> > +     * System reset interrupts are not subject to interlock like machine
> > +     * check, so this memory area could be corrupted if the sreset is
> > +     * interrupted by a machine check (or vice versa) if it was shared. To
> > +     * prevent this, system reset uses per-CPU areas for the sreset save
> > +     * area. A system reset that interrupts a system reset handler could
> > +     * still overwrite this area, but Linux doesn't try to recover in that
> > +     * case anyway.
> > +     *
> > +     * The extra 8 bytes is required because Linux's FWNMI error log check
> > +     * is off-by-one.
> > +     */
> > +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_ERROR_LOG_MAX +
> > +			  ms->smp.max_cpus * sizeof(uint64_t)*2 + sizeof(uint64_t)));
> 
> Currently the rtas region is only of size 2048 (i.e RTAS_ERROR_LOG_MAX).
> Do we need SLOF change to increase rtas area as well ? Otherwise QEMU
> may corrupt guest memory area OR Am I wrong ?
> 

A change is pending for SLOF to use the "rtas-size" property
provided by QEMU:

https://patchwork.ozlabs.org/patch/1255264/

> Thanks,
> -Mahesh/
> 
> >      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
> >                            RTAS_ERROR_LOG_MAX));
> >      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
> > @@ -3399,8 +3421,28 @@ static void spapr_machine_finalizefn(Object *obj)
> > 
> >  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
> >  {
> > +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> > +
> >      cpu_synchronize_state(cs);
> > -    ppc_cpu_do_system_reset(cs, -1);
> > +    /* If FWNMI is inactive, addr will be -1, which will deliver to 0x100 */
> > +    if (spapr->fwnmi_system_reset_addr != -1) {
> > +        uint64_t rtas_addr, addr;
> > +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> > +        CPUPPCState *env = &cpu->env;
> > +
> > +        /* get rtas addr from fdt */
> > +        rtas_addr = spapr_get_rtas_addr();
> > +        if (!rtas_addr) {
> > +            qemu_system_guest_panicked(NULL);
> > +            return;
> > +        }
> > +
> > +        addr = rtas_addr + RTAS_ERROR_LOG_MAX + cs->cpu_index * sizeof(uint64_t)*2;
> > +        stq_be_phys(&address_space_memory, addr, env->gpr[3]);
> > +        stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
> > +        env->gpr[3] = addr;
> > +    }
> > +    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
> >  }
> > 
> >  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
> > -- 
> > 2.23.0
> > 
> > 
> 


