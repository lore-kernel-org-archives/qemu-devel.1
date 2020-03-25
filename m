Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E22C54FD3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C2820409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C2820409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8hG-0000qa-FL
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jH8gL-0000EU-6l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jH8gJ-0001Iw-Rm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:15:04 -0400
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:42656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jH8gJ-0001Au-LZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:15:03 -0400
Received: from player726.ha.ovh.net (unknown [10.108.42.145])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2A9991579D3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:14:54 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 9F5A010B4D17A;
 Wed, 25 Mar 2020 16:14:46 +0000 (UTC)
Subject: Re: [EXTERNAL] [PATCH 1/5] ppc/spapr: tweak change system reset helper
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dd019924-a007-d69b-cbf7-ee2e1ccebfc5@kaod.org>
Date: Wed, 25 Mar 2020 17:14:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325144147.221875-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9475010669408127908
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.45.51
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:41 PM, Nicholas Piggin wrote:
> Rather than have the helper take an optional vector address
> override, instead have its caller modify env->nip itself.
> This is more consistent when adding pnv nmi support, and also
> with mce injection added later.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/ppc/spapr.c           | 9 ++++++---
>  target/ppc/cpu.h         | 2 +-
>  target/ppc/excp_helper.c | 5 +----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9a2bd501aa..785c41d205 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3385,13 +3385,13 @@ static void spapr_machine_finalizefn(Object *ob=
j)
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
>=20
>      cpu_synchronize_state(cs);
>      /* If FWNMI is inactive, addr will be -1, which will deliver to 0x=
100 */
>      if (spapr->fwnmi_system_reset_addr !=3D -1) {
>          uint64_t rtas_addr, addr;
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        CPUPPCState *env =3D &cpu->env;
>=20
>          /* get rtas addr from fdt */
>          rtas_addr =3D spapr_get_rtas_addr();
> @@ -3405,7 +3405,10 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, =
run_on_cpu_data arg)
>          stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0)=
;
>          env->gpr[3] =3D addr;
>      }
> -    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
> +    ppc_cpu_do_system_reset(cs);
> +    if (spapr->fwnmi_system_reset_addr !=3D -1) {
> +        env->nip =3D spapr->fwnmi_system_reset_addr;
> +    }
>  }
>=20
>  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 88d9449555..f4a5304d43 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunct=
ion f, CPUState *cs,
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
> -void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
> +void ppc_cpu_do_system_reset(CPUState *cs);
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)=
;
>  extern const VMStateDescription vmstate_ppc_cpu;
>  #endif
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 08bc885ca6..7f2b5899d3 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -961,15 +961,12 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>      }
>  }
>=20
> -void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
> +void ppc_cpu_do_system_reset(CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
>=20
>      powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
> -    if (vector !=3D -1) {
> -        env->nip =3D vector;
> -    }
>  }
>=20
>  void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
>=20


