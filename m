Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3CFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D336206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iztjlJd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D336206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifER8-0003PE-Nl
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifEPW-0001yN-GG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifEPV-0006Bo-7m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:41:02 -0500
Received: from ozlabs.org ([203.11.71.1]:55815)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifEPT-00063F-3s; Wed, 11 Dec 2019 21:41:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YJ1h06v6z9sPL; Thu, 12 Dec 2019 13:40:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576118424;
 bh=riZsyX6OgK3RoWT+tm0DTBg5lzOpGLEa2vF3dvFemVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iztjlJd2aJKAgs6xZ8i5Wn9AtxWZbBftkdIf+cvs3bS09fxOfCL/W73ddCY+0BmYa
 btN5TrlqhOZJ5ausB4G1W1tqwrDrQtb8yesbfUQkzcgwBtQe7xm8Hu2VWpPCbDsWbF
 uTaN3Ms4qddutvZz186I+kCD8Pg8+svIPkU1akA4=
Date: Thu, 12 Dec 2019 11:37:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] ppc/pnv: Make PnvXScomInterface an incomplete type
Message-ID: <20191212003744.GS207300@umbus.fritz.box>
References: <157608025541.186670.1577861507610404326.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uNvczuo8OWfsyO2w"
Content-Disposition: inline
In-Reply-To: <157608025541.186670.1577861507610404326.stgit@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uNvczuo8OWfsyO2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 05:04:15PM +0100, Greg Kurz wrote:
> PnvXScomInterface is an interface instance. It should never be
> dereferenced. Drop the dummy type definition for extra safety,
> which is the common practice with QOM interfaces.
>=20
> While here also convert the bogus OBJECT_CHECK() to INTERFACE_CHECK().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
> v2: convert OBJECT_CHECK() to INTERFACE_CHECK()
> ---
>  include/hw/ppc/pnv_xscom.h |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 1c1d76bf9be5..306c22461587 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -22,13 +22,11 @@
> =20
>  #include "qom/object.h"
> =20
> -typedef struct PnvXScomInterface {
> -    Object parent;
> -} PnvXScomInterface;
> +typedef struct PnvXScomInterface PnvXScomInterface;
> =20
>  #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
>  #define PNV_XSCOM_INTERFACE(obj) \
> -     OBJECT_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
> +    INTERFACE_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
>  #define PNV_XSCOM_INTERFACE_CLASS(klass)                \
>      OBJECT_CLASS_CHECK(PnvXScomInterfaceClass, (klass), \
>                         TYPE_PNV_XSCOM_INTERFACE)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uNvczuo8OWfsyO2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3xi9gACgkQbDjKyiDZ
s5JePxAAt0ge78+2HBhSeGZc9LwlU76YsdxeqKZZXafE/SGHvjMmxE5kmq0z3u7u
zURlXCtP+s4e2V2Mw67eLSdCnZXY+S2r9y0dAu0Y53CpYsYtYoFpZgeV6NEc5P1U
rkZTLOHrW3+eEgPD3KueoXNFBTIv5zNNDQ9tuFhUJI4R+6AVHPxsr1mFq5BFvhkf
37ExZQ2c6NN83bZiaM1PRaD3TfrC7w5YJ9GXMsMsaksUG8s4ewBluB1X7MMIEMg1
clppA1ip6hNmnGGIFK7FEodd9LnpCYECSOONOIeOG6BtqUWd+Cn/aLar8yzyRUkg
fYRidwJVQ0YE3NpeLH25C4BQ7FlNvk7MoN5M/qndd0tsI71ClQ6NXlmQxtrJ/+vU
lNVIwsCtePuEeJSpjJ1UwQ5TPOxsIr5YCWQ+GkADboj9pMsdh4vHFoITSbLGlQSl
Fpr+S4pvHkpkzD4NNBEgOla7DS2fQZCLUrGxh4YsP58YGJtXkNvgkDttSmQ4Jdzq
3nOfq22qnpUJmcWnMIDKMXWQM9360UrTaO5ed1gWz1+KPfI36cFep8hlBMCgssYx
dT3Z5AG/nBSjwEkQoAT+67qbkkqUhgxu+/y3rI7uIIcKf0VSJqZQp4Mi1fUe8rSZ
2dae90A5KotZq4lCKev15Wu13NRKuzCzhxsLJ0Cy+CHN+AeHouk=
=nEcF
-----END PGP SIGNATURE-----

--uNvczuo8OWfsyO2w--

