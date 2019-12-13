Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C269C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE97206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nF0JX50g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE97206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifbyn-00046W-TY
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 22:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifbxu-00037Q-0S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifbxs-0004P2-FY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:50:05 -0500
Received: from ozlabs.org ([203.11.71.1]:56549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifbxr-00048V-6d; Thu, 12 Dec 2019 22:50:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YxWK2l98z9sPK; Fri, 13 Dec 2019 14:49:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576208989;
 bh=fWRYHrP+LJ71fDqIKZeHr9pWe5lhohOawdP1OuHSIIs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nF0JX50gYDe29ZfEjqSDQGxup34kqoc4AQvUAbnjB3HpgY+hsCc4r4OVBr7Vw+qRA
 Rsrpzdqg7bT/2dhSrnWUINStlCPUzxMrIzmQJYdmrrRUMNfKD55Wa+scpi2Hmxfn1h
 mxlCEETyL43Ej64RDY9+S7XqV3d/RY7i7kY+qgcU=
Date: Fri, 13 Dec 2019 12:44:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] mos6522: remove anh register
Message-ID: <20191213014419.GA207300@umbus.fritz.box>
References: <20191212194359.13508-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cDyoBSpeMmeqjtIY"
Content-Disposition: inline
In-Reply-To: <20191212194359.13508-1-laurent@vivier.eu>
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cDyoBSpeMmeqjtIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 08:43:59PM +0100, Laurent Vivier wrote:
> Register addr 1 is defined as buffer A with handshake (vBufAH),
> register addr 15 is also defined as buffer A without handshake (vBufA).
>=20
> Linux kernel has a big "DON'T USE!" next to the register 1 addr
> definition (vBufAH), and only uses register 15 (vBufA).
>=20
> So remove the definition of 'anh' and use only 'a' (with VIA_REG_ANH and
> VIA_REG_A).

I'm not actually following the rationale for removing the register.
Linux doesn't use it, but if it's part of the real hardware model we
should keep it, no?

>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/misc/mos6522.c         | 12 ++++--------
>  include/hw/misc/mos6522.h |  1 -
>  2 files changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index cecf0be59e..86ede4005c 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -244,6 +244,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsi=
gned size)
>          val =3D s->b;
>          break;
>      case VIA_REG_A:
> +    case VIA_REG_ANH:
>          val =3D s->a;
>          break;
>      case VIA_REG_DIRB:
> @@ -297,9 +298,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsi=
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
> @@ -322,6 +321,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_=
t val, unsigned size)
>          mdc->portB_write(s);
>          break;
>      case VIA_REG_A:
> +    case VIA_REG_ANH:
>          s->a =3D (s->a & ~s->dira) | (val & s->dira);
>          mdc->portA_write(s);
>          break;
> @@ -395,9 +395,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_=
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
> @@ -439,7 +437,6 @@ const VMStateDescription vmstate_mos6522 =3D {
>          VMSTATE_UINT8(pcr, MOS6522State),
>          VMSTATE_UINT8(ifr, MOS6522State),
>          VMSTATE_UINT8(ier, MOS6522State),
> -        VMSTATE_UINT8(anh, MOS6522State),
>          VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 0,
>                               vmstate_mos6522_timer, MOS6522Timer),
>          VMSTATE_END_OF_LIST()
> @@ -460,7 +457,6 @@ static void mos6522_reset(DeviceState *dev)
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

--cDyoBSpeMmeqjtIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3y7PEACgkQbDjKyiDZ
s5J3eRAAyc92sDgjbqA+UXvH1j8uTQoXrklUbxYxq73SbbpZWXi+/B+R7nBSXLWd
blfbGhrC3NYeJpqtDfmUgfnYk4cvVY7NWI4TzRP3ett6rl23ByrbbYnsbsypYOS5
AN0ay4hobO4ZMI0qDAtegk8/qjZrR/1bOuV682JboUoMwx7f250laGgPJRa7ID5m
nQ4yvcodJ+4doqXp6Z08kS958g0C6GUoUBeX6+L0pQokdDlOD7MtMMsD2vpKmIcE
FNoOwNPaka0/yOZLBmp44s4cTIEacjzRsqMGCeD/sJ8e9gjiwGzd5UxiDkEfX5Pz
O1cFPZV45axa0hWnki0mf1m0coAKMctAPQWtghrRGICHZfP4bsRNdmiBmj6HSJlG
RGpT63AfGx8aZPiVjHYieFcApcAYI+TxM0+/Xkb25Zy04f9DapJ3PGRJyAl0JA+z
dqGaS52Qnto2CR1Xu3EFrUtJ19nW6fnrxbvHDqkvN8Yk3zMeFRX08gFoYWvnlW9k
Abqt5bLfrKsdGBQE/fW/m3ZKV17fqYwN0PUc6a1ShSITWoWi5iM/H7oTx0QObfb5
WjPTjg8yarZJeZdbXyaphzrF4PNc2LDqM7rMyh2pVKJtziKRkHnYNL/yGrToBtUa
i+mHvmhxWvsqgT5nkG+eVeMthWKzJ0K/g9UGfKGWhItIY3MmVlc=
=CtRB
-----END PGP SIGNATURE-----

--cDyoBSpeMmeqjtIY--

