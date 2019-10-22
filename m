Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3242CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95A82084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95A82084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxOn-0008H8-LU
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iMwzW-0003PO-Fj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iMwzV-0000NO-1u
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:26:38 -0400
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:36286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iMwzU-0000KY-P7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:26:36 -0400
Received: from player691.ha.ovh.net (unknown [10.108.42.145])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7C9CE1E486A
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 18:26:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 02300B5DA191;
 Tue, 22 Oct 2019 16:26:27 +0000 (UTC)
Date: Tue, 22 Oct 2019 18:26:26 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 5/7] ppc: Reset the interrupt presenter from the CPU
 reset handler
Message-ID: <20191022182626.7204a3b2@bahia.lan>
In-Reply-To: <20191022134632.29098-6-clg@kaod.org>
References: <20191022134632.29098-1-clg@kaod.org>
 <20191022134632.29098-6-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3294946078789769611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.54.31
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 15:46:30 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On the sPAPR machine and PowerNV machine, the interrupt presenters are
> created by a machine handler at the core level and are reset
> independently. This is not consistent and it raises issues when it
> comes to handle hot-plugged CPUs. In that case, the presenters are not
> reset. This is less of an issue in XICS, although a zero MFFR could
> be a concern, but in XIVE, the OS CAM line is not set and this breaks
> the presenting algorithm. The current code has workarounds which need
> a global cleanup.
>=20
> Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
> cpu_intc_reset() handler called by the CPU reset handler and remove
> the XiveTCTX reset handler which is now redundant.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Just one nit caused by the changes from patch 3.

>  [...]
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index cc17bbfed829..127107ab7c63 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -40,10 +40,11 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
>      return cpu_type;
>  }
> =20
> -static void pnv_core_cpu_reset(PowerPCCPU *cpu)
> +static void pnv_core_cpu_reset(PowerPCCPU *cpu, PnvChip *chip)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> +    PnvChipClass *pcc;
> =20
>      cpu_reset(cs);
> =20
> @@ -54,6 +55,9 @@ static void pnv_core_cpu_reset(PowerPCCPU *cpu)
>      env->gpr[3] =3D PNV_FDT_ADDR;
>      env->nip =3D 0x10;
>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
> +
> +    pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    pcc->intc_reset(PNV_CHIP(chip), cpu);

chip is already of type PnvChip *, no need to cast.

>  }
> =20
>  /*
> @@ -200,7 +204,7 @@ static void pnv_core_reset(void *dev)
>      int i;
> =20
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        pnv_core_cpu_reset(pc->threads[i]);
> +        pnv_core_cpu_reset(pc->threads[i], pc->chip);
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2e34832d0ea2..ef7b27a66d56 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -32,6 +32,7 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);<
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>      target_ulong lpcr;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>      cpu_reset(cs);
> =20
> @@ -76,9 +77,11 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>      spapr_cpu->dtl_addr =3D 0;
>      spapr_cpu->dtl_size =3D 0;
> =20
> -    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
> +    spapr_caps_cpu_apply(spapr, cpu);
> =20
>      kvm_check_mmu(cpu, &error_fatal);
> +
> +    spapr_irq_cpu_intc_reset(spapr, cpu);
>  }
> =20
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 234d1073e518..b941608b69ba 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -220,6 +220,20 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *spa=
pr,
>      return 0;
>  }
> =20
> +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu)
> +{
> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> +        SpaprInterruptController *intc =3D intcs[i];
> +        if (intc) {
> +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
> +            sicc->cpu_intc_reset(intc, cpu);
> +        }
> +    }
> +}
> +
>  static void spapr_set_irq(void *opaque, int irq, int level)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);


