Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F4C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2A1208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2A1208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopgM-0000by-Vg
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iop8t-0001Si-0L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iop8r-00042I-Co
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:43:30 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:54995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iop8r-00040v-2j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:43:29 -0500
Received: from player786.ha.ovh.net (unknown [10.108.16.204])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id B89408B567
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 14:43:26 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 5BFF8E18BE24;
 Tue,  7 Jan 2020 13:43:16 +0000 (UTC)
Subject: Re: [PATCH v2 08/10] target/ppc: Streamline calculation of RMA limit
 from LPCR[RMLS]
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a5f22049-2c99-043e-53a9-93c8947f0b02@kaod.org>
Date: Tue, 7 Jan 2020 14:43:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10015442621942696742
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepghhnuhdrohhrghenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.53
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
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-ppc@nongnu.org, lvivier@redhat.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 5:48 AM, David Gibson wrote:
> Currently we use a big switch statement in ppc_hash64_update_rmls() to =
work
> out what the right RMA limit is based on the LPCR[RMLS] field.  There's=
 no
> formula for this - it's just an arbitrary mapping defined by the existi=
ng
> CPU implementations - but we can make it a bit more readable by using a
> lookup table rather than a switch.  In addition we can use the MiB/GiB
> symbols to make it a bit clearer.
>=20
> While there we add a bit of clarity and rationale to the comment about
> what happens if the LPCR[RMLS] doesn't contain a valid value.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  target/ppc/mmu-hash64.c | 71 ++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 127b7250ae..bb9ebeaf48 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -18,6 +18,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> @@ -755,6 +756,39 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwad=
dr ptex, uint64_t pte1)
>      stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
>  }
> =20
> +static target_ulong rmls_limit(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    /*
> +     * This is the full 4 bits encoding of POWER8. Previous
> +     * CPUs only support a subset of these but the filtering
> +     * is done when writing LPCR
> +     */
> +    const target_ulong rma_sizes[] =3D {
> +        [0] =3D 0,
> +        [1] =3D 16 * GiB,
> +        [2] =3D 1 * GiB,
> +        [3] =3D 64 * MiB,
> +        [4] =3D 256 * MiB,
> +        [5] =3D 0,
> +        [6] =3D 0,
> +        [7] =3D 128 * MiB,
> +        [8] =3D 32 * MiB,
> +    };
> +    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_RML=
S_SHIFT;
> +
> +    if (rmls < ARRAY_SIZE(rma_sizes)) {
> +        return rma_sizes[rmls];
> +    } else {
> +        /*
> +         * Bad value, so the OS has shot itself in the foot.  Return a
> +         * 0-sized RMA which we expect to trigger an immediate DSI or
> +         * ISI
> +         */
> +        return 0;
> +    }
> +}
> +
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                  int rwx, int mmu_idx)
>  {
> @@ -1004,41 +1038,6 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, =
target_ulong ptex,
>      cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL=
_FLUSH;
>  }
> =20
> -static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    uint64_t lpcr =3D env->spr[SPR_LPCR];
> -
> -    /*
> -     * This is the full 4 bits encoding of POWER8. Previous
> -     * CPUs only support a subset of these but the filtering
> -     * is done when writing LPCR
> -     */
> -    switch ((lpcr & LPCR_RMLS) >> LPCR_RMLS_SHIFT) {
> -    case 0x8: /* 32MB */
> -        env->rmls =3D 0x2000000ull;
> -        break;
> -    case 0x3: /* 64MB */
> -        env->rmls =3D 0x4000000ull;
> -        break;
> -    case 0x7: /* 128MB */
> -        env->rmls =3D 0x8000000ull;
> -        break;
> -    case 0x4: /* 256MB */
> -        env->rmls =3D 0x10000000ull;
> -        break;
> -    case 0x2: /* 1GB */
> -        env->rmls =3D 0x40000000ull;
> -        break;
> -    case 0x1: /* 16GB */
> -        env->rmls =3D 0x400000000ull;
> -        break;
> -    default:
> -        /* What to do here ??? */
> -        env->rmls =3D 0;
> -    }
> -}
> -
>  static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
> @@ -1097,7 +1096,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong=
 val)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    ppc_hash64_update_rmls(cpu);
> +    env->rmls =3D rmls_limit(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
> =20
>=20


