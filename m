Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD6EC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6CC215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6CC215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFYa8-0004er-Sr
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFYYo-000415-RX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFYYn-0003jt-Nk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:56:30 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:56245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFYYn-0003hl-HN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:56:29 -0400
Received: from player691.ha.ovh.net (unknown [10.109.143.189])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 00A84143753
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 08:56:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id B0528A8E019A;
 Wed,  2 Oct 2019 06:56:15 +0000 (UTC)
Date: Wed, 2 Oct 2019 08:56:14 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 01/34] xics: Minor fixes for XICSFabric interface
Message-ID: <20191002085614.4880ef68@bahia.lan>
In-Reply-To: <20191002055551.GV11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-2-david@gibson.dropbear.id.au>
 <2297d0ee-ff47-c000-5e6d-eb6aba83c456@kaod.org>
 <20191002055551.GV11105@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tiq_bUdkLKM6AABBz.VCEaN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 5339580311732197862
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.59.63
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/tiq_bUdkLKM6AABBz.VCEaN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2019 15:55:51 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 02, 2019 at 07:51:45AM +0200, C=C3=A9dric Le Goater wrote:
> > On 02/10/2019 04:51, David Gibson wrote:
> > > Interface instances should never be directly dereferenced.  So, the c=
ommon
> > > practice is to make them incomplete types to make sure no-one does th=
at.
> > > XICSFrabric, however, had a dummy type which is less safe.
> > >=20
> > > We were also using OBJECT_CHECK() where we should have been using
> > > INTERFACE_CHECK().
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Uhhh... you sent me an R-b line for Greg, not yourself...
>=20

Heh it's because people confuse our names so often that we don't
really know where we stand now.

--
Cedric ;-)

> >=20
> > > ---
> > >  include/hw/ppc/xics.h | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >=20
> > > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > > index 64a2c8862a..faa33ae943 100644
> > > --- a/include/hw/ppc/xics.h
> > > +++ b/include/hw/ppc/xics.h
> > > @@ -147,13 +147,9 @@ struct ICSIRQState {
> > >      uint8_t flags;
> > >  };
> > > =20
> > > -struct XICSFabric {
> > > -    Object parent;
> > > -};
> > > -
> > >  #define TYPE_XICS_FABRIC "xics-fabric"
> > >  #define XICS_FABRIC(obj)                                     \
> > > -    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
> > > +    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
> > >  #define XICS_FABRIC_CLASS(klass)                                    =
 \
> > >      OBJECT_CLASS_CHECK(XICSFabricClass, (klass), TYPE_XICS_FABRIC)
> > >  #define XICS_FABRIC_GET_CLASS(obj)                                  =
 \
> > >=20
> >=20
>=20


--Sig_/tiq_bUdkLKM6AABBz.VCEaN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2USg4ACgkQcdTV5YIv
c9Ye6Q/+KrZzXbY289bEmePNQvnsQmMXytzXb9lrVjf1ffPEuOerYYvQFhQrw7Y/
5h4teolkQ6IpSWOqtVtzc1RRCiOdzFxtFTBlQtXcj8Rr4MUUn2+O2v0MQvGKuw9m
eGc3SJCyqOaAgB2ANc/WsLkasBJdCxbv4TNBKH/QJQxiVpsXVps/xC7NHxc/+BHC
zkNB9h+/ToN6myRJs5cQR2shU1wPQEtka9ItHOHRnVYZ9m7cafqfrQcY9YJhIH21
RtoxHREQQYLobYN13ANqsKCXcTZzQBVqYRXgYsolezKqJYdXH5UbAV3g4+1Cx7ge
yJq1wPKjIWHayDk0zS0C7h0fAwLQySrqFlGRf6Ht/1snNuvvgDReAPlYdDra8UsE
B2FudlSp2HapR3beDs1Dq70KpK3F0Yh/9IlMzVVQdSCCsHZibY/UOxMTPIRQ0V5j
AVuZQ+1uvOI+CNMeq2xvUox5Y7R/n95LDsfYod+XAoz/puBU2WNFRjLqaS9lmDBN
sVqIjrnwusKWNR6upkk1puzIzoNNVxTYvQ4gm9ZQuuwwTOVaiz5R4VJsjBQXrGOd
p9yQZG6JL18hrLqxQozqRADFNXWGqri0ck5IIpoqsgYhTwoHcxC9+jyJtTkRS0QI
pzBe1T8XG/NvU4T5E06sf+MFWSDfozSbLdVAc0cYqOfBA/H4naM=
=rCQt
-----END PGP SIGNATURE-----

--Sig_/tiq_bUdkLKM6AABBz.VCEaN--

