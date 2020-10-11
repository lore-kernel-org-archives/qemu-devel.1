Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DF7C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 23:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1F7207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 23:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C+jm4iSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1F7207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRlCD-0001js-BB
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 19:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRlBU-0001Bi-QU; Sun, 11 Oct 2020 19:55:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRlBQ-0007rK-HJ; Sun, 11 Oct 2020 19:55:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C8dw74Ddxz9sTc; Mon, 12 Oct 2020 10:55:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602460503;
 bh=tl3553jy5atqaSpmLIyX+YPhno0a21nI5z2FCjopxsI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C+jm4iSIEbXrECqy7eNEulvEp4ZNI1O8FsKgdai09dEk7Tmv7w5Www5GakPRqTnaN
 dMr7vSTwNvPqKZbs2rAFtYiZBUkbAYRdmq59kMQ8Ba1/FCOUY7HmHjnUCvhFj49+8E
 0EX/VtHfcmRa4WUC3oAC0vcOxUtgWf2sR0nXHXv4=
Date: Mon, 12 Oct 2020 09:34:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
Message-ID: <20201011223446.GA4787@yekko.fritz.box>
References: <20201011190332.3189611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20201011190332.3189611-1-f4bug@amsat.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2020 at 09:03:32PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The Grackle PCI host model expects the interrupt controller
> being set, but does not verify it is present. Add a check to
> help developers using this model.

I don't think thaqt's very likely, but, sure, applied to ppc-for-5.2

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/pci-host/grackle.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 57c29b20afb..20361d215ca 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Error **=
errp)
>      GrackleState *s =3D GRACKLE_PCI_HOST_BRIDGE(dev);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
> =20
> +    if (!s->pic) {
> +        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link not =
set");
> +        return;
> +    }
>      phb->bus =3D pci_register_root_bus(dev, NULL,
>                                       pci_grackle_set_irq,
>                                       pci_grackle_map_irq,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+DiIUACgkQbDjKyiDZ
s5L9JRAAuLh2A++Bp8GEpjetjJ+TqJA9o6Zj3qTzafH6n+4b+pBPEG4njRYakuvk
XC+5Yg7aeDe8dWwyLj0VOeIXcfP5Sn7XLDmC7hvGE0Evl3di0UzVeZ+tODJ+U1DT
hRxaKRuB+Hrt6Fgs0sBHVfTFhiQiaGA6XigNWTiRpqyuKQEwJAkq86El9ku1rW67
RGWTh/EEc+Mf+M3j4Z/HvcAdM4vSFO/YzB37YaBMuXDwlR/k7KRRSSNx/XJ1Pgf4
GJjhU32VNT/hrKz/EbYI22wId3GiQXj9Ez7Y6SsKZv1ZIWTRndsUHpV5C/bKppf+
k3b7QEd1XDzIKCuFgZusJ5UQHsS6k9taoruunAR0qdBEbRQHpRmFfn7Moioz9YYo
qNnI9i3qpYI8FFWkWvcwMWP7a+os+y5ESE+aIJ1ppz0fVUjJlcfWPKur1ZbS38Mk
yBqW/3zbx6VB2iUdw8yVs/2jAiiJyrlLLuCoJInhnxiFLeqtmAKiZXqfPultz6wd
+PaKapWpMPJarYgeuLO7e9sd8dHvVcZ1WwxpSDColNHSlEM2ZwCqkSAeNdvSCGLv
x8TQqY0e4xgs7wiva5ktKLTEJOTixwXPzmacEscY3QkB8a51lduTg3TLIuU9u03L
TLkadFPja5v4AlMljRt+0Y0J5iNEs/wSO5IWw9NF4bdUNXxtKDk=
=rDEb
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

