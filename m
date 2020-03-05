Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71422C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371F92073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 23:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e8Uoeyy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371F92073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0Ho-0000hI-Ci
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 18:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jA0FN-0004Kg-SQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jA0FL-0008Ve-3P
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 18:49:45 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51237 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jA0FK-0008Sl-7R; Thu, 05 Mar 2020 18:49:43 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48YSCP60R4z9sSH; Fri,  6 Mar 2020 10:49:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583452177;
 bh=yYtzOY74Eu3HoeDugJiwp8UpmChrJ+jSLpVls5DKAPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e8Uoeyy+0QpG2euO5ybOiSCj8cPvLMA+YPkoJmrniJzX1Aia/IGX7S+bJzStelsJG
 Xly52DFyKqghGU7C4kj5MsRaF/ElQ0I4ZybwuDrLtHuWBpOjtpI8sE9bOr96nTtAJx
 sFNzypMm7JA0zhjNWOUojdBYYdTXxtVZWf+SMIg0=
Date: Fri, 6 Mar 2020 09:56:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v4 3/3] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
Message-ID: <20200305225652.GA617846@umbus.fritz.box>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-4-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20200305065422.12707-4-pannengyuan@huawei.com>
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 02:54:22PM +0800, Pan Nengyuan wrote:
> There are some memleaks when we call 'device_list_properties'. This patch=
 move timer_new from init into realize to fix it.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Applied to ppc-for-5.0.

Probably the memory region stuff should be in realize() rather than
init() as well, but that can be fixed later.

> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> ---
> v2->v1:
> - no changes in this patch.
> v3->v2:
> - remove null check in reset, and add calls to mos6522_realize() in mac_v=
ia_realize to make this move to be valid.
> v4->v3:
> - split patch into two, this patch fix the memleaks.
> ---
>  hw/misc/mos6522.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 19e154b870..c1cd154a84 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -485,6 +485,11 @@ static void mos6522_init(Object *obj)
>      for (i =3D 0; i < ARRAY_SIZE(s->timers); i++) {
>          s->timers[i].index =3D i;
>      }
> +}
> +
> +static void mos6522_realize(DeviceState *dev, Error **errp)
> +{
> +    MOS6522State *s =3D MOS6522(dev);
> =20
>      s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_time=
r1, s);
>      s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_time=
r2, s);
> @@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void =
*data)
> =20
>      dc->reset =3D mos6522_reset;
>      dc->vmsd =3D &vmstate_mos6522;
> +    dc->realize =3D mos6522_realize;
>      device_class_set_props(dc, mos6522_properties);
>      mdc->parent_reset =3D dc->reset;
>      mdc->set_sr_int =3D mos6522_set_sr_int;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5hg7QACgkQbDjKyiDZ
s5JGJBAAiMQnaPeOfWGhvc4C4s0LKnpkxUPMcVCMwfrqReam190DigXZZJrr3la5
7ySM3ge4PV1UXUHGOYvPA8i8/qGljCbmO9cvu0xUZuhfgZpXQKmcUPkX/S5Cgf+5
YqevK6UkmMU3DomO4rfppEpdbkwJJq9rHVNkK+5aTruoSaW1Mkw7r22m8p93iAII
cvk9q13mNhnpa/b8uHY1XcME2iH78H+Y65snankBVxXDQ5VRmFZP92R1lwpmua6P
C94LNqn6WuAcA5c7A73sG65NoJSUU8bET/DyCMShZZO2i7WBbUr0m6NCxMq1Keux
A5Bi3MFc9h4vizGnMHQT0KvVbij/Ey/8jo/A/CWQuCTD2/F43tu9LajrjJxrk+XS
0nRTs/07ET1dKXRdHaKqLUYPvdgFAQ5VCuSCg9Jjfbf9MUG5SF8PYbmWIQmJdApv
p1olyz3YU/edUvye21InfUEJ31ZQcWYAUhicfEbXHwC+iK3ZqA1E/cXzrZJKViI1
s3Koa83S6PFiSXO9yaGOiCv0HlAbZCMYh5ZZsKmgIdDFtFdxfoHTy6iWEbqQg5Zq
O8pZ/N1WMtTvml6zxE7D3jmW7HzVqbvpS6RsExegUnTFuYvn0W6Ai+DtW+ab3iLh
IwRBhD/Bm6gjANBhA03Nn5goysXEltdYFOJsUCKVoDE5C+jKNq4=
=n8Cz
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

