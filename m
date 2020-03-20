Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36214C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039FE20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z/xhzbzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039FE20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDNS-0000tL-4a
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jFDMb-0007zP-Oj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jFDMa-0002r4-33
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:50:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53395 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jFDMZ-0002h0-0p; Fri, 20 Mar 2020 04:50:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48kHY73bh2z9sSN; Fri, 20 Mar 2020 19:50:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584694235;
 bh=joyYpIWAtsYaCGLoDXyLrFrtPpTupBaYcHdFyMVkTa4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z/xhzbzDVm2SpYxEPKgONlXfU2yDS6qF9rVlpQi6r35ynAXxhnYC2U1kfy3tCMUZE
 st0LAJrHU5OTvvHMZ5mAUFJYt6r9ooUOzc/7TiMsKcN7DIKlGdvwjr0Zc5UpEJvOO6
 NLqrOqxP/4ZzWTfZd1hOmFZoBXZtyhxVP7xV5kQI=
Date: Fri, 20 Mar 2020 19:49:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] target/ppc: Fix ISA v3.0 (POWER9) slbia implementation
Message-ID: <20200320084944.GC781112@umbus.fritz.box>
References: <20200319064439.1020571-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20200319064439.1020571-1-npiggin@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 04:44:39PM +1000, Nicholas Piggin wrote:
> The new ISA v3.0 slbia variants have not been implemented for TCG,
> which can lead to crashing when a POWER9 machine boots Linux using
> the hash MMU, for example ("disable_radix" kernel command line).
>=20
> Add them.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0.

> ---
> Changes in v2:
> - Rewrite changelog.
> - Remove stray slbie hunk that crept in
>=20
> I don't think the slbie invalidation is necessary, as explained on the
> list.
>=20
>  target/ppc/helper.h     |  2 +-
>  target/ppc/mmu-hash64.c | 56 +++++++++++++++++++++++++++++++++++------
>  target/ppc/translate.c  |  5 +++-
>  3 files changed, 54 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index ee1498050d..2dfa1c6942 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -615,7 +615,7 @@ DEF_HELPER_FLAGS_3(store_slb, TCG_CALL_NO_RWG, void, =
env, tl, tl)
>  DEF_HELPER_2(load_slb_esid, tl, env, tl)
>  DEF_HELPER_2(load_slb_vsid, tl, env, tl)
>  DEF_HELPER_2(find_slb_vsid, tl, env, tl)
> -DEF_HELPER_FLAGS_1(slbia, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_2(slbia, TCG_CALL_NO_RWG, void, env, i32)
>  DEF_HELPER_FLAGS_2(slbie, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_FLAGS_2(slbieg, TCG_CALL_NO_RWG, void, env, tl)
>  #endif
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 373d44de74..e5baabf0e1 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -95,9 +95,10 @@ void dump_slb(PowerPCCPU *cpu)
>      }
>  }
> =20
> -void helper_slbia(CPUPPCState *env)
> +void helper_slbia(CPUPPCState *env, uint32_t ih)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> +    int starting_entry;
>      int n;
> =20
>      /*
> @@ -111,18 +112,59 @@ void helper_slbia(CPUPPCState *env)
>       * expected that slbmte is more common than slbia, and slbia is usua=
lly
>       * going to evict valid SLB entries, so that tradeoff is unlikely to=
 be a
>       * good one.
> +     *
> +     * ISA v2.05 introduced IH field with values 0,1,2,6. These all inva=
lidate
> +     * the same SLB entries (everything but entry 0), but differ in what
> +     * "lookaside information" is invalidated. TCG can ignore this and f=
lush
> +     * everything.
> +     *
> +     * ISA v3.0 introduced additional values 3,4,7, which change what SL=
Bs are
> +     * invalidated.
>       */
> =20
> -    /* XXX: Warning: slbia never invalidates the first segment */
> -    for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
> -        ppc_slb_t *slb =3D &env->slb[n];
> +    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> +
> +    starting_entry =3D 1; /* default for IH=3D0,1,2,6 */
> +
> +    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +        switch (ih) {
> +        case 0x7:
> +            /* invalidate no SLBs, but all lookaside information */
> +            return;
> =20
> -        if (slb->esid & SLB_ESID_V) {
> -            slb->esid &=3D ~SLB_ESID_V;
> +        case 0x3:
> +        case 0x4:
> +            /* also considers SLB entry 0 */
> +            starting_entry =3D 0;
> +            break;
> +
> +        case 0x5:
> +            /* treat undefined values as ih=3D=3D0, and warn */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "slbia undefined IH field %u.\n", ih);
> +            break;
> +
> +        default:
> +            /* 0,1,2,6 */
> +            break;
>          }
>      }
> =20
> -    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> +    for (n =3D starting_entry; n < cpu->hash64_opts->slb_size; n++) {
> +        ppc_slb_t *slb =3D &env->slb[n];
> +
> +        if (!(slb->esid & SLB_ESID_V)) {
> +            continue;
> +        }
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +            if (ih =3D=3D 0x3 && (slb->vsid & SLB_VSID_C) =3D=3D 0) {
> +                /* preserves entries with a class value of 0 */
> +                continue;
> +            }
> +        }
> +
> +        slb->esid &=3D ~SLB_ESID_V;
> +    }
>  }
> =20
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index eb0ddba850..e514732a09 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -5027,12 +5027,15 @@ static void gen_tlbsync(DisasContext *ctx)
>  /* slbia */
>  static void gen_slbia(DisasContext *ctx)
>  {
> +    uint32_t ih =3D (ctx->opcode >> 21) & 0x7;
> +    TCGv_i32 t0 =3D tcg_const_i32(ih);
> +
>  #if defined(CONFIG_USER_ONLY)
>      GEN_PRIV;
>  #else
>      CHK_SV;
> =20
> -    gen_helper_slbia(cpu_env);
> +    gen_helper_slbia(cpu_env, t0);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl50g6cACgkQbDjKyiDZ
s5KUnBAAnj8OKTxmPvPMDvR5hDpZAEPmIaa0cUlw59hsFj+Upqvht58gXrNu+/at
veVeMfmAhqeFOrjAuagzbde5mTQYLrSatkcMO03zOMSzKr9/Donyti1GSE11Tpop
To+iv92Qiq98r4FEtCwcXDHs1jvRBpFy7MsJslPQlEwpsi2tOeuBeFj7lUl3n7FY
DcC8E7Fza60OtSvsyARN4IElRI1hY50luBUrTqJm/Sx1zRafO9ND7wHtXGUnIxWd
syw5qWhAQwWppF2PFAqvYf47WOFRQWHnAVeHdnijegm4/Zt1xYV30hAQSgPRQQ2S
M1vLeFJzPevNgJchkqd4DPXvNtxG1sKLvbR7/AZaBmepUvPoaHMsakHfwd3rTzRK
8xDiGOoYnZmnpdk8fFkagaJEbyqq0lF2SC6oBMp97S0TvrIgzQ3bHIBE0m2Ap/Y/
rOlbcxbomdJ5st37eliQP2heYiW63f8IH7WntWQzhP6ZC7fAHosq0Ukpm7jm4zsm
BgLH26u/NzxMCKVo/tP8eNxoOyZFR2YTwjdEZMSFN1uJbUkWoUkMJZ90rV0yGNLR
vRo4NygQJy2OH5PnVPQTSqM4VPmWqEJ/4iEZpO2c2ArI9ge8McDoMugP7nKpmtf2
QqFqsdDwd0Yq7/+cmUk96KPdusi5Y6vja5V5k6GBSTpnYxofbFA=
=oI3P
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

