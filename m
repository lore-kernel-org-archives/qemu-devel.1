Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C33C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DF320809
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ti+QSll+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF320809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGHOV-0006E2-Du
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGHNw-0005a4-GM; Thu, 10 Sep 2020 03:52:48 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60309 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGHNt-0008II-9o; Thu, 10 Sep 2020 03:52:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BnB1p3Vf4z9sTX; Thu, 10 Sep 2020 17:52:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599724350;
 bh=h/hA8wwXLn+3KtEgBuXIuDWls9QWPOpxG3nzh0aZbPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ti+QSll+aB63fml18Kq9IvJMCZH8eJuOP/sUmLyQrcmBpXPhsfI9BdTS1D3E/kxLY
 IprGF5m2R/1j26WO+6SOuvwulXASIb1p9KIZ+i9yHV24Ic6IEx+O+pL4a52C+V8G5D
 a2W6aiW7wkJ/XBWnpqsGSDMEK0H0TiQB47CyWTp0=
Date: Thu, 10 Sep 2020 17:43:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 2/2] hw/ppc/ppc4xx_pci: Replace magic value by the
 PCI_NUM_PINS definition
Message-ID: <20200910074314.GB66834@yekko.fritz.box>
References: <20200910072325.439344-1-f4bug@amsat.org>
 <20200910072325.439344-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20200910072325.439344-3-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 09:23:25AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Replace the magic '4' value by the PCI_NUM_PINS definition.
>=20
> Suggested-by: C=E9dric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc4xx_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 503ef46b39a..930be78361d 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -54,7 +54,7 @@ struct PPC4xxPCIState {
> =20
>      struct PCIMasterMap pmm[PPC4xx_PCI_NR_PMMS];
>      struct PCITargetMap ptm[PPC4xx_PCI_NR_PTMS];
> -    qemu_irq irq[4];
> +    qemu_irq irq[PCI_NUM_PINS];
> =20
>      MemoryRegion container;
>      MemoryRegion iomem;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9Z2RIACgkQbDjKyiDZ
s5LxFw//bMZAfGy1cHOROzZOgcQM1rWlQPbgH5n5PO+gFe9qA0VHbFIhC4HqUteH
OKcuKbgxBs7Fd0+mhMzcw7oxt/Osge+ihqE/vcc3xawcSedys2Nd/LrhyFITU8m5
G9abirP3i0SN7nXVMWMbEDLZ1noy4XBuIu8zFVJzC/MLUPAHe76IRsgnh8pq0ze1
dNiOpz9I25V5r1nIto07mUGgVsdiLz59Ppr48KSnhzIQ06pbpLNzoBCHmiMjqckr
knFQXsNht9kVA24IH2ve6RFz1DGnC6jXTba25AUgDAm4GCLFDbtZdT7eABFAqFqw
UV39zNYthe8CEPSRvKbnimVuuzBvGITT1XeJS4abyVcdbO4P4QtOJjzwd6BQiXRV
3c/lhISdoi1jqDjlv3JChibsjU+q886KMojtnUBo1HO8JwkAUfqqSyA9L6wg/17b
eu6Vu1XMJ+2O3OCxtQrUDwjHKPw59kueZ8SJJS9sxrMVA2eouFqKrzSX+mwrv9k7
rm/OLLINXZQtc7f1Y1H1iETttqXnkiafpBEh7kkVx/+F7Im3JeYTzP/T0Br5MhiF
qyKSuEIJmwks96VOT8L9kUByBxih9STXQKamWylXL+glphNeOrnwAIzphG3RWG/+
I+lh5UnSro8BKPXdOror7uSq+9szSRwL6d60FrD6tma3deG0aSY=
=u39l
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--

