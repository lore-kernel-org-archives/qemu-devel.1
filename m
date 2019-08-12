Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9BC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B36220684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I9ja2WfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B36220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAo4-0001AF-TD
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmO-0006TG-Vz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmN-0008U9-EN
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47597 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxAmH-0008N3-8f; Mon, 12 Aug 2019 09:54:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 466cld4J7Lz9sNp; Mon, 12 Aug 2019 23:54:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565618061;
 bh=qytLL0vxyRiLP/+oym4HdH86cFiEx779GD6u63ggFbA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I9ja2WfO6cGDy61oVkeBXYf1udNV8UJTZPZKKBNXfgM94x+VQ+zqq+HLHwRioEahB
 u/JRiShyztzjGGfPkCNbkJnZqg4lXY2h+o94hVovIoSWq1yF5yZ8+3RM3t0zpseg5A
 arP5aXq6qFkOE0ztRLLU1Q+0+bwvKmG25UYb9Gyo=
Date: Mon, 12 Aug 2019 20:29:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190812102935.GJ3947@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-9-damien.hedde@greensocs.com>
 <20190731061108.GF2032@umbus.fritz.box>
 <CAFEAcA-dSBpAVfjn7VnCRgnZabBP226ZVuSJYW1bwzEr5mNktw@mail.gmail.com>
 <20190809055132.GT5465@umbus.fritz.box>
 <5ba72330-dbbc-fdae-d003-9f7d08ba4600@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <5ba72330-dbbc-fdae-d003-9f7d08ba4600@greensocs.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 08/33] Add function to control reset
 with gpio inputs
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 10:45:43AM +0200, Damien Hedde wrote:
>=20
>=20
> On 8/9/19 7:51 AM, David Gibson wrote:
> > On Wed, Aug 07, 2019 at 11:37:51AM +0100, Peter Maydell wrote:
> >> On Wed, 31 Jul 2019 at 07:33, David Gibson <david@gibson.dropbear.id.a=
u> wrote:
> >>>
> >>> On Mon, Jul 29, 2019 at 04:56:29PM +0200, Damien Hedde wrote:
> >>>> It adds the possibility to add 2 gpios to control the warm and cold =
reset.
> >>>> With theses ios, the reset can be maintained during some time.
> >>>> Each io is associated with a state to detect level changes.
> >>>>
> >>>> Vmstate subsections are also added to the existsing device_reset
> >>>> subsection.
> >>>
> >>> This doesn't seem like a thing that should be present on every single
> >>> DeviceState.
> >>
> >> It's a facility that's going to be useful to multiple different
> >> subclasses of DeviceState, so it seems to me cleaner to
> >> have base class support for the common feature rather than
> >> to reimplement it entirely from scratch in every subclass
> >> that wants it.
> >=20
> > Hm, I suppose so.  Would it really have to be from scratch, though?
> > Couldn't some suitable helper functions make adding such GPIOs to a
> > device pretty straightforward?
> >=20
>=20
> This patch does that. A device does have to use the helper to add the
> gpio. Either qdev_init_warm_reset_gpio(...) or
> qdev_init_cold_reset_gpio(...) , like any another gpio.

Ah, sorry, I misunderstood.

That seems ok then.

>=20
> The mechanics to control the reset with gpio change is done in the base
> class and there is some state pre-allocated (and associated vmstate
> description) to it.
>=20
> If that's a problem I can only provide helpers and let devices handle
> state allocation and vmstate addition.
>=20
> Damien
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RP48ACgkQbDjKyiDZ
s5I4uxAAuusYQL2ECKMDcmeQef6DRKKopUNpbEkJqNYlsxneveDDbkaH2VRVpVMe
hja+wWm+pT1tAdPlMKJM6nUwyOpUvsCBI2FhTn90MST9bT31lhHeozOnoj6TMWnY
OYtMyP9RPHS3ZvW3V1BeAj/xAOXmo9cTvd+WSD1KX639dTz1ZfiIUD1Q6qEC/P0g
t9tO82dUV09nQyCcteb2jWfnHReVeoOwIL1Oc5mZApIhKQ+rUILZ0vAXuhW0BlKu
27arS2IhGcCadra8nApvoo36KfwsfSziLQsYj0RjQxrN85bR1BsyyopResyK+FFX
MkgoK3W/zc4DeXnbCocA6AAkOyocilgdPFwwJ6UYQRJMx9KIljqcdUdPL8DpTDke
5aXKETbE0scojk4lCWgL02YgBzv+XFBk3SMPiZwfe1l8TMQQD+nIEpyyD3fBnm5m
RGzE3sD5hBKIzodpjx12fo+RMQvs/HJAH5e9YEMShldGNi64FKw1BIWOK3wkwJY3
BVfjlfh7VyXv1sPoigdZd/n+1lNDw+s5dNPg8F3BCfPIo4GpJ5Am8aSvGXvJ3Qnw
q50CCfZe4gLIsFyAnzODPt9nyHwjmTYpVIrqx3g9MNZg3boBrrKqPejHsI5WfR6S
n0yJfcSgXSpPw+BhLi4CJO6nsEOxs0hPe21r96d6S2bcPkM9VXE=
=GVlJ
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--

