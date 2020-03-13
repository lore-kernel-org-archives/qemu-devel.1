Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539BC4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9533E20746
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m9Ci+Qs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9533E20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCeAI-0003oX-Nz
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCe9b-000379-Cz
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCe9Z-0003B3-OK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:50:43 -0400
Received: from ozlabs.org ([203.11.71.1]:58943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCe9Y-00033J-Kk; Fri, 13 Mar 2020 02:50:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dxCw4Mq8z9sRN; Fri, 13 Mar 2020 17:50:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584082236;
 bh=+CQNCzPszlzFbywxD9b+ARZpp3aLxX1aagHS1bsP9jM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m9Ci+Qs1n5I1A6sMaIlkCOIJIKpi5+k5je5pUzBUldAZnAwmw++aBzkkO9YKNYQkz
 jOz0vIm9GCDUlMwmznT6H3NOHPjXjAmhXICLlpVcrsb8+qagJK6FJiD9EJH9Hch+v9
 wU2mb3YYcejtJk2RQeDBHNVoWN7O02PSemuj6NIs=
Date: Fri, 13 Mar 2020 17:50:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v4 3/3] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
Message-ID: <20200313065028.GF711223@umbus.fritz.box>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-4-pannengyuan@huawei.com>
 <20200305225652.GA617846@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
In-Reply-To: <20200305225652.GA617846@umbus.fritz.box>
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


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 09:56:52AM +1100, David Gibson wrote:
> On Thu, Mar 05, 2020 at 02:54:22PM +0800, Pan Nengyuan wrote:
> > There are some memleaks when we call 'device_list_properties'. This pat=
ch move timer_new from init into realize to fix it.
> >=20
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Applied to ppc-for-5.0.
>=20
> Probably the memory region stuff should be in realize() rather than
> init() as well, but that can be fixed later.

=2E...and removed again.  This causes SEGVs during make
check-qtest-ppc64.

>=20
> > ---
> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: qemu-ppc@nongnu.org
> > ---
> > v2->v1:
> > - no changes in this patch.
> > v3->v2:
> > - remove null check in reset, and add calls to mos6522_realize() in mac=
_via_realize to make this move to be valid.
> > v4->v3:
> > - split patch into two, this patch fix the memleaks.
> > ---
> >  hw/misc/mos6522.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> > index 19e154b870..c1cd154a84 100644
> > --- a/hw/misc/mos6522.c
> > +++ b/hw/misc/mos6522.c
> > @@ -485,6 +485,11 @@ static void mos6522_init(Object *obj)
> >      for (i =3D 0; i < ARRAY_SIZE(s->timers); i++) {
> >          s->timers[i].index =3D i;
> >      }
> > +}
> > +
> > +static void mos6522_realize(DeviceState *dev, Error **errp)
> > +{
> > +    MOS6522State *s =3D MOS6522(dev);
> > =20
> >      s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_ti=
mer1, s);
> >      s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_ti=
mer2, s);
> > @@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, voi=
d *data)
> > =20
> >      dc->reset =3D mos6522_reset;
> >      dc->vmsd =3D &vmstate_mos6522;
> > +    dc->realize =3D mos6522_realize;
> >      device_class_set_props(dc, mos6522_properties);
> >      mdc->parent_reset =3D dc->reset;
> >      mdc->set_sr_int =3D mos6522_set_sr_int;
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5rLTIACgkQbDjKyiDZ
s5KiMRAApJqwY0vAvLV0M9TYODXbYs8Tb9qwpoWlj5nXiXwWwDjQgchqbJbmn803
JWGGWxb8ufm/Gn/coH1QrXuoSy809Zpp3RwLbKeAyR9B+QUj8r258yLX0cpiLmO3
Gg33I2KAaP4x12T2cm13rEEsvkeST9C2xqxSvuzBbHBmugcW477K/m64N9giitxG
HwN7h5f5cQ6dw7UWf3rN/175DSh9YArJB2rWlmfwNgmSyKzi2wrae16KsTt/qZ32
xMrjQEPytqi+TV17UHwsSyO79vDoD6+UBzqseKhk8nBf51DFJqAKiMhs+oEFfBpn
0Cop7ENoherV0rnfIE/8LV+OH03cxtD5CIziZ+GsYIiygLV6X6kAQdx7pLgbbKR9
Tbt10rbFSUC083GcnmR3nbxikdmAeK0jSwRJe1VKNWjGm6U5QTUVIFRzpdc3FSXJ
h637w4HSyvRHk7+GTD68hdcW9X0buiO4JUmqRItNeWDp6Fv7QIB1mNwYba9CBCMO
4SqOc+O2vO7FW/axGkoFVqpnq4mfUA257buGPnNsqtXVOEOJxVPhOLy5nIg1ErOH
jFuefTY443Aha2OWfP+RJwCYXYM0QD6aeayLj084WwGGIVdz6tch0HFqvanA2rmn
m7Xw3cb6r/p+Ad8R48AYzXQ9QkGOqq76LX1z+nMKZwTlj6w0b1o=
=7fVu
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--

