Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E49CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBFA214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBFA214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqs0-0004aP-4t
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iMqrF-0003se-Ju
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iMqrE-0005Hp-3j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:53:41 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:48139)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iMqrD-0005Ea-Ts
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:53:40 -0400
Received: from player771.ha.ovh.net (unknown [10.108.57.140])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id E737A22C366
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 11:53:30 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 55DB7B40B250;
 Tue, 22 Oct 2019 09:53:26 +0000 (UTC)
Date: Tue, 22 Oct 2019 11:53:18 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 1/4] spapr: move CPU reset after presenter creation
Message-ID: <20191022115318.41ceab36@bahia.lan>
In-Reply-To: <20191022072246.9200-2-clg@kaod.org>
References: <20191022072246.9200-1-clg@kaod.org>
 <20191022072246.9200-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15103384300517366155
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.44.175
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 09:22:43 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> spapr_realize_vcpu() is modified to call the CPU reset only after the
> the intc presenter has been created.
>=20

Maybe indicate why this change is needed ?

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_cpu_core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3e4302c7d596..992f00da6540 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -234,13 +234,16 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>      cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>      kvmppc_set_papr(cpu);
> =20
> -    qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);
> -
>      if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
> -        goto error_unregister;
> +        goto error_intc_create;
>      }
> =20
> +    /*
> +     * FIXME: Hot-plugged CPUs are not reseted. Do it at realize.
> +     */
> +    qemu_register_reset(spapr_cpu_reset, cpu);
> +    spapr_cpu_reset(cpu);
> +
>      if (!sc->pre_3_0_migration) {
>          vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
>                           cpu->machine_data);
> @@ -248,8 +251,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
> =20
>      return;
> =20
> -error_unregister:
> -    qemu_unregister_reset(spapr_cpu_reset, cpu);
> +error_intc_create:
>      cpu_remove_sync(CPU(cpu));
>  error:
>      error_propagate(errp, local_err);


