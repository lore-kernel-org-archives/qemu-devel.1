Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF73C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613E720874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dxNkXVHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613E720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1harvG-0005pJ-Mt
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hartb-0004rO-Cj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hartZ-0002nG-9g
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:17:47 -0400
Received: from ozlabs.org ([203.11.71.1]:58729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hartX-0002li-7e; Tue, 11 Jun 2019 21:17:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NprY5S19z9s6w; Wed, 12 Jun 2019 11:17:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560302253;
 bh=r3U60mU7TC7ps/NHSQpVr83008lVy+KhfoR9CYZwefg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dxNkXVHCEMFUwoJE+LIOAeedmMh6h68yFlpBRyk/KIbdHUk4+tTDmNMq/PjWuAPhe
 /Ogvc5IZwdzTtArLOOhaXTvlFiKOih/RiRxJnnFxz++YOJjlt6MZ/nyfdZtvhtnN4w
 SZOyq+Y3QjocokDjKTh97dwNj89+D8Qtbms434pE=
Date: Wed, 12 Jun 2019 11:04:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190612010459.GD3998@umbus.fritz.box>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20190602110903.3431-3-mark.cave-ayland@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 02/15] target/ppc: remove
 getVSR()/putVSR() from mem_helper.c
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2019 at 12:08:50PM +0100, Mark Cave-Ayland wrote:
> Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
> registers are in host endian order" functions getVSR() and putVSR() which=
 used
> to convert the VSR registers into host endian order are no longer require=
d.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/mem_helper.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 5b0f9ee50d..17a3c931a9 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -417,26 +417,27 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
>  void helper_##name(CPUPPCState *env, target_ulong addr,                 \
>                     target_ulong xt_num, target_ulong rb)                \
>  {                                                                       \
> -    int i;                                                              \
> -    ppc_vsr_t xt;                                                       \
> +    ppc_vsr_t *xt =3D &env->vsr[xt_num];                                =
  \
> +    ppc_vsr_t t;                                                        \
>      uint64_t nb =3D GET_NB(rb);                                         =
  \
> +    int i;                                                              \
>                                                                          \
> -    xt.s128 =3D int128_zero();                                          =
  \
> +    t.s128 =3D int128_zero();                                           =
  \
>      if (nb) {                                                           \
>          nb =3D (nb >=3D 16) ? 16 : nb;                                  =
    \
>          if (msr_le && !lj) {                                            \
>              for (i =3D 16; i > 16 - nb; i--) {                          =
  \
> -                xt.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC());=
  \
> +                t.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC()); =
  \
>                  addr =3D addr_add(env, addr, 1);                        =
  \
>              }                                                           \
>          } else {                                                        \
>              for (i =3D 0; i < nb; i++) {                                =
  \
> -                xt.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());    =
  \
> +                t.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());     =
  \
>                  addr =3D addr_add(env, addr, 1);                        =
  \
>              }                                                           \
>          }                                                               \
>      }                                                                   \
> -    putVSR(xt_num, &xt, env);                                           \
> +    *xt =3D t;                                                          =
  \
>  }
> =20
>  VSX_LXVL(lxvl, 0)
> @@ -447,26 +448,28 @@ VSX_LXVL(lxvll, 1)
>  void helper_##name(CPUPPCState *env, target_ulong addr,           \
>                     target_ulong xt_num, target_ulong rb)          \
>  {                                                                 \
> -    int i;                                                        \
> -    ppc_vsr_t xt;                                                 \
> +    ppc_vsr_t *xt =3D &env->vsr[xt_num];                            \
> +    ppc_vsr_t t =3D *xt;                                            \
>      target_ulong nb =3D GET_NB(rb);                                 \
> +    int i;                                                        \
>                                                                    \
>      if (!nb) {                                                    \
>          return;                                                   \
>      }                                                             \
> -    getVSR(xt_num, &xt, env);                                     \
> +                                                                  \
>      nb =3D (nb >=3D 16) ? 16 : nb;                                    \
>      if (msr_le && !lj) {                                          \
>          for (i =3D 16; i > 16 - nb; i--) {                          \
> -            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
> +            cpu_stb_data_ra(env, addr, t.VsrB(i - 1), GETPC());   \
>              addr =3D addr_add(env, addr, 1);                        \
>          }                                                         \
>      } else {                                                      \
>          for (i =3D 0; i < nb; i++) {                                \
> -            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
> +            cpu_stb_data_ra(env, addr, t.VsrB(i), GETPC())  ;     \
>              addr =3D addr_add(env, addr, 1);                        \
>          }                                                         \
>      }                                                             \
> +    *xt =3D t;                                                      \

Is this correct?  AFAICT the original wasn't writing back, so why does
the new version?

>  }
> =20
>  VSX_STXVL(stxvl, 0)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0AT7oACgkQbDjKyiDZ
s5L4ow//Qc/brm4yUV9ilN/e3jH5OlW7Sq3VLFfwSpYA4PTedDijvgPa56BMGgX2
cUctcefg4V2zIDK94gt5EC2sib+lNbpE+Pucqu0GM83pfQmjNKYo5jByqd8lu/hQ
j/1UZkT8XmsqET7sRQ8IwB1FwY5a7mMQnHHsan00w8w1sgkvK/BaztaAwxjM2lEs
kc+1tC91P0EUpOiYknkkvOjYKUPX2Jy2q3Vho1/ROKjZlaR+sMVS1ImOhcZ1n3fm
FEbHgqUwfQLV40rarvJGca/2c8bZfJiV+ILmxJTfntrwBImVO6E+mQK+sgwj29r1
X5TEOUQ1C16MlRHV4HDuh4PmCBgeefFv1jAZOhEUO4MVoyw7HU7qA6CbdWeaypom
+8rwenjVxmonq/UBpQI8OoqGbNmUwJtd5wenLI17rqYCfvJDIOQN4bIHsfr6v1Sk
dOlW9rcAjEJHPVt04suX/MnPvluyWOmkZQ02GPcN2paizooyP7F6crIF7Wwu1sC0
H7si5HrUB09GKhwyERcEGNqV+aEp9VXv0JEwx4rtWM6+vUH1AKF7vRP3bdfNNWyy
5QNHkt5PEbJeSudBv+MDqAG+8s0YG+/r7b/780i20A3zkHMD5G1qfBgUj4wz8/IW
F6Ek/LNypJMqtKi/ZYmSII+RkwD2XsjsW5IGB/eLJ5lhmCaqSg8=
=sr8X
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

