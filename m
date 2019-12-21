Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60241C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303E720716
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U8gspHDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303E720716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTE3-0007dN-0B
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iiTAT-0002dg-Ca
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iiTAR-00076T-HC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:52 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:58299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iiTAQ-0006mT-AR; Fri, 20 Dec 2019 20:02:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47fnQs5Dbgz9sPW; Sat, 21 Dec 2019 12:02:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576890165;
 bh=ZMlODfpKIOt63T3fWQzG2RqghsW3+FZEp59QpxFhjFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U8gspHDyyWLRp9+r67UNbranb1OH4sjQxlh5/QZNK3u6LO7RsvjyFUt8FNeDfkXrt
 Rbt7Cixcwe2+6Uoxz9XTlwkGVCIJM59/l/ioBi+6iCvO8F+rMlPDFwvqvOwP6ZUA8J
 sGvpCzx9HEgqV9hL4XbreP1vOyuCYMr7oM89pqH0=
Date: Sat, 21 Dec 2019 11:33:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2] mos6522: remove anh register
Message-ID: <20191221003343.GB15511@umbus.fritz.box>
References: <20191220214054.76525-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20191220214054.76525-1-laurent@vivier.eu>
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 10:40:54PM +0100, Laurent Vivier wrote:
> Register addr 1 is defined as buffer A with handshake (vBufAH),
> register addr 15 is also defined as buffer A without handshake (vBufA).
>=20
> As both addresses access the same register, remove the definition of
> 'anh' and use only 'a' (with VIA_REG_ANH and VIA_REG_A).
>=20
> Fixes: 51f233ec92cd ("misc: introduce new mos6522 VIA device and enable i=
t for ppc builds")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Applied to ppc-for-5.0, thanks.

> ---
>=20
> Notes:
>     v2: update commit message (remove reference to linux)
>         add LOG_UNIMP for VIA_REG_A access
>=20
>  hw/misc/mos6522.c         | 16 ++++++++--------
>  include/hw/misc/mos6522.h |  1 -
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index cecf0be59e..10b85bf751 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -244,6 +244,9 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsi=
gned size)
>          val =3D s->b;
>          break;
>      case VIA_REG_A:
> +       qemu_log_mask(LOG_UNIMP, "Read access to register A with handshak=
e");
> +       /* fall through */
> +    case VIA_REG_ANH:
>          val =3D s->a;
>          break;
>      case VIA_REG_DIRB:
> @@ -297,9 +300,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsi=
gned size)
>          val =3D s->ier | 0x80;
>          break;
>      default:
> -    case VIA_REG_ANH:
> -        val =3D s->anh;
> -        break;
> +        g_assert_not_reached();
>      }
> =20
>      if (addr !=3D VIA_REG_IFR || val !=3D 0) {
> @@ -322,6 +323,9 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_=
t val, unsigned size)
>          mdc->portB_write(s);
>          break;
>      case VIA_REG_A:
> +       qemu_log_mask(LOG_UNIMP, "Write access to register A with handsha=
ke");
> +       /* fall through */
> +    case VIA_REG_ANH:
>          s->a =3D (s->a & ~s->dira) | (val & s->dira);
>          mdc->portA_write(s);
>          break;
> @@ -395,9 +399,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_=
t val, unsigned size)
>                                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      default:
> -    case VIA_REG_ANH:
> -        s->anh =3D val;
> -        break;
> +        g_assert_not_reached();
>      }
>  }
> =20
> @@ -439,7 +441,6 @@ const VMStateDescription vmstate_mos6522 =3D {
>          VMSTATE_UINT8(pcr, MOS6522State),
>          VMSTATE_UINT8(ifr, MOS6522State),
>          VMSTATE_UINT8(ier, MOS6522State),
> -        VMSTATE_UINT8(anh, MOS6522State),
>          VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 0,
>                               vmstate_mos6522_timer, MOS6522Timer),
>          VMSTATE_END_OF_LIST()
> @@ -460,7 +461,6 @@ static void mos6522_reset(DeviceState *dev)
>      s->ifr =3D 0;
>      s->ier =3D 0;
>      /* s->ier =3D T1_INT | SR_INT; */
> -    s->anh =3D 0;
> =20
>      s->timers[0].frequency =3D s->frequency;
>      s->timers[0].latch =3D 0xffff;
> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
> index 493c907537..97384c6e02 100644
> --- a/include/hw/misc/mos6522.h
> +++ b/include/hw/misc/mos6522.h
> @@ -115,7 +115,6 @@ typedef struct MOS6522State {
>      uint8_t pcr;
>      uint8_t ifr;
>      uint8_t ier;
> -    uint8_t anh;
> =20
>      MOS6522Timer timers[2];
>      uint64_t frequency;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl39aGQACgkQbDjKyiDZ
s5KF6w//Xf/WTzjQ54gHFF7DsJDPhKeq7fBRJeZcrlBDxr7KQ8BMfYw0adyPXkvI
uJfzFj8rT7QlCjH7FzTYQrvbYtNVI2AfQsqIvuCdCAgXShgLMGX+cLRqUAP0jlwM
h35KVrVAk+xn/zb7AvThdKSjWtIi9rLhO8V5o0CCmGGFIU+yWp7E7QBXdO8DFERi
9qPCNGIu/38rCu/UHXk43Z/iUdu1wd4mstdkxlzHS/3YSInhxGmprcL7Zqu0/qfL
fZjhvwkZlmiFQHHD+OhS0iDFzu8Ku/0UsUan8365G7hxrFE8RdAfRMY3lA8lF3d0
BeCRZGannX8qgDZAbzmkUkxJs60HwDeMNxw0Y3PaAKT0j4IDVS4EDpdHWNNJm+do
f7FWQIsE5D9fMbLqY/YjtiQz5NkNBLPqmHo05BYYOiWQDXESxxIn1DAYXt+AtPnJ
+2Q7H6MmDS7rwh88TeHVOE8X/FZyJO3v83Dzi1YaIKtRebT60xDiUbDZ4+VEn43R
+biOm3ObsccyRfV8lN1UZy5aqnLmm35l+l/qbNdudxX1sN8OBVtSqhPNqwrHdnu+
A2dCULA+vr38SyIbV3FtTKv9GjLSc7LPHRV8VMHj9JsOlNug9Lprh/x9pSoH8pMr
Jx1PCRKLTWKL65lHey4hft5MhwFp2UskszVBH+0XvZeHgM3//iQ=
=0tzF
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

