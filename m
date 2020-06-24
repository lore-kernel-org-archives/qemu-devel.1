Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552F82078E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WmNHOnpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552F82078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joFHx-00071j-KU
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joFHB-0006YA-4P; Wed, 24 Jun 2020 19:57:57 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joFH6-0005om-Pe; Wed, 24 Jun 2020 19:57:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49sg7Z2q8Dz9sSJ; Thu, 25 Jun 2020 09:57:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593043066;
 bh=12SKb6jH9jIYr/S4C6HT0G6nynuue0FDaWRhRv+cjdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WmNHOnpoZ/QsKHhzpZ9LL59O9sagB3zZqM4xIQ9+p35H3RCQujIoxQ5I1t1ecMrHY
 ShAC8P1lN5mj5CPqiJEE3EV+0M2+utHNw3EqsRvpQn8nGLco7Dh5LLUISExaK7n1Mq
 esd3Bl6mRO6qDdihXxT7zPaIg6KKn9Iapo2TBRjY=
Date: Thu, 25 Jun 2020 09:54:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/46] macio: Tidy up error handling in
 macio_newworld_realize()
Message-ID: <20200624235404.GA69292@umbus.fritz.box>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20200624164344.3778251-5-armbru@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 06:43:02PM +0200, Markus Armbruster wrote:
> macio_newworld_realize() effectively ignores ns->gpio realization
> errors, leaking the Error object.  Fortunately, macio_gpio_realize()
> can't actually fail.  Tidy up.
>=20
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/misc/macio/macio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 7cfe357cc4..bedf10e77b 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -329,7 +329,9 @@ static void macio_newworld_realize(PCIDevice *d, Erro=
r **errp)
>                                   &error_abort);
>          memory_region_add_subregion(&s->bar, 0x50,
>                                      sysbus_mmio_get_region(sysbus_dev, 0=
));
> -        qdev_realize(DEVICE(&ns->gpio), BUS(&s->macio_bus), &err);
> +        if (!qdev_realize(DEVICE(&ns->gpio), BUS(&s->macio_bus), errp)) {
> +            return;
> +        }
> =20
>          /* PMU */
>          object_initialize_child(OBJECT(s), "pmu", &s->pmu, TYPE_VIA_PMU);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7z55kACgkQbDjKyiDZ
s5IoJQ//Vew1DK+VFsP5JXc6B8+P+xqU/SCn7tc+Qiz42gtH+4CK8NNCJgHG7Ras
J/uBNB2TxXYf5c30M5gfmeztcNzMrGPj/abf8Ly3dUvmkFbRJRvhrvxjo2erND7F
XOx8kSdJE8jizqKoJVoUm7Bdg1BI0V7SiWUVxfOxIo/RQHM8maUggaXMLxBxAN86
gM5orQoTFnjIKGcjnePL4ue9RAPYZ2+wIarWe3BqDmbC2P+M3rgXaY6m0XjrkaSY
GHu57W/nz2udYhu446rSjqhxVNwg2OtqNrZHkyOcOkvHViU40mE7PIrJ+5VPZnEb
DNn3x6+g77K8Gphc/443VwODDYmJhJ7agHinpW3h8cc4iU3EILBaRfQyf8y1cNYg
BG2yAjmZwhULYLNot9Kp7VfwuMIoqU0A1setHBiAZpuSYZG5kRfj0GPRLBRl75oN
lnZaUK3IKKDWvlq55jA5dZO4s855pe/pz/XBF78wBVZVf7ScFGm1U8r3acSqs+aP
YJ9i0cK7fi9DhJpSS/l9xJBht5+kAt/MGuPVJWdF9Az+3+r+pRe02Hih84YjEO+C
Zdq3iFRgsmUSFk8KzXMFILsAOqScXmKU2YJxuEkSzae3/S5BCWxwvSCX3MZribNR
qiVGxEmjSBfTyY/zIZuVKRfvGdc2npoW/x9lH4njnXKWwMZb0FQ=
=O1ui
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

