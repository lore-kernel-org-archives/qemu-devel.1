Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF5C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8197620B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e43CfWd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8197620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbGeN-0006dd-P5
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 23:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc6-00055C-6X
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc3-0006mw-Rb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33661 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbGc2-0006hX-8o; Wed, 12 Jun 2019 23:41:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45PTzp3rfmz9sN4; Thu, 13 Jun 2019 13:41:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560397270;
 bh=e2x1u5hIFyuqrCFcE7rizlPFlzY5I35FnCLFRgYGkFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e43CfWd9gxKf9dGbeSlUo2cbRlqahMqVpGt4za4pIBP/gceJjhZ2L4XJitUvXh0xT
 rhxnAjXlm9kBeaMvSf4IEJq2OK4ujKGkeb0TYyn+ix//3tc1opGoqRlEMG3UhBFKDR
 FbkxIbCoeXp0Yy+MDmO8N5GkbLnSm0ipNp7SkuXI=
Date: Thu, 13 Jun 2019 10:00:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190613000013.GA18900@umbus.fritz.box>
References: <20190612162357.29566-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20190612162357.29566-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix StoreEOI activation
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


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 06:23:57PM +0200, C=E9dric Le Goater wrote:
> The firmware (skiboot) of the PowerNV machines can configure the XIVE
> interrupt controller to activate StoreEOI on the ESB pages of the
> interrupts. This feature lets software do an EOI with a store instead
> of a load. It is not activated today on P9 for rare race condition
> issues but it should be on future processors.
>=20
> Nevertheless, QEMU has a model for StoreEOI which can be used today by
> experimental firmwares. But, the use of object_property_set_int() in
> the PnvXive model is incorrect and crashes QEMU. Replace it with a
> direct access to the ESB flags of the XiveSource object modeling the
> internal sources of the interrupt controller.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/pnv_xive.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index bb0877cbdf3b..12c91adcd27e 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -780,8 +780,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwadd=
r offset,
>           * support recently though)
>           */
>          if (val & (VC_SBC_CONF_CPLX_CIST | VC_SBC_CONF_CIST_BOTH)) {
> -            object_property_set_int(OBJECT(&xive->ipi_source),
> -                                    XIVE_SRC_STORE_EOI, "flags", &error_=
fatal);
> +            xive->ipi_source.esb_flags |=3D XIVE_SRC_STORE_EOI;
>          }
>          break;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Bkg0ACgkQbDjKyiDZ
s5LfmxAAjewPM2CLcYL7SReOkFGUhfX4GpmFhycxyiwF8YkNdycjxSqMi5lkcz93
oEx3LaCKzeZlNxonE9NIJ9evVNFwbKyYDVbllNBQ8SZEwkAmoEs2WzO2biTK4U0o
8s7u8/sxRsdZdkvnG3TMRLA7LapPfOZwhvEMuyv01nR+sQTFne38BnyqXGLajnmF
Rsga+ONArK0W5bOAJX9obnTI4jgFqaZ5kNyGGj3fhFMkPpAhEV/sGAi5zu6+veL8
nGIyUkAsvsB8WMEqsF9aqvflWMz9a1bdKJP25zSttq8mVVwLtUSpw0VBt0AXGViQ
28nIV7RZ2y4JfOhsDJr6DjPB7RzEGxy7P/wykeKMKwcWGW7RDCOre3kOik5Fjs/Z
uNQyZ488130RLyKS9r54wYOvWSlljtB1LsNZLR0NpZUHrruK4Q5XgFxNBA1jdlBZ
2mLLbw3WOOvzlXJoWKp/ipREoQYHptmHTRkfT1WzFyztCQSF2stPkqjE+cAJe3Nn
SotUo+baX2I4V57R3a9JexmaDorbo+tEkP+wrz6G09zJrPbSU0T0dXlgYuINLSco
6w2Tyu/TH9KpS+zX9np09fZgRV5YBA8qksK9HUGTUfMWyfGtKmjIMfMMUO9mOYif
bTRRNRJ5le0KnIhaYfKZaGyYPb/KDzOYW6pyxIbe6uXP+DrF7ZE=
=9JGy
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

