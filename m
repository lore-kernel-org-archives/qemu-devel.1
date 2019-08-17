Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9229AC3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 04:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514E72173B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 04:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cutcl55j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514E72173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyqgs-0000PU-3K
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 00:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hyqg2-0008Na-6k
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 00:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hyqfz-0004m2-QU
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 00:50:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:35297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hyqfy-0004ka-6T; Sat, 17 Aug 2019 00:50:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 469SS41tbZz9sDB; Sat, 17 Aug 2019 14:50:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566017444;
 bh=A/Tqyy8V+EklIlgUSi5+1rSAnxHD9Tu/a0PMaNrEcYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cutcl55jfp2ojSfCCN3Z7t2JamTlZVemekbk2hjsnYrrlE+7aslYw2z4wlmloVHlP
 DdO5nYJe00U3AoKILPYmBs/m0bfvrAWwFvx9oYc6fVO6iOV5N83AI5UTY2b3j5I5ws
 qNWiEGkxx0sUjbMiaTiFEA221pTiCaZHf5jwHmqo=
Date: Sat, 17 Aug 2019 13:29:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190817032905.GC2259@umbus.fritz.box>
References: <20190816061733.53572-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20190816061733.53572-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH qemu] target/ppc: Add Directed Privileged
 Door-bell Exception State (DPDES) SPR
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
Cc: Paul Mackerras <paulus@samba.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 04:17:33PM +1000, Alexey Kardashevskiy wrote:
> DPDES stores a status of a doorbell message and if it is lost in
> migration, the destination CPU won't receive it. This does not hit us
> much as IPIs complete too quick to catch a pending one and even if
> we missed one, broadcasts happen often enough to wake that CPU.
>=20
> This defines DPDES and registers with KVM for migration.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Ouch, I'm kind of surprised this hasn't bitten us before.

Really we ought to also wire this up to the emulated doorbell
instructions as well, but this certainly improves the behaviour so
I've merged it to ppc-for-4.2.

> ---
>  target/ppc/cpu.h                |  1 +
>  target/ppc/translate_init.inc.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 64799386f9ab..f0521a435d2d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1466,6 +1466,7 @@ typedef PowerPCCPU ArchCPU;
>  #define SPR_MPC_ICTRL         (0x09E)
>  #define SPR_MPC_BAR           (0x09F)
>  #define SPR_PSPB              (0x09F)
> +#define SPR_DPDES             (0x0B0)
>  #define SPR_DAWR              (0x0B4)
>  #define SPR_RPR               (0x0BA)
>  #define SPR_CIABR             (0x0BB)
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index c9fcd87095f5..7e41ae145600 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8198,6 +8198,18 @@ static void gen_spr_power8_pspb(CPUPPCState *env)
>                       KVM_REG_PPC_PSPB, 0);
>  }
> =20
> +static void gen_spr_power8_dpdes(CPUPPCState *env)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    /* Directed Privileged Door-bell Exception State, used for IPI */
> +    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_generic,
> +                        KVM_REG_PPC_DPDES, 0x00000000);
> +#endif
> +}
> +
>  static void gen_spr_power8_ic(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> @@ -8629,6 +8641,7 @@ static void init_proc_POWER8(CPUPPCState *env)
>      gen_spr_power8_pmu_user(env);
>      gen_spr_power8_tm(env);
>      gen_spr_power8_pspb(env);
> +    gen_spr_power8_dpdes(env);
>      gen_spr_vtb(env);
>      gen_spr_power8_ic(env);
>      gen_spr_power8_book4(env);
> @@ -8817,6 +8830,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>      gen_spr_power8_pmu_user(env);
>      gen_spr_power8_tm(env);
>      gen_spr_power8_pspb(env);
> +    gen_spr_power8_dpdes(env);
>      gen_spr_vtb(env);
>      gen_spr_power8_ic(env);
>      gen_spr_power8_book4(env);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1XdH8ACgkQbDjKyiDZ
s5JhRA/+OQ13luMiOOJxqXTmE1uF59eWHf1PzfQjGV1TP9NZxjKyUeQAoz29pldp
LaqZzlBBS0emvQ24P2lNQZcHS2m0i3xVOONSmTw5NDh355PBy8QXbbLgZCr101RO
72qwNBUhkPXEKGCoO18lmos+kOeRMVFdR9q2HzPvFFNiugda61dSmcXYoN4ycz2C
sylhK7ctNegn3OA7+KQAfr/1CMEkneDzLtRsBLaAAvp9sgjamaLCMCQQ9TYrf20W
FRPbr+do7QfXrqZeS/oTIow/NkQZkhFECZRFDXOlSKnIyULN30a08OaEGVGk/6n0
t/Bj7cqC7I2Wu9f9d4RxEAk+ygKWyUm6+vQzp3EF60OxnaYOQH/ZH8+f/JxF0nnI
N6jgmUG1Yl3jI7KOwLeXOCYAsmFQaIvgAnbcBOhTUt4rVjKPdT3dEJlf9CJqowD6
xLiWahnCYyIoh02b1APcJkdSqf9I7K3pWRpXvkmWWus6r2e5lAW7YAuSDH2QCDcA
vGQlXbSxli0Rp9CgDH1MHa4K6y1Et44tyQ4KSLO0mZ+OUK/DSHtdt/Rk1CM1talx
RGKyXSpV0q/qojphb8gHN330nNlBmaNURb4EkUFR1hOiZvdV/HeDOeCE0AIWGVOB
5Rp76owwfolYhW8QjV+IMgLMzdAFu7PhVIP8Hm4QFx3ry+xeyAs=
=cV7Q
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

