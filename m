Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000ED207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ADLKSrw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000ED207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEXe-0007PM-9U
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kBEVB-0005J2-93; Thu, 27 Aug 2020 05:47:25 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34273 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kBEV8-0006L2-OY; Thu, 27 Aug 2020 05:47:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BcdDc1qRXz9sT6; Thu, 27 Aug 2020 19:47:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598521632;
 bh=m40uJQ8pPYmbdLq+RjHWh+7eqmyHtRDsUfPJRBDOnIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ADLKSrw6TcIVxh2x92NUpAzco75mwQIsaTFnVFyg0yqYL/uqAlBPMhziNlgQ73GV5
 EcOuv5Z3J/IE5IZVwS60Y3Gf6LeaK3B6UzsNDgserJUEAIMKyPGBXbE5GFKOOb8SUW
 O28tYrHzjCuzhbqOVUNi8//IA7z3XJpMuIskCDWw=
Date: Thu, 27 Aug 2020 10:01:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/8] etsec: Use TYPE_ETSEC_COMMON constant
Message-ID: <20200827000103.GA2014948@yekko.fritz.box>
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20200826184334.4120620-2-ehabkost@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
 Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 02:43:27PM -0400, Eduardo Habkost wrote:
> This will make future conversion to use OBJECT_DECLARE* easier.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/net/fsl_etsec/etsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 7035cf4eb9..ad20b22cdd 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -430,7 +430,7 @@ static void etsec_class_init(ObjectClass *klass, void=
 *data)
>  }
> =20
>  static TypeInfo etsec_info =3D {
> -    .name                  =3D "eTSEC",
> +    .name                  =3D TYPE_ETSEC_COMMON,
>      .parent                =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size         =3D sizeof(eTSEC),
>      .class_init            =3D etsec_class_init,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9G974ACgkQbDjKyiDZ
s5KOqA//Uke9r+tjNRUIhRnwdZ+QXAbapf/tmUo1hlqUhEyn8NRGENGQdktjUb1z
G72fKNrWm5x8xf8ZSc3JnVZBMUWscQVPefI8x1aSwbAqz0MNm/bdXZUVLDrDCGrs
5/70cSwGvGNA/8+Y3iobsvgIiq9EezcffMHXwvOqvA16mMm0wbsP2NpqV7at05R/
LDBePEnmHjHwPIw7211Dl/CWCnQ0S0iwAFXX1P0UYuZj77ZmTp3iUNN+gAH1nckT
2bAGRWoMC+53M8uF0g/5LiCYKgGfeUbwHpweE67Ew/OlNwDSy3Kcxjvi7l3lPeKo
r4vC5u+8SpTmviT6YHKMH+7zVVqrLHD6ANby9QRZxgN4lfLvV2tOvMuHoeb8eEe1
19J0QpExqfmyeygnu9por/jHx6VfcAeKn0h+pISryi3btllkq104oO1I3Hp66IHg
RHS2Wgmtj1NGG4+RAmG3EgIZTq2cFgucffX/Qq9xsi4JukGrbUO/mgxqCY5PqyI2
+JjtkBbnDqD2+CnXVQmDpUCBs2EqUfYlHH6sijrRcgclobOooGhUx/inSdy1VsDT
KGU/ofxfducwsknEFQLwu5k3S5idT5Ev9I7ZK69x5Xht42lOMpQWMElx7nS2mkWq
/rw4U9XBcd6GEYHPRIoxFbmeP/eySuB2MzNyGHQvTY6vMknx5uo=
=0kGi
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

