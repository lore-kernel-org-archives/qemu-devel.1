Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D987EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 06:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1FE20715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 06:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n5UGTENX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1FE20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaZjT-000729-ON
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 02:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jaZha-0004sS-PQ; Mon, 18 May 2020 02:56:42 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jaZhY-00073z-7x; Mon, 18 May 2020 02:56:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49QVDC3PqXz9sTM; Mon, 18 May 2020 16:56:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589784987;
 bh=R7UVpPR2KQeqoDFP+JeYr94f7uqII0ciRLjxpn+6Gqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n5UGTENXnmM4HY4qJMzmefnYSMyKJhFRmo78EVeNzCK4PCuqrrWG8QUF4SHTBy10J
 kgQ+aYAlLfqeVMPyBQLPLHkASkdqPTNGcb4YQaTHsZ0t6FjrpTHmjA6beijHhZ5cFF
 2QXre7fAICusJfGUlmN027O7dqZiVPyHhRhgisR0=
Date: Mon, 18 May 2020 16:41:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 12/24] MAINTAINERS: Make section PowerNV cover
 pci-host/pnv* as well
Message-ID: <20200518064109.GA49185@umbus.fritz.box>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-13-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200518050408.4579-13-armbru@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 07:03:56AM +0200, Markus Armbruster wrote:
> Cc: C=E9dric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47ef3139e6..074dc7f023 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1207,7 +1207,9 @@ S: Maintained
>  F: hw/ppc/pnv*
>  F: hw/intc/pnv*
>  F: hw/intc/xics_pnv.c
> +F: hw/pci-host/pnv*
>  F: include/hw/ppc/pnv*
> +F: include/hw/pci-host/pnv*
>  F: pc-bios/skiboot.lid
>  F: tests/qtest/pnv*
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7CLgIACgkQbDjKyiDZ
s5Jwug/+I+LR4HXBDciDgvXywXRCqd23WcgppaLg++n5R6R4Ioa5qv2lKMh6Cuf+
PBpCYdxPfQ8bxTHAbgDPMCADWQR5Evm28/I5Zjw1Sj3UB8lE/Hn4YUekkWtgYlJQ
1O7co89ZQip2Un8e8fJL5+p2faq6vOBr0zkNy6JhcBd9zPQOErnN7G5EomDnazbV
0VIhd9/Z/s3ePYhhVqei4MDOLjtKrB7WRiiR8rf32VDuaLIqdXFtUsxoFR6Rsr/D
zboelyc/w8zz8lrU2ZX2oS/djq7QPG66BZXQPv9wCdnITGbpBE2zyA8Nbn7upeHK
ZVHjbTVfJBGtRQOE37AJ7NdBwiZLdXheBrRUPqQvmnCMOGawXLk/JQdIXWH9E/k7
+xX0jq+4p8xTVglkmJ1hSoGZ0JHEEq6iaO1HbSXiiBrfDLJGZYhtVq58E3RK3ktY
uxGdmz++3Aj472Dc/iG4t8A/VDQKG7R5NJSC9Fiis4fFtFsywIUx5o5JkYWDQVG4
heGjjdROodtf0OBX+WdtG+VVp/Q0Cdo3sLJ6OgD+geQdWWbeNnbMpCDCfi38YHG4
y5+wIyM1lycA9uGU8RDsw95Yz/9lT2AQp+yV38Rjshrs1NUp0dsVPf4wrBfADn8V
NSkriLgNWJuKXNJgUWcswhygBNs9czzz4EXqnOhU6ioI1u57zaE=
=8B3Y
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

