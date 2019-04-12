Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C64FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 04:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26592082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 04:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26592082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEnqx-00028f-Qz
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 00:31:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEnpx-0001l6-9c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEnpw-0001pe-6X
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:30:49 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:51826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEnpv-0001n6-Sc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 00:30:48 -0400
Received: from player786.ha.ovh.net (unknown [10.109.160.39])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7CACFEEB4E
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 06:30:45 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player786.ha.ovh.net (Postfix) with ESMTPSA id 7243F4C8542F;
	Fri, 12 Apr 2019 04:30:37 +0000 (UTC)
To: Nicholas Piggin <npiggin@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
References: <20190411063408.3998-1-clg@kaod.org>
	<1555039552.i5y8oxfv9m.astroid@bobo.none>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f8492fdf-bccf-2852-accd-7ee5b18dc28f@kaod.org>
Date: Fri, 12 Apr 2019 06:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555039552.i5y8oxfv9m.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Ovh-Tracer-Id: 1474084454500830035
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrvddtgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.149
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: Add H_PROD and H_CONFER
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412043036.qoKlp2oveD8DKS3kU5sRU2A2BMuiBNmnnnMW6S5RIbI@z>

On 4/12/19 5:28 AM, Nicholas Piggin wrote:
> C=C3=A9dric Le Goater's on April 11, 2019 4:34 pm:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> H_PROD should be fully functional, H_CEDE is modified to
>> ignore a proded CPU. H_CONFER is a stub to avoid returning
>> an error.
>=20
> Huh, I just implemented these a couple of days ago to test pseries
> suspend, also H_JOIN.

Cool. Can you send your version instead ?

Thanks,

C.

>=20
> ---
>  hw/ppc/spapr_hcall.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8a736797b9..47ee933333 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1065,6 +1065,81 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (env->msr & (1ULL << MSR_EE))
> +        return H_BAD_MODE;
> +
> +    /*
> +     * This should check for single-threaded mode. In practice, Linux
> +     * does not try to H_JOIN all CPUs.
> +     */
> +
> +    cs->halted =3D 1;
> +    cs->exception_index =3D EXCP_HALTED;
> +    cs->exit_request =3D 1;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs =3D CPU(cpu);
> +
> +    /*
> +     * This does not do a targeted yield, but check the parameter anyw=
ay.
> +     */
> +    if (target !=3D -1 && !CPU(spapr_find_cpu(target)))
> +        return H_PARAMETER;
> +
> +    /*
> +     * H_CONFER with target =3D=3D this is not exactly the same as H_J=
OIN
> +     * according to PAPR (e.g., MSR[EE] check and single threaded chec=
k
> +     * is not done in this case), but unlikely to matter.
> +     */
> +    if (cpu =3D=3D spapr_find_cpu(target))
> +        return h_join(cpu, spapr, opcode, args);
> +
> +    /*
> +     * This does not implement the dispatch sequence check.
> +     */
> +    cs->exception_index =3D EXCP_YIELD;
> +    cpu_loop_exit(cs);
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * H_PROD and H_CONFER are specified to only modify GPR r3, which is n=
ot
> + * achievable running under KVM, although KVM already implements H_CON=
FER
> + * this way.
> + */
> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                           target_ulong opcode, target_ulong *args)
> +{
> +    target_long target =3D args[0];
> +    CPUState *cs;
> +
> +    /*
> +     * Should set the prod flag in the VPA.
> +     */
> +
> +    cs =3D CPU(spapr_find_cpu(target));
> +    if (!cs)
> +        return H_PARAMETER;
> +
> +    cs->halted =3D 0;
> +    qemu_cpu_kick(cs);
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                             target_ulong opcode, target_ulong *args)
>  {
> @@ -1860,6 +1935,10 @@ static void hypercall_register_types(void)
>      /* hcall-splpar */
>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>      spapr_register_hypercall(H_CEDE, h_cede);
> +    spapr_register_hypercall(H_CONFER, h_confer);
> +    spapr_register_hypercall(H_JOIN, h_join);
> +    spapr_register_hypercall(H_PROD, h_prod);
> +
>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
> =20
>      /* processor register resource access h-calls */
>=20


