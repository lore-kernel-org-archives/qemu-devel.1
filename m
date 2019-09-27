Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D3C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CEE20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GXx9IGEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CEE20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDjmy-0004tP-5E
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDjAE-00082Q-Di
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDjAC-0006Ok-6D
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:51:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDjAB-0006K8-Q7; Fri, 27 Sep 2019 01:51:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fgsC3KtJz9sPY; Fri, 27 Sep 2019 15:51:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569563487;
 bh=zBvjfVZR9kT89//ygMqCXGAqVDWJYCxH7bM+2sUku6w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GXx9IGEiFh/0pPs+LgyjWTg3r6bhmZiWtZOgz/WlySvq3YGfq0+C9gb0bGAXfX503
 7H5tsAhXFHPBeRJAYXEdhGwp9PPOflIpfjj5XAKAiq+jgO0VzQGzWzNC9lv43E6sva
 JNLNGKF2z/ji603AEBWPpsICHcwlwH74546vOVK0=
Date: Fri, 27 Sep 2019 15:51:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190927055104.GG17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
 <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
 <20190926011336.GS17405@umbus>
 <92ce15dd-f7f9-3d2b-4226-9693bd9cfd65@kaod.org>
 <20190926173539.4a07d419@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oxour8c+zPVguRmP"
Content-Disposition: inline
In-Reply-To: <20190926173539.4a07d419@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oxour8c+zPVguRmP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 05:35:39PM +0200, Greg Kurz wrote:
> On Thu, 26 Sep 2019 09:05:56 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > >>> +    if (spapr->irq->xive) {
> > >>> +        uint32_t nr_servers =3D spapr_max_server_number(spapr);
> > >>> +        DeviceState *dev;
> > >>> +        int i;
> > >>> +
> > >>> +        dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> > >>> +        qdev_prop_set_uint32(dev, "nr-irqs",
> > >>> +                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BAS=
E);
> > >>> +        /*
> > >>> +         * 8 XIVE END structures per CPU. One for each available
> > >>> +         * priority
> > >>> +         */
> > >>> +        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> > >>> +        qdev_init_nofail(dev);
> > >>> +
> > >>> +        spapr->xive =3D SPAPR_XIVE(dev);
> > >>> +
> > >>> +        /* Enable the CPU IPIs */
> > >>> +        for (i =3D 0; i < nr_servers; ++i) {
> > >>> +            Error *local_err =3D NULL;
> > >>> +
> > >>> +            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, f=
alse, &local_err);
> > >>> +            if (local_err) {
> > >>> +                goto out;
> > >>> +            }
> > >>> +        }
> > >>
> > >> We could move the IPI claim part in the realize routine of SPAPR_XIV=
E.
> > >=20
> > > Yeah, I know.  I thought about this, but there's a slight complication
> > > in that the XIVE part doesn't know nr_servers directly.  There's
> > > several possible ways to handle that, but I wasn't 100% happy with any
> > > that I came up with yet.
> >=20
> > The "nr-ends" property was inappropriate, "nr-servers" would have been
> > better and we would have hidden the calculation of ENDs 'nr_servers << =
3'
> > in the realize routine of SpaprXive.=20
> >=20
>=20
> Yeah it would make sense to have nr_servers within the sPAPR XIVE object,
> so that we don't have to pass it when building the FDT node. Same stands
> for XICS actually.
>=20
> And as part of my current work to reduce HW VP consumption, I also need
> nr_servers to pass it to the KVM device.
>=20
> > I don't think we can change that without breaking migration though :/
> >=20
>=20
> Hmm... why ? The QOM property is just an interface, it doesn't change the
> state. In the end we migrate the same number of XiveEND objects.

Yeah, I think it can probably be done.  I don't really have the energy
left to sort it out for the time being, maybe one day.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oxour8c+zPVguRmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2No0cACgkQbDjKyiDZ
s5IN2BAAhBdpn1Z7qOk3pScrgqah23xpK+tfs9OiOBdliTZOOlkxq6+golhUgX2F
f7cEn03B56CWSS6eomM/yzLhkFl/24b2f2LUnUYI/7iapwJ/zsQRDapyfSJkbGui
bs4jJC5znTWG597YgDoo3BpDv2zRkhajUwWsmvDhh2bUdhlJm54/7MKvosUd3+m6
aH8d2yJPHibYMca7NUi7fVSTfP0VIwBIT1OL/agmXn3Z5ih7zrED8Js1pH8V7foD
1EIiu6HoGQmw2aGEd2Brs0+qFY7O6elxbnWS/zInLLIstmv56Q6FfEc5PccTohW+
vPXFiQMT53yB5t7K2RV8j0QQ4dTRfUU6UlzCsb4732T5iUl9HpVLpG+Ha/Uzhui9
Xs6rw5PpqQtPGlFfXFXB98+ujAX7pbuMDKXkyy/FH02SxEhr9Tk90NeFYI01CSeE
hf9cC2rrIg7Itk/KpRqr3SDFPLmuM9/lkC51Rtq8+0hTCFC7cQBfN+7XRKrQSvTO
1wX/bRgCC/WDFx98L0vdsfHfqV0aLXxnZaqfS3LJmSZ3oRy9Ot45sS4jHNYgq9qR
wD9FDoaMhhsc/60TSPQa6dMZUQBnyxm/Lj7HOqSO2SGCFQHdO4/ytYxIkXKdd1X2
Yo9B8lvl9Po1xLUmS3685ZTDS3wUWmBG9Iatth8LgifOwwm913g=
=UvyF
-----END PGP SIGNATURE-----

--oxour8c+zPVguRmP--

