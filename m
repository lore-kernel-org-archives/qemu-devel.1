Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C64C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BC922267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MBcpkj0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BC922267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVS5x-0006QV-Vu
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 00:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2v-0003DL-H0; Thu, 22 Oct 2020 00:17:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58677 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2s-0000Eh-Az; Thu, 22 Oct 2020 00:17:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CGvGP2PMTz9sTt; Thu, 22 Oct 2020 15:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603340253;
 bh=3FEdsWkuEBEu/YbMBMtwwMLmFe8Ep/66aPDpncMaCos=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MBcpkj0jDewF+vvhY4JtiLkfwXQrONjdq9690wEvlHU4pxVIjbLzctTvrrI4QZiTR
 TtI8yfzp2HFiimYOMBGkD8G5mSdWk2ughn6lvnl9Z6rmXmvh3vAOLj/V5x4K4cYJ9C
 MOoGRQ0Judj34jUlK4vZXSb133dshvSHvK4gdvj4=
Date: Thu, 22 Oct 2020 15:07:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/5] spapr: Use appropriate getter for PC_DIMM_ADDR_PROP
Message-ID: <20201022040731.GE1821515@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309729609.2739814.4996614957953215591.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <160309729609.2739814.4996614957953215591.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:17:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 10:48:16AM +0200, Greg Kurz wrote:
> The PC_DIMM_ADDR_PROP property is defined as:
>=20
>     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
>=20
> Use object_property_get_uint() instead of object_property_get_int().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4edd31b86915..115fc52e3b06 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3572,8 +3572,8 @@ static SpaprDimmState *spapr_recover_pending_dimm_s=
tate(SpaprMachineState *ms,
>      uint64_t addr_start, addr;
>      int i;
> =20
> -    addr_start =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PR=
OP,
> -                                         &error_abort);
> +    addr_start =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_P=
ROP,
> +                                          &error_abort);
> =20
>      addr =3D addr_start;
>      for (i =3D 0; i < nr_lmbs; i++) {
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+RBYMACgkQbDjKyiDZ
s5I7/A/+KMixAmLnq0fILvZCdYto8twfp/hiH9UXSSlhF+H5pEx2yrXJJFDKAhFZ
bls+RRG8o72LSJlGVnR+u/RwqJZuKs6DOMUWblrHHvqMTwRdkZ85PwmgZa2egJc6
zZO2GqsWHfeYaO7XcaBMa0qpHYYA1WVenvDL84Sz4UUW2v4n3CYPEUxXOZRX0LY8
4qzFMWIX0DzJedYvVT3AKK5UbKONKBfvZ7pWA5MlDVMU1H67rR34lgNG/pepPtcR
+YsKa6kQL7hhUKfAMFhJMnY7Qj8qp/eHJDij74eTPcQ67sIl6iU/Vc7pIBj4BfvY
ynuAo8atKOHXVXZqlHy+TuXJWTsF+IOuIQI9trPqWBp8IPARQ7M7W2PYnlMa9N4K
jUc/kF1iZKG7Z/4kzW12c3SBSxOBao7bIdjSZCX2UyH3CVOb+DcOa82MpYWMAWEa
MSJbk2bKlHKgBeiIDF6BOUAipSFDj02J9CFPrGLx5x4a9WMyKS8ly5eMsk/TTWPd
Nivryv4G/ZZAtbjfQmGEuT8JBBwnP011FleRUxdZnV6Wo3QbUNfi8KgzGBOUjBCB
2g9TGUMxtxlwgfcLbOlHESVFt8j+ZS050myeoaMybWqcODOPi/hfjneHkFpf/CGC
Y+qL3aNVMOSz+PyMLWdNnQfyNajEoiQ6iaSOlOiDoYGQA8RNCnk=
=W8N+
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--

