Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A0DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6209207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Cm4xCDX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6209207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEWr-0006Vv-Uc
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kBEVB-0005J1-7t; Thu, 27 Aug 2020 05:47:25 -0400
Received: from ozlabs.org ([203.11.71.1]:55659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kBEV8-0006L3-6U; Thu, 27 Aug 2020 05:47:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BcdDc340wz9sRK; Thu, 27 Aug 2020 19:47:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598521632;
 bh=QbA8mg9xBSfBz7qPdjGJ/kb5wX1Q8jhV0L/unsNjgQI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cm4xCDX+fnNt90Ok8LPzlHf3E8eZjIMEFPBPKSEii6CO/ckS7yUKVZzhgVdR9vdPn
 jMW3RD/NDIL8a/IqfdQJuaktbeMOm+DP7zvy5DViG/PDCZxULylfImHS+2v59ffSCi
 lFLsdy1zSLm8eFmVCHB+do+BMIH8kYmb1moHulcY=
Date: Thu, 27 Aug 2020 10:01:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 7/8] ppce500: Use TYPE_PPC_E500_PCI_BRIDGE constant
Message-ID: <20200827000124.GB2014948@yekko.fritz.box>
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-8-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20200826184334.4120620-8-ehabkost@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:47:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 02:43:33PM -0400, Eduardo Habkost wrote:
> This will make future conversion to use OBJECT_DECLARE* easier.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/pci-host/ppce500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index d71072731d..1a62b2f8cc 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -509,7 +509,7 @@ static void e500_host_bridge_class_init(ObjectClass *=
klass, void *data)
>  }
> =20
>  static const TypeInfo e500_host_bridge_info =3D {
> -    .name          =3D "e500-host-bridge",
> +    .name          =3D TYPE_PPC_E500_PCI_BRIDGE,
>      .parent        =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(PPCE500PCIBridgeState),
>      .class_init    =3D e500_host_bridge_class_init,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9G99QACgkQbDjKyiDZ
s5LRiBAA0MBfVnlruBvn3xZqQIeRkqVvchHCBZ12nd2fA7Gzr0GGXaPdEXIsuWX9
ilVO8vYo6ZRkEA8BJIQCgplmhwNZBJpFmMMrz2Ci1gX1cKlMjkA+t9KRn4Ls/qbO
zgAO5zA/8A6yylydPhGY9dbTKG7dnPvNLa1g1WKJ66kjG8+V1m228hQqugAfng+o
hNVop6hzwvFJjac9TSmEvcOkgjuB+to2p+c7vLBdqzYsjNe+SEcNr7aDTdwBMFEI
codkAdMD5yHm+LlHnggromz4XywSqsjRuxnd+dNVqeZrgcfde+gh8uvS7PX7f5iY
Oq6CWkUK8ZsLH8rvt/qauAS/l24zQNOI5BP/y/RqtrzK8epuOcUBS7tvs0MMif2x
IMHj138TJvYZk2QneZEUF6rvzvrkPTTiqxvMCO8N3yhLcqcBhpYMz8nbSSjIzyVN
v6zLXsfZfdOebBQwxXWIHHkRzKxP2g28jyDuv8xXyCIreAfhuBD1CAbf5wrYkkgJ
am/FvqQeTtJPqdPoF5gMgWaBQhonhdQv7FVPZtNdVmjiW7S3SRoJ8XxmqYPBGsOE
AIOMTc3AQwA61Tv0THsKQHnxbYG7BYKMb8dALWCc0khL3M28Xp58U7NfOyogwdx4
eP3a4AmaUSp5DPplHeqIcZht7FBCBUG4oIMED+pcIWM9VkOYpY8=
=IzUu
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

