Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE24C32793
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 10:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A104207FA
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gADNECAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A104207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEW8R-0004WT-7s
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 06:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEW6u-0003SE-6n
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 06:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEW6q-0006Aq-Gk
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 06:07:24 -0400
Received: from ozlabs.org ([203.11.71.1]:38775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEW6p-000621-IH; Sun, 29 Sep 2019 06:07:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46h1RM5N9Zz9sN1; Sun, 29 Sep 2019 20:07:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569751631;
 bh=5v4ImmC4mfSI809ed6IugMP2rnpnt1d07cTonQ5H+n8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gADNECAnXBp4cOOsSEO1ih27uVkWFyIUmMxA7DZ9eZnlAVw8X8Dyw0tKBYtTuMBYK
 KRwmPBIILCR01Q9iquxlTqF6q9XLkor4S9JPbd7vDgO76VWUPpu6oZ2fjbLYe9RoEQ
 HueyYza04atnBthS/WmuwG1R/fR/7TnQbXscp5tY=
Date: Sun, 29 Sep 2019 19:29:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] target/ppc: use Vsr macros in BCD helpers
Message-ID: <20190929092916.GC12116@umbus.fritz.box>
References: <20190926204453.31837-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20190926204453.31837-1-mark.cave-ayland@ilande.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 09:44:53PM +0100, Mark Cave-Ayland wrote:
> This allows us to remove more endian-specific defines from int_helper.c.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  target/ppc/int_helper.c | 72 ++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 47 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 46deb57a34..6d238b989d 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2052,15 +2052,11 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, ppc_avr_t *c)
>  #define NATIONAL_PLUS   0x2B
>  #define NATIONAL_NEG    0x2D
> =20
> -#if defined(HOST_WORDS_BIGENDIAN)
>  #define BCD_DIG_BYTE(n) (15 - ((n) / 2))
> -#else
> -#define BCD_DIG_BYTE(n) ((n) / 2)
> -#endif
> =20
>  static int bcd_get_sgn(ppc_avr_t *bcd)
>  {
> -    switch (bcd->u8[BCD_DIG_BYTE(0)] & 0xF) {
> +    switch (bcd->VsrB(BCD_DIG_BYTE(0)) & 0xF) {
>      case BCD_PLUS_PREF_1:
>      case BCD_PLUS_PREF_2:
>      case BCD_PLUS_ALT_1:
> @@ -2095,9 +2091,9 @@ static uint8_t bcd_get_digit(ppc_avr_t *bcd, int n,=
 int *invalid)
>  {
>      uint8_t result;
>      if (n & 1) {
> -        result =3D bcd->u8[BCD_DIG_BYTE(n)] >> 4;
> +        result =3D bcd->VsrB(BCD_DIG_BYTE(n)) >> 4;
>      } else {
> -       result =3D bcd->u8[BCD_DIG_BYTE(n)] & 0xF;
> +       result =3D bcd->VsrB(BCD_DIG_BYTE(n)) & 0xF;
>      }
> =20
>      if (unlikely(result > 9)) {
> @@ -2109,11 +2105,11 @@ static uint8_t bcd_get_digit(ppc_avr_t *bcd, int =
n, int *invalid)
>  static void bcd_put_digit(ppc_avr_t *bcd, uint8_t digit, int n)
>  {
>      if (n & 1) {
> -        bcd->u8[BCD_DIG_BYTE(n)] &=3D 0x0F;
> -        bcd->u8[BCD_DIG_BYTE(n)] |=3D (digit << 4);
> +        bcd->VsrB(BCD_DIG_BYTE(n)) &=3D 0x0F;
> +        bcd->VsrB(BCD_DIG_BYTE(n)) |=3D (digit << 4);
>      } else {
> -        bcd->u8[BCD_DIG_BYTE(n)] &=3D 0xF0;
> -        bcd->u8[BCD_DIG_BYTE(n)] |=3D digit;
> +        bcd->VsrB(BCD_DIG_BYTE(n)) &=3D 0xF0;
> +        bcd->VsrB(BCD_DIG_BYTE(n)) |=3D digit;
>      }
>  }
> =20
> @@ -2228,21 +2224,21 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *=
a, ppc_avr_t *b, uint32_t ps)
> =20
>      if (!invalid) {
>          if (sgna =3D=3D sgnb) {
> -            result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, ps);
> +            result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(sgna, ps);
>              bcd_add_mag(&result, a, b, &invalid, &overflow);
>              cr =3D bcd_cmp_zero(&result);
>          } else {
>              int magnitude =3D bcd_cmp_mag(a, b);
>              if (magnitude > 0) {
> -                result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, p=
s);
> +                result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(sgna,=
 ps);
>                  bcd_sub_mag(&result, a, b, &invalid, &overflow);
>                  cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
>              } else if (magnitude < 0) {
> -                result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgnb, p=
s);
> +                result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(sgnb,=
 ps);
>                  bcd_sub_mag(&result, b, a, &invalid, &overflow);
>                  cr =3D (sgnb > 0) ? CRF_GT : CRF_LT;
>              } else {
> -                result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(0, ps);
> +                result.VsrB(BCD_DIG_BYTE(0)) =3D bcd_preferred_sgn(0, ps=
);
>                  cr =3D CRF_EQ;
>              }
>          }
> @@ -2353,15 +2349,15 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b=
, uint32_t ps)
>      int zone_lead =3D ps ? 0xF : 0x3;
>      int digit =3D 0;
>      ppc_avr_t ret =3D { .u64 =3D { 0, 0 } };
> -    int sgnb =3D b->u8[BCD_DIG_BYTE(0)] >> 4;
> +    int sgnb =3D b->VsrB(BCD_DIG_BYTE(0)) >> 4;
> =20
>      if (unlikely((sgnb < 0xA) && ps)) {
>          invalid =3D 1;
>      }
> =20
>      for (i =3D 0; i < 16; i++) {
> -        zone_digit =3D i ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
> -        digit =3D b->u8[BCD_DIG_BYTE(i * 2)] & 0xF;
> +        zone_digit =3D i ? b->VsrB(BCD_DIG_BYTE(i * 2)) >> 4 : zone_lead;
> +        digit =3D b->VsrB(BCD_DIG_BYTE(i * 2)) & 0xF;
>          if (unlikely(zone_digit !=3D zone_lead || digit > 0x9)) {
>              invalid =3D 1;
>              break;
> @@ -2407,7 +2403,7 @@ uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, =
uint32_t ps)
>              break;
>          }
> =20
> -        ret.u8[BCD_DIG_BYTE(i * 2)] =3D zone_lead + digit;
> +        ret.VsrB(BCD_DIG_BYTE(i * 2)) =3D zone_lead + digit;
>      }
> =20
>      if (ps) {
> @@ -2519,7 +2515,7 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a=
, ppc_avr_t *b, uint32_t ps)
>      }
> =20
>      *r =3D *a;
> -    bcd_put_digit(r, b->u8[BCD_DIG_BYTE(0)] & 0xF, 0);
> +    bcd_put_digit(r, b->VsrB(BCD_DIG_BYTE(0)) & 0xF, 0);
> =20
>      for (i =3D 1; i < 32; i++) {
>          bcd_get_digit(a, i, &invalid);
> @@ -2549,11 +2545,7 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t =
*b, uint32_t ps)
>  uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t =
ps)
>  {
>      int cr;
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    int i =3D a->s8[7];
> -#else
> -    int i =3D a->s8[8];
> -#endif
> +    int i =3D a->VsrSB(7);
>      bool ox_flag =3D false;
>      int sgnb =3D bcd_get_sgn(b);
>      ppc_avr_t ret =3D *b;
> @@ -2602,11 +2594,7 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, uint32_t ps)
>          }
>      }
> =20
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    i =3D a->s8[7];
> -#else
> -    i =3D a->s8[8];
> -#endif
> +    i =3D a->VsrSB(7);
>      if (i >=3D 32) {
>          ox_flag =3D true;
>          ret.VsrD(1) =3D ret.VsrD(0) =3D 0;
> @@ -2637,13 +2625,11 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a,=
 ppc_avr_t *b, uint32_t ps)
>      ppc_avr_t ret =3D *b;
>      ret.VsrD(1) &=3D ~0xf;
> =20
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    int i =3D a->s8[7];
> -    ppc_avr_t bcd_one =3D { .u64 =3D { 0, 0x10 } };
> -#else
> -    int i =3D a->s8[8];
> -    ppc_avr_t bcd_one =3D { .u64 =3D { 0x10, 0 } };
> -#endif
> +    int i =3D a->VsrSB(7);
> +    ppc_avr_t bcd_one;
> +
> +    bcd_one.VsrD(0) =3D 0;
> +    bcd_one.VsrD(1) =3D 0x10;
> =20
>      if (bcd_is_valid(b) =3D=3D false) {
>          return CRF_SO;
> @@ -2679,11 +2665,7 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *=
a, ppc_avr_t *b, uint32_t ps)
>  {
>      uint64_t mask;
>      uint32_t ox_flag =3D 0;
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    int i =3D a->s16[3] + 1;
> -#else
> -    int i =3D a->s16[4] + 1;
> -#endif
> +    int i =3D a->VsrSH(3) + 1;
>      ppc_avr_t ret =3D *b;
> =20
>      if (bcd_is_valid(b) =3D=3D false) {
> @@ -2728,11 +2710,7 @@ uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t =
*a, ppc_avr_t *b, uint32_t ps)
>          }
>      }
> =20
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    i =3D a->s16[3];
> -#else
> -    i =3D a->s16[4];
> -#endif
> +    i =3D a->VsrSH(3);
>      if (i > 16 && i < 33) {
>          mask =3D (uint64_t)-1 >> (128 - i * 4);
>          if (ret.VsrD(0) & ~mask) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2QeWkACgkQbDjKyiDZ
s5LpARAAuZVZLy/dIJDGGV8n/q17wGJhGz9PT9T7WjjI9TAJbmAI86scLaW6PEOE
LAAsA3boNv3JpGG/Fe1ZpXjZggPnNtQPPlklfRh++PFDoMW2Hxvc2ha+0ANl3X8N
MZKY3xdTnD45mVv6WBE3fpDA+HPuf9LPTYYbUzruAp2Brz7ayZBJWv6SCw30lBbG
w+YHiDjeqMq8FXlR4kYJBREmGF//z8a2r2pUMvOnemj3/6MkkAuESUM7KtRcLXSE
IXngvhWOJEjlkzjlBjjHZaWgU6BPZ6st2U9c5XG5nhK0yayGx78udzSzyXY/Hv89
meCQm5x9h7h5pZrwY/4bXgEYd0LtXAIN69ymFwZgp42VqK/556cYSResOFpOe1fz
Fh5rmzCHyOH+BwOjpmKRYsQXyN7e2MIN2DBQxnA7XV/CqTtDgy8vdUoFMJ3nANkZ
qROv068cLsf0fr3aOrB5U0ckE15+tGvQUEWfaCtBMrWjer2poZ1FnVb0EY/bpAm7
Fv8OjX07tmQaDW6w+ylflGXH99pPFUSQdpXR0ORmA6CJb1Hss5E+tWRQXP7elv8Z
7o575rwx+wnqVN9+1adaZqmzcW5a7BVMrNX7JWAxRPKIXNlcwjwu0gPKSMleFiom
Ye6+ypPMp9gh1Qt1EwKguVHKN/4X1V/MghEsrH+3MI0/EVMnv5I=
=9dpI
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

