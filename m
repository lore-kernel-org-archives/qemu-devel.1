Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79254C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2C021783
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkAB-0004zO-TW
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDjf1-0007Ok-Ib
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDjez-0004b6-FR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:23 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:59763)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDjez-0004Pg-56
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:21 -0400
Received: from player787.ha.ovh.net (unknown [10.108.54.72])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2409111AD1D
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 08:23:17 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id D1A93A63A8B2;
 Fri, 27 Sep 2019 06:23:06 +0000 (UTC)
Date: Fri, 27 Sep 2019 08:23:05 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190927082305.6df18660@bahia.lan>
In-Reply-To: <20190927055104.GG17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
 <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
 <20190926011336.GS17405@umbus>
 <92ce15dd-f7f9-3d2b-4226-9693bd9cfd65@kaod.org>
 <20190926173539.4a07d419@bahia.lan> <20190927055104.GG17405@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oNKWrqNaAuFvwIwmPZvL70+"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 12309745157198682598
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.46.122
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/oNKWrqNaAuFvwIwmPZvL70+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sep 2019 15:51:04 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 26, 2019 at 05:35:39PM +0200, Greg Kurz wrote:
> > On Thu, 26 Sep 2019 09:05:56 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> > > >>> +    if (spapr->irq->xive) {
> > > >>> +        uint32_t nr_servers =3D spapr_max_server_number(spapr);
> > > >>> +        DeviceState *dev;
> > > >>> +        int i;
> > > >>> +
> > > >>> +        dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> > > >>> +        qdev_prop_set_uint32(dev, "nr-irqs",
> > > >>> +                             spapr->irq->nr_xirqs + SPAPR_XIRQ_B=
ASE);
> > > >>> +        /*
> > > >>> +         * 8 XIVE END structures per CPU. One for each available
> > > >>> +         * priority
> > > >>> +         */
> > > >>> +        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> > > >>> +        qdev_init_nofail(dev);
> > > >>> +
> > > >>> +        spapr->xive =3D SPAPR_XIVE(dev);
> > > >>> +
> > > >>> +        /* Enable the CPU IPIs */
> > > >>> +        for (i =3D 0; i < nr_servers; ++i) {
> > > >>> +            Error *local_err =3D NULL;
> > > >>> +
> > > >>> +            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i,=
 false, &local_err);
> > > >>> +            if (local_err) {
> > > >>> +                goto out;
> > > >>> +            }
> > > >>> +        }
> > > >>
> > > >> We could move the IPI claim part in the realize routine of SPAPR_X=
IVE.
> > > >=20
> > > > Yeah, I know.  I thought about this, but there's a slight complicat=
ion
> > > > in that the XIVE part doesn't know nr_servers directly.  There's
> > > > several possible ways to handle that, but I wasn't 100% happy with =
any
> > > > that I came up with yet.
> > >=20
> > > The "nr-ends" property was inappropriate, "nr-servers" would have been
> > > better and we would have hidden the calculation of ENDs 'nr_servers <=
< 3'
> > > in the realize routine of SpaprXive.=20
> > >=20
> >=20
> > Yeah it would make sense to have nr_servers within the sPAPR XIVE objec=
t,
> > so that we don't have to pass it when building the FDT node. Same stands
> > for XICS actually.
> >=20
> > And as part of my current work to reduce HW VP consumption, I also need
> > nr_servers to pass it to the KVM device.
> >=20
> > > I don't think we can change that without breaking migration though :/
> > >=20
> >=20
> > Hmm... why ? The QOM property is just an interface, it doesn't change t=
he
> > state. In the end we migrate the same number of XiveEND objects.
>=20
> Yeah, I think it can probably be done.  I don't really have the energy
> left to sort it out for the time being, maybe one day.
>=20

As mentioned above I have another need for "nr-servers", I'll have
a look.

--Sig_/oNKWrqNaAuFvwIwmPZvL70+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2NqskACgkQcdTV5YIv
c9bzIRAAiadeyKyuLZUHlpd4ZtifdBedJvixxqHbYY9TNqxHiDQprL4OObVByGzq
v2Ww5Dvsdq5S4dJYiibNyL2SwieH7ZGxRluULGN2WQsgda9dqZrOUUIbfu5Cc6Fe
/etXpIdMRfo7ULRyftJGnp5mBc5HKlEng4l/S2Djxdd6Uo2iH3v3IUaIKItIXwXU
v2vkgWyn/uYEOGbMmweTiZlKDzupSsYzVOf1pkJgUSbaSkxIuwHTGdBW6n5AJ3GR
Bf0YMdA4aeSlBZra2W6OOrGsek4Mt9hhBRFyzX+sVrmkyOsS25RkOI7QeNhY1Iws
NjaxA7TinRT6xMUqgYQq0jP9G52XDoMo9Xgv/dJ2NE9DL58t3J+5BEbxL2Yw+5Hk
qeKLyEBqGb0WnEnLx3j8c/001xXQMW+doarO4rq3+Y0o7ipyZT9THNuYd0iUl/oM
9XaEqAfFL9wIuBhP8+DWu8dCug30JdKSRvbxJA6He9tSU+49Xx+gzcg65Qx4d2v4
Xg6OslRjhgfUHqA1JQKqi3Yh9lxVdk9Z97aFdtzBzN8OylegQ6bHQgjtVHFVYjRx
ZxiDVDT2BVYi70C1PRgZX/Y0AdxK+PcunvtOSdbIf55Dh3/V1l8QF+mHrXAQUbiv
4UJpAzuBFr33vWobNG8iYlaE3KK7LiFcC9NOQqWCLsggglma8B8=
=Ac+O
-----END PGP SIGNATURE-----

--Sig_/oNKWrqNaAuFvwIwmPZvL70+--

