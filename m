Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE347C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 01:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594B820707
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 01:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YzUo+KFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594B820707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDHSu-0001iN-FF
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 21:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDHRb-0000Ic-QC; Tue, 01 Sep 2020 21:20:11 -0400
Received: from ozlabs.org ([203.11.71.1]:45701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDHRZ-00033y-9g; Tue, 01 Sep 2020 21:20:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bh5hg4WR6z9sVB; Wed,  2 Sep 2020 11:20:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599009603;
 bh=2cYAGQ2lNa6gMCGD9qDWp1XaH9iLwnixTvAlsiyhYhc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YzUo+KFQJzudPzGE6ztsrWURVDJYCf62L8nOfMIOPWpJl59y2JrRaR8Cs8xwrodHx
 D1iEGe10M0KNFKvaKsNUxrW9PeDb0AbTnwhW0aULG6KD3ye4dR5JMuD58qv15MZ7YH
 v2kaVRc5VITOqTqlMID2bs5oTa/BhfmhF7OdB150=
Date: Wed, 2 Sep 2020 11:17:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 4/5] hw/ppc/ppc4xx_pci: Replace pointless warning by
 assert()
Message-ID: <20200902011708.GE1897@yekko.fritz.box>
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <20200901104043.91383-5-f4bug@amsat.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 21:20:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 12:40:42PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We call pci_register_root_bus() to register 4 IRQs with the
> ppc4xx_pci_set_irq() handler. As it can only be called with
> values in the [0-4[ range, replace the pointless warning by
> an assert().
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc4xx_pci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index cd3f192a138..503ef46b39a 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -256,10 +256,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq=
_num, int level)
>      qemu_irq *pci_irqs =3D opaque;
> =20
>      trace_ppc4xx_pci_set_irq(irq_num);
> -    if (irq_num < 0) {
> -        fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
> -        return;
> -    }
> +    assert(irq_num >=3D 0);
>      qemu_set_irq(pci_irqs[irq_num], level);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9O8pQACgkQbDjKyiDZ
s5KJww/8DJKc+Z8Cyw/JmqNHIWsPxtWYOpEure+y3N/0w8qmxlWWupDbGGgynPqe
Ry2eZR7tEMap4X7qGOUGxvv4MvIVlqqOIrgWXnWgXWK+C2KR9qJm/rXuH0U4wuqr
L9h2kKAN1ppF1UBAVjZSf9BFA7XiLnWwJqDZC22ad4jJkztWnwVifoQa1E1J6Uy0
4WfG3yRfk5ESsN/HBn+mi2UdV7iv3bm8aQUA7mFMPT1r/V7u816z0i/u/mPPRRBL
WSUPOYiucE+kSAxL2QNHNFgQ8ZxqE9QBhiF+qxu8ZVwwbhYjI0AoC5jGkhVcSAU0
XCa2AkpPC9YM1Z6LyEsXbE8BorUZGZ321ZaR3DQFFhZlHITzzyUjauGE6dTbk65l
/J3+yg2GNVMQmjg+8ANmPd/vQtcgsCl27qZjVRudlJXxGJu9zR0nAMMo2XAWlMUq
shAxQge4LFK/zd4YoM9l9RJl47tpkAp+ZP8BloVyKGGqVeIOU6zN4zdkOQ4b2wLJ
txvdfts+Alx5k1myRawpJRkE8ypuy9cVTk8ADdLxR6Cq/CHRq0teSKoD31+q1y2S
ryVDy3lgUeaSyQqHV6MXVvVjM5F3aG3sa/nWko1QHtlNC0c0u/S4Buz3gnKDQ921
+eNNmFTt5tGtx7G3tq3OVBgZLv9Pjn6op3DGnXwp3JTnCczaDT0=
=A0Tt
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--

