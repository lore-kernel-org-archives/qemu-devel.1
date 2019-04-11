Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312CC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2CB2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2CB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEVdH-0001bd-Ub
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:04:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hEVc7-00015i-BP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hEVc5-0003ul-RW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:03:19 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:56955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hEVc5-0003rS-Fl
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:03:17 -0400
Received: from player794.ha.ovh.net (unknown [10.109.143.246])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id B176010D7B5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 11:03:08 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player794.ha.ovh.net (Postfix) with ESMTPSA id 47EC14A3B36B;
	Thu, 11 Apr 2019 09:03:02 +0000 (UTC)
Date: Thu, 11 Apr 2019 11:02:59 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190411110259.3257499b@bahia.lan>
In-Reply-To: <20190411063408.3998-1-clg@kaod.org>
References: <20190411063408.3998-1-clg@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 201536084191779211
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.173.157
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/spapr: Add H_PROD and
 H_CONFER
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Nicholas Piggin <npiggin@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411090259.nZwF625iJYJoZBSKXjAA5GdAZXOXWzAi39iOnsFGrBI@z>

On Thu, 11 Apr 2019 08:34:08 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> H_PROD should be fully functional, H_CEDE is modified to
> ignore a proded CPU. H_CONFER is a stub to avoid returning
> an error.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/cpu.h     |  3 +++
>  hw/ppc/spapr_hcall.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 42eadc4b7997..07cea7268c0c 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1141,6 +1141,9 @@ struct CPUPPCState {
>       * sreset), so flag this here.
>       */
>      bool resume_as_sreset;
> +
> +    /* Used by SPAPR for H_CEDE/H_PROD */
> +    bool prodded;
>  #endif
> =20
>      /* Those resources are used only during code translation */
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8a736797b9bf..be8044a92f2f 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1057,6 +1057,11 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
> =20
>      env->msr |=3D (1ULL << MSR_EE);
>      hreg_compute_hflags(env);
> +    if (env->prodded) {
> +        env->prodded =3D false;
> +        return H_SUCCESS;
> +    }
> +

The "H_CEDE is modified to ignore a proded CPU" sentence in the changelog
is slightly inaccurate since the "prod" bit is reset, as described in
LoPAPR v1.1 14.11.3.3 H_CEDE.

Appart from that LGTM.

Reviewed-by: Greg Kurz <groug@kaod.org>

>      if (!cpu_has_work(cs)) {
>          cs->halted =3D 1;
>          cs->exception_index =3D EXCP_HLT;
> @@ -1065,6 +1070,36 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static void spapr_do_wakeup_on_cpu(CPUState *cs, run_on_cpu_data data)
> +{
> +    cs->halted =3D 0;
> +    cs->exception_index =3D -1;
> +}
> +
> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_ulong target =3D args[0];
> +    CPUPPCState *env;
> +
> +    cpu =3D spapr_find_cpu(target);
> +    if (cpu) {
> +        env =3D &cpu->env;
> +        env->prodded =3D true;
> +        run_on_cpu(CPU(cpu), spapr_do_wakeup_on_cpu, RUN_ON_CPU_NULL);
> +    } else {
> +        return H_PARAMETER;
> +    }
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                             target_ulong opcode, target_ulong *args)
> +{
> +    /* Do nothing (supposed to confer timeslice). */
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1860,6 +1895,8 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_PROD, h_prod);
> +    spapr_register_hypercall(H_CONFER, h_confer);
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> =20
>      /* processor register resource access h-calls */


