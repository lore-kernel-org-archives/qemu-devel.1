Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5929DC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 01:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193F820707
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 01:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZAgoIYin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193F820707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDHSq-0001ff-Tt
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 21:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDHRb-0000Id-Sj; Tue, 01 Sep 2020 21:20:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49455 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDHRZ-00033x-Bd; Tue, 01 Sep 2020 21:20:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bh5hg40RFz9sVC; Wed,  2 Sep 2020 11:20:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599009603;
 bh=/0Fr68ZLatqgPD2Ci5FuiRZsFR3bvwm+hPOl1XlWBAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZAgoIYin2FAgD8kDjGTHbFHdDuMhJgdVBFQ+bzAn51/ITDYmtYGfIsc5pULCHDBZd
 WdU8cfGVz/Gjy3tGzNAyOY9jIUYJamfBnBFCtKOYzUROO/J7yV3yFGF/MPKt7xlV9k
 za6bpwg0LuuwzBMWQEnerH+RfCT8x7nm/wDs14ag=
Date: Wed, 2 Sep 2020 11:16:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 3/5] hw/ppc/ppc4xx_pci: Use ARRAY_SIZE() instead of magic
 value
Message-ID: <20200902011646.GD1897@yekko.fritz.box>
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20200901104043.91383-4-f4bug@amsat.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 12:40:41PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Replace the magic '4' by ARRAY_SIZE(s->irq) which is more explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc4xx_pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 3ea47df71fe..cd3f192a138 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -320,7 +320,8 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, =
Error **errp)
> =20
>      b =3D pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
>                                ppc4xx_pci_map_irq, s->irq, get_system_mem=
ory(),
> -                              get_system_io(), 0, 4, TYPE_PCI_BUS);
> +                              get_system_io(), 0, ARRAY_SIZE(s->irq),
> +                              TYPE_PCI_BUS);
>      h->bus =3D b;
> =20
>      pci_create_simple(b, 0, "ppc4xx-host-bridge");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9O8nwACgkQbDjKyiDZ
s5ISdw/+Ni8dI57O4f+4QVXKXRlk4CHa6MGCPttZD3sTvlp/gmvUUUu+cD4exKck
gQWqpH3+mYZxILRI8bk0Ep6D2lGGgwvbLIQjN6WbDbX8arLgQ/BZqgQtDutD9Ugb
+CUIaQxP9ewl15HIz7jM00dkwESUpdeigbbAp2wp8WUFLzASjvyooiI5OTfrYL3I
ZpS14gpYSI4A2ULLLKgSTA5hzEmdLULA1EXhKeaqTgrn2jBSJxUyB2xGh4fhSOeW
uG4whEF61bjjFzpHA9daeT2cZfHnLF5KHpnySnj5cB5nqGOkg050DfmQ2rRvkRr+
rOWJAbNZ61G2+Rfch1T/AmcgwiCmaHtF4+Y2qIN3NOeNymoPOInjJnXxUz+KDdRb
VeSc5ZSBIfMgTCBcXYdOi29fIt6wrqB1eeaB5MLC74SmihDMDNRinvQfH1Ii7Mxm
JgXU/QfBBwnzbxehyV3OzzxrLKMa2013cTGTQ+X0qmkxoNwsNG8txmurMzcGHCBc
zldTFFC/08F+IjzVrGj+p/b3CtCB+JAGCT7wfFLRMkzyupDgDYOMd0+A1PrvLR83
d8E1g7HfsyAGDbEloYMGtfABpK2O7DSAFlSqF1jH5FH3fdf/hxRjDe+2PAtLv/6H
/oVtSUvYsygKNo+3JdZzYoGGrzT+UyoL68oBhr4m5z0krn/VC6U=
=ITJa
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--

