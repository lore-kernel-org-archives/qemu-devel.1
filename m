Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB880C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9690120714
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YBY2wJx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9690120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEobL-0002EH-MU
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 02:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEoaL-0001LO-Hs
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEoaK-0002Cm-1a
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:23:17 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEoaJ-0002CS-MH; Thu, 19 Mar 2020 02:23:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jcKX6xrPz9sRY; Thu, 19 Mar 2020 17:23:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584598992;
 bh=+eRKNE66gWG+MA2cCeGFbxXRynxYkg9K7HolDezeB2w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YBY2wJx1108eiYWkE9INd2Z5Db7Cieydgp64Y94c8HPlIalC0u84Q7eRgQxyRR+bD
 5hFmhD00LOsJxf1ulJ0G9o9WdDAQK6ICIq57QE3WhM2IxHfiYREyO9OyEiyyfGDOlx
 qdxR0RHu5+xhnzC5rE2bSF5GgJvIGp9CD0HozNMY=
Date: Thu, 19 Mar 2020 17:22:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/2] target/ppc: Improve syscall exception logging
Message-ID: <20200319062226.GJ628315@umbus.fritz.box>
References: <20200317054918.199161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
Content-Disposition: inline
In-Reply-To: <20200317054918.199161-1-npiggin@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 03:49:17PM +1000, Nicholas Piggin wrote:
> system calls (at least in Linux) use registers r3-r8 for inputs, so
> include those registers in the dump.
>=20
> This also adds a mode for PAPR hcalls, which have a different calling
> convention.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to a newly created ppc-for-5.1 branch.

> ---
> Since v2:
> - Rebased on top of FWNMI series
>=20
>  target/ppc/excp_helper.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 08bc885ca6..81ee19ebae 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -57,12 +57,29 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>  #else /* defined(CONFIG_USER_ONLY) */
>  static inline void dump_syscall(CPUPPCState *env)
>  {
> -    qemu_log_mask(CPU_LOG_INT, "syscall r0=3D%016" PRIx64 " r3=3D%016" P=
RIx64
> -                  " r4=3D%016" PRIx64 " r5=3D%016" PRIx64 " r6=3D%016" P=
RIx64
> +    qemu_log_mask(CPU_LOG_INT, "syscall r0=3D%016" PRIx64
> +                  " r3=3D%016" PRIx64 " r4=3D%016" PRIx64 " r5=3D%016" P=
RIx64
> +                  " r6=3D%016" PRIx64 " r7=3D%016" PRIx64 " r8=3D%016" P=
RIx64
>                    " nip=3D" TARGET_FMT_lx "\n",
>                    ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
>                    ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
> -                  ppc_dump_gpr(env, 6), env->nip);
> +                  ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
> +                  ppc_dump_gpr(env, 8), env->nip);
> +}
> +
> +static inline void dump_hcall(CPUPPCState *env)
> +{
> +    qemu_log_mask(CPU_LOG_INT, "hypercall r3=3D%016" PRIx64
> +		  " r4=3D%016" PRIx64 " r5=3D%016" PRIx64 " r6=3D%016" PRIx64
> +		  " r7=3D%016" PRIx64 " r8=3D%016" PRIx64 " r9=3D%016" PRIx64
> +		  " r10=3D%016" PRIx64 " r11=3D%016" PRIx64 " r12=3D%016" PRIx64
> +                  " nip=3D" TARGET_FMT_lx "\n",
> +                  ppc_dump_gpr(env, 3), ppc_dump_gpr(env, 4),
> +		  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
> +		  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
> +		  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
> +		  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
> +		  env->nip);
>  }
> =20
>  static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
> @@ -379,9 +396,14 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>          }
>          break;
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
> -        dump_syscall(env);
>          lev =3D env->error_code;
> =20
> +        if ((lev =3D=3D 1) && cpu->vhyp) {
> +            dump_hcall(env);
> +        } else {
> +            dump_syscall(env);
> +        }
> +
>          /*
>           * We need to correct the NIP which in this case is supposed
>           * to point to the next instruction

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zD6IACgkQbDjKyiDZ
s5J7ORAA4wrFtiIcm1yMV1Rs7kO+ddLbYP4UNVehLy0XqgUSjtLIUG5q/ciV2k5A
BgoCrSui9JAvc/CtUX8OLsa4ux9GZ5Bv0c3Kozwl+CTFeLx9EvmX2gN+oqARYdf/
uU8urf76d/LqVlIaqj1YdQOmpqCePXXGwtYBk+1LmkpxffpEWWrSCn/i5FDMUyTH
BhRT3AnJ+llUaamcjYUSWVb5IVTrOJurUpapRuYFcwwHKaqCWPn44/QcZSVcbiHA
RmLpndq9Qzrpx3NVg7jm2zuQct8mUoYBB4HHFj3oZcpLoKIKae5stbe9Ur0XjYX1
tOO8e6MoLOfWQkxRaftp1JGZ7GLd1dJ4WgKeBUxIAamFocljX4mry9WhspXWLfJ9
nT0trD1Hjo75P8IkGpvMFle2qtfnqmW9XrXO7OYGLSr5R8B8BrgWhRFWKwYbTgdp
O+rta0IhHxKH8jMIbjIPRY3vU/YQvCROYiBlbqiLWpwMTGZvDwCRlYLK24cnxYrT
lSV4Y1ImJ/6J4fiDnOZMNONSe4Db56UGmoAMbNruKFHP9/IApO29gUOemhNXXyyy
WzfajQ53p8gRcFHwv20Pxt14fx5db0V0Txm7uW1tS9Os4XTPae5G3PK4XEWAK6un
h8YRqyqJq9C16fR7/3gwBcuY5SC/tuEXjIEZNfo7ocjhnqVvFDE=
=jvGM
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--

