Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC10C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDA621927
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDA621927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6whH-0003S5-C7
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6wgf-0002pW-JA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6wgd-0001el-VF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:25:17 -0500
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:58084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6wgd-0001cV-Q3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:25:15 -0500
Received: from player698.ha.ovh.net (unknown [10.110.103.112])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 500C326FF59
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:25:13 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id EDD93FC3A3F5;
 Wed, 26 Feb 2020 13:24:55 +0000 (UTC)
Date: Wed, 26 Feb 2020 14:24:53 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 11/18] target/ppc: Only calculate RMLS derived RMA
 limit on demand
Message-ID: <20200226142453.6d47fb6b@bahia.home>
In-Reply-To: <20200224233724.46415-12-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-12-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8194299522729351654
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.100
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:17 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> When the LPCR is written, we update the env->rmls field with the RMA limit
> it implies.  Simplify things by just calculating the value directly from
> the LPCR value when we need it.
>=20
> It's possible this is a little slower, but it's unlikely to be significan=
t,
> since this is only for real mode accesses in a translation configuration
> that's not used very often, and the whole thing is behind the qemu TLB
> anyway.  Therefore, keeping the number of state variables down and not
> having to worry about making sure it's always in sync seems the better
> option.
>=20

This patch also refactors the code of ppc_hash64_update_vrma(), which
is definitely an improvement, but seems a bit unrelated to the title...
I'd personally make it a separate patch but you decide of course :)

Also, a cosmetic remark. See below.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/cpu.h        |  1 -
>  target/ppc/mmu-hash64.c | 84 ++++++++++++++++++++---------------------
>  2 files changed, 40 insertions(+), 45 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8077fdb068..f9871b1233 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1046,7 +1046,6 @@ struct CPUPPCState {
>      uint64_t insns_flags2;
>  #if defined(TARGET_PPC64)
>      ppc_slb_t vrma_slb;
> -    target_ulong rmls;
>  #endif
> =20
>      int error_code;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index dd0df6fd01..ac21c14f68 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -791,6 +791,35 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
>      }
>  }
> =20
> +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> +    uint32_t vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> +    target_ulong vsid =3D SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_=
MASK);
> +    int i;
> +
> +    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> +        const PPCHash64SegmentPageSizes *sps =3D &cpu->hash64_opts->sps[=
i];
> +
> +        if (!sps->page_shift) {
> +            break;
> +        }
> +
> +        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps->slb_enc) {
> +            slb->esid =3D SLB_ESID_V;
> +            slb->vsid =3D vsid;
> +            slb->sps =3D sps;
> +            return 0;
> +        }
> +    }
> +
> +    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=3D0x"
> +                 TARGET_FMT_lx"\n", lpcr);
> +
> +    return -1;
> +}
> +
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                  int rwx, int mmu_idx)
>  {
> @@ -844,8 +873,10 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr,
> =20
>              goto skip_slb_search;
>          } else {
> +            target_ulong limit =3D rmls_limit(cpu);
> +
>              /* Emulated old-style RMO mode, bounds check against RMLS */
> -            if (raddr >=3D env->rmls) {
> +            if (raddr >=3D limit) {
>                  if (rwx =3D=3D 2) {
>                      ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                  } else {
> @@ -1007,8 +1038,9 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
>                  return -1;
>              }
>          } else {
> +            target_ulong limit =3D rmls_limit(cpu);

Maybe add an empty line like you did above for consistency and better
readability ?

Anyway, feel free to add:

Reviewed-by: Greg Kurz <groug@kaod.org>

>              /* Emulated old-style RMO mode, bounds check against RMLS */
> -            if (raddr >=3D env->rmls) {
> +            if (raddr >=3D limit) {
>                  return -1;
>              }
>              return raddr | env->spr[SPR_RMOR];
> @@ -1043,53 +1075,18 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, t=
arget_ulong ptex,
>  static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
> -    const PPCHash64SegmentPageSizes *sps =3D NULL;
> -    target_ulong esid, vsid, lpcr;
>      ppc_slb_t *slb =3D &env->vrma_slb;
> -    uint32_t vrmasd;
> -    int i;
> -
> -    /* First clear it */
> -    slb->esid =3D slb->vsid =3D 0;
> -    slb->sps =3D NULL;
> =20
>      /* Is VRMA enabled ? */
> -    if (!ppc_hash64_use_vrma(env)) {
> -        return;
> -    }
> -
> -    /*
> -     * Make one up. Mostly ignore the ESID which will not be needed
> -     * for translation
> -     */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    vsid =3D SLB_VSID_VRMA;
> -    vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> -    vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
> -    esid =3D SLB_ESID_V;
> -
> -    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        const PPCHash64SegmentPageSizes *sps1 =3D &cpu->hash64_opts->sps=
[i];
> -
> -        if (!sps1->page_shift) {
> -            break;
> +    if (ppc_hash64_use_vrma(env)) {
> +        if (build_vrma_slbe(cpu, slb) =3D=3D 0) {
> +            return;
>          }
> -
> -        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps1->slb_enc) {
> -            sps =3D sps1;
> -            break;
> -        }
> -    }
> -
> -    if (!sps) {
> -        error_report("Bad page size encoding esid 0x"TARGET_FMT_lx
> -                     " vsid 0x"TARGET_FMT_lx, esid, vsid);
> -        return;
>      }
> =20
> -    slb->vsid =3D vsid;
> -    slb->esid =3D esid;
> -    slb->sps =3D sps;
> +    /* Otherwise, clear it to indicate error */
> +    slb->esid =3D slb->vsid =3D 0;
> +    slb->sps =3D NULL;
>  }
> =20
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
> @@ -1098,7 +1095,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    env->rmls =3D rmls_limit(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
> =20


