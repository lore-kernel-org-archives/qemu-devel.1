Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F3C04AB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929E4208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UBMLeL2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929E4208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ2d9-0007i7-SV
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 20:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2bK-0006ca-DW
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2bI-0003NK-Hs
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:19:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hZ2bF-0003K1-IZ; Thu, 06 Jun 2019 20:19:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45KjnX3xKBz9s00; Fri,  7 Jun 2019 10:19:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1559866752;
 bh=jXAH74gBgIPoSN8cJo7sk21jeoXBpK3BhIL3PaRpk1U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UBMLeL2zNyRGJQGAQ1TDxOwV2/DKllH33t6Et/EzV4RRnL+3wEFv8kOjEsPDLOC5w
 Juy0XCs0M0YfJIO6ljNQWtmksgGKpjPjD9MhRThtxGlYdIA4zvD1IS2les4Pw+lgyf
 bodVrbHu9eVQJxLnyQO27yBTE3MRZoyTmylQ/GiQ=
Date: Fri, 7 Jun 2019 10:16:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190607001632.GB3760@umbus.fritz.box>
References: <20190606174409.12502-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20190606174409.12502-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/xive: Make XIVE generate the proper
 interrupt types
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 07:44:09PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> It should be generic Hypervisor Virtualization interrupts for HV
> directed rings and traditional External Interrupts for the OS directed
> ring.
>=20
> Don't generate anything for the user ring as it isn't actually
> supported.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied, thanks.

> ---
>=20
>  I forgot to resend this patch, an important one for HV machines !
>=20
>  include/hw/ppc/xive.h |  3 ++-
>  hw/intc/xive.c        | 22 +++++++++++++++++++---
>  2 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index d872f96d1a1b..a6ee7e831d8b 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -317,7 +317,8 @@ typedef struct XiveTCTX {
>      DeviceState parent_obj;
> =20
>      CPUState    *cs;
> -    qemu_irq    output;
> +    qemu_irq    hv_output;
> +    qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>  } XiveTCTX;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 0c74e47aa49c..b2b92a92c84f 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -61,13 +61,28 @@ static uint8_t exception_mask(uint8_t ring)
>      }
>  }
> =20
> +static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
> +{
> +        switch (ring) {
> +        case TM_QW0_USER:
> +                return 0; /* Not supported */
> +        case TM_QW1_OS:
> +                return tctx->os_output;
> +        case TM_QW2_HV_POOL:
> +        case TM_QW3_HV_PHYS:
> +                return tctx->hv_output;
> +        default:
> +                return 0;
> +        }
> +}
> +
>  static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>  {
>      uint8_t *regs =3D &tctx->regs[ring];
>      uint8_t nsr =3D regs[TM_NSR];
>      uint8_t mask =3D exception_mask(ring);
> =20
> -    qemu_irq_lower(tctx->output);
> +    qemu_irq_lower(xive_tctx_output(tctx, ring));
> =20
>      if (regs[TM_NSR] & mask) {
>          uint8_t cppr =3D regs[TM_PIPR];
> @@ -100,7 +115,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t =
ring)
>          default:
>              g_assert_not_reached();
>          }
> -        qemu_irq_raise(tctx->output);
> +        qemu_irq_raise(xive_tctx_output(tctx, ring));
>      }
>  }
> =20
> @@ -556,7 +571,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
>      env =3D &cpu->env;
>      switch (PPC_INPUT(env)) {
>      case PPC_FLAGS_INPUT_POWER9:
> -        tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
> +        tctx->hv_output =3D env->irq_inputs[POWER9_INPUT_HINT];
> +        tctx->os_output =3D env->irq_inputs[POWER9_INPUT_INT];
>          break;
> =20
>      default:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz5rN8ACgkQbDjKyiDZ
s5KNqBAAuZ06mLT4Yiiszm/LjJ+NtOqFIA76PDVSTwt67yY1fUAoJpOsfWns8NHe
K2DxiCCfikw6Y7VQ+ERCNtbKeedkJBlNtJsP8wowcjZsc3F2WAS9zIvtycfhEYra
+MLKULGWxPdk5TPp3uf5PHquBGkxUCbY9TKejp3qXfGK8kLnyKhYlSt7FSbR/THJ
s/VWr5KnI8+vpA0xFrAfKsn6zMkqsm6kb3rRwdSuCBE5rLsVjrjYo3YfC9I82fjv
9pa5r4bf3amS9Gnhp3qlmXm21qXdtHGxIK4+6nDQjjARKrpxACWZKUXjfhwgpM4h
Ahmp502pXXl7Mynm9UlWasmUwe7w8vq8FXG5kq5QKWfdb1LWAcojjWkTAgzRp4xs
TcF76SseiJ8WyVyQzgdoxre59+2zaNUxSEPd+phvsccF5xh3L+WBp4fAukWig4bc
gOVbkJfgQsLqLmWQvgvBq8FDvk0Fklb6i7YPbrwZtSxHSOMzRLAM2zacyWK/eKaG
Us2BTjjIl/YOr08JePu86D1oJpEsfW4ROow+2Ly93/oiWBbTOKmIIwsP+eKIWphA
GuITMBYf4w2ctnMtuNN9AWJ45GJZo+sCsYWxYKL5iSb3O5lAXcbLBxcV1OFGh3zh
e/vCIQKxUnG/LFTxbqFGlt1XrDsQUbzFtagUw0NMQ9FxEYsuXVE=
=Bl0W
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

