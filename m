Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E24C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 13:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB0320720
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 13:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k/pNBXRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB0320720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9TQt-0000jm-KG
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 09:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k9TQG-0000D6-G5; Sat, 22 Aug 2020 09:19:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35401 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k9TQD-0004Ni-5w; Sat, 22 Aug 2020 09:19:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BYf931Q5Dz9sR4; Sat, 22 Aug 2020 23:18:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598102327;
 bh=Y3DRYZnn2s6Ka+1KikjFBfOwDVAsO5the78gL0Yo6WU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k/pNBXRYmozy9JWbSOYtX8HxWFNRGVgHEPA6mmfgXrNoST/vtpgWg9dM+76kQx/Na
 W7rt97g957CRDItohZSbXToE0XmqQ/FaCgQooQoxFTTKRXgdJHaNoEw3cc65yGriEH
 o6OZXzeJWE7lkl3UtrK7JUtLj/gQmuMTeTxTW9S4=
Date: Sat, 22 Aug 2020 23:18:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Fix TypeInfo of PnvLpcController abstract class
Message-ID: <20200822131837.GA4734@yekko.fritz.box>
References: <20200822083920.2668930-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20200822083920.2668930-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 09:18:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2020 at 10:39:20AM +0200, C=E9dric Le Goater wrote:
> It was missing the instance_size field.
>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.2, thanks.

> ---
>  hw/ppc/pnv_lpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index b5ffa48dac71..23f1e09492b1 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -646,7 +646,6 @@ static void pnv_lpc_power8_class_init(ObjectClass *kl=
ass, void *data)
>  static const TypeInfo pnv_lpc_power8_info =3D {
>      .name          =3D TYPE_PNV8_LPC,
>      .parent        =3D TYPE_PNV_LPC,
> -    .instance_size =3D sizeof(PnvLpcController),
>      .class_init    =3D pnv_lpc_power8_class_init,
>      .interfaces =3D (InterfaceInfo[]) {
>          { TYPE_PNV_XSCOM_INTERFACE },
> @@ -687,7 +686,6 @@ static void pnv_lpc_power9_class_init(ObjectClass *kl=
ass, void *data)
>  static const TypeInfo pnv_lpc_power9_info =3D {
>      .name          =3D TYPE_PNV9_LPC,
>      .parent        =3D TYPE_PNV_LPC,
> -    .instance_size =3D sizeof(PnvLpcController),
>      .class_init    =3D pnv_lpc_power9_class_init,
>  };
> =20
> @@ -768,6 +766,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
>  static const TypeInfo pnv_lpc_info =3D {
>      .name          =3D TYPE_PNV_LPC,
>      .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(PnvLpcController),
>      .class_init    =3D pnv_lpc_class_init,
>      .class_size    =3D sizeof(PnvLpcClass),
>      .abstract      =3D true,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9BGysACgkQbDjKyiDZ
s5IxJRAApV8JuFCu1GSvCis3McIBOwVBVfR1HRta1YQF97z15UgZZRIXll4WLF8u
UCMSqGum8relOdXvQ2oD/TBYIWVhYEuFx4lCRsien0CP88tvQOHH9maDlUBh1pbb
7PuH1BBQkpPD7mI0JDnI7qdEK23fhqM3SzE4EUy56VbWAhVxeEwTg5bQYWKa7dqa
hX7Co3byilg4vmgXKa6/VcVPcYVqYWY9mzg8kJwG3/9O2p3lOJwPZxC/1tNVUwkW
u9INDbL4G6EaVEcv8xYwGzJXgjXbl+PX8+DOOh13u7d1r6sjM7aX1FnCWfpbnofI
amyPuv78Lt/lq5yR7R1yjRvbgd0aJDBhhXYaO3BOfynl5EXlZfQVrILxuHiOLsog
oU+vNNSun+mrcVPx1aFmz9RmgqmSXFOpsgWn7tkHuu2XUZgbtC9EBebKBxtxqSdp
Hvg0fWis4OH3J7TPZDGguuK93tdUI5AViBtjBorkd7b1ZabMalzI311hSkrD/jYo
fGw+HLCdvrY5W08I15WxtDQpYWH8NqPUz4aSfKaidcdQDHVRZah3htUDhYckMLGJ
qA7qkjBscbtlDFpnfNA/DFHwuxl71ya8rlwGUIpeTZs59FpPcTkTDpycwUL/4kw/
HuCNwGchb4H7PJn8e7+6FQJnL+t0iHpthlAe/xC+uMp/atvtHTg=
=p4/f
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

