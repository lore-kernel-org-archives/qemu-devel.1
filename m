Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2059BC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 07:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFDD2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 07:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFDD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbJtA-0004tk-1S
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 03:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbJqD-0003rw-6I
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 03:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbJqC-0001Tn-3H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 03:08:09 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:58133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbJqA-0001EW-MZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 03:08:07 -0400
Received: from player738.ha.ovh.net (unknown [10.109.160.93])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 14C021D0DC7
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:07:44 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 41E936E632A8;
 Thu, 13 Jun 2019 07:07:39 +0000 (UTC)
Date: Thu, 13 Jun 2019 09:07:38 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190613090738.116b7e1b@bahia.lan>
In-Reply-To: <20190612235627.GE26378@umbus.fritz.box>
References: <20190612230202.878-1-philmd@redhat.com>
 <20190612235627.GE26378@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6CHsLwRdDyyj3agTjLyET31"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 17744182535315888614
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehkedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.39.161
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH] spapr_pci: Fix Null pointer
 dereferences in spapr_dt_pci_bus()
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/6CHsLwRdDyyj3agTjLyET31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2019 09:56:27 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 13, 2019 at 01:02:02AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Commit 14e714900f6 refactored the call to spapr_dt_drc(),
> > but used an incorrect object owner as argument.
> >=20
> > This fixes:
> >=20
> >   /hw/ppc/spapr_pci.c: 1367 in spapr_dt_pci_bus() =20
> >   >>>     CID 1401933:  Null pointer dereferences  (FORWARD_NULL)
> >   >>>     Dereferencing null pointer "bus". =20
> >   1367         ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev=
),
> >   1368                            SPAPR_DR_CONNECTOR_TYPE_PCI);
> >=20
> > Fixes: 14e714900f6
> > Reported-by: Coverity (CID 1401933)
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =20
>=20
> Nack.  The bus bridge is the correct owner in most cases here.  It
> *used* to be that all the PCI DRCs were owned by the PHB, but that's
> intentionally not the case with the changes to allow hotplug under P2P
> bridges.
>=20
> AFAICT, the bus parameter does have to be non-NULL from both callers,
> so I think the correct fix is to remove the test on if (bus) earlier
> in the function.
>=20

... and maybe make this obvious with an assert(bus) ?

> > ---
> >  hw/ppc/spapr_pci.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 957ae88bbd..e0cd3f11f1 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1364,8 +1364,7 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, =
PCIBus *bus,
> >          }
> >      }
> > =20
> > -    ret =3D spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
> > -                       SPAPR_DR_CONNECTOR_TYPE_PCI);
> > +    ret =3D spapr_dt_drc(fdt, offset, OBJECT(sphb), SPAPR_DR_CONNECTOR=
_TYPE_PCI);
> >      if (ret) {
> >          return ret;
> >      } =20
>=20


--Sig_/6CHsLwRdDyyj3agTjLyET31
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl0B9joACgkQcdTV5YIv
c9YBng/9EFPd45eFimA4SsSWJxxFCGo2abBXIM0vGdXReF5icyMQ+KXD2xkmSpvY
0Bh2HNFFsvgXAS8aPqiUW0lEWx273ycy5wMPN3o8NLjltB8qsGoOchL9gCli1jiO
7jr8D8fyTIsAaSAF2irzbgJwblcVmFGMJtLrA6oWcrGzUL0v+Itnp/bx4fzB93dp
4PtMcD3iL0F7gHIi/73YQR4QrkWWwpBEOOwOlbL8KK2y/JpNDPbJ08LNCCz8fZr4
qNookEYxIjatKPK/gp1BzEkQrHIt5BURG0ElaKktbxhAh5aYnvJQh9pUQ44uENav
gXHCyxy2UDXcVheD6F9N1/pCU3jxrNVYh1UNzDfa7ao1fnHrfs/VGdWE5tyzYCqX
yiUCabML+O59bNGT1cSAxXNncmIkdZMqmlFTJPHt57+vknV7Pn6P0eUNohZp+1By
qYDXfSWOMYLpCL7p9MuTFsjvCk1muRPqiwkGmimy7I6hygYElzUA912Zvb+bCScE
p2JOidVG6tEenXvXzLbDdS7LK8LTkCKa9aG54+hvCFHw4aCfYXQIUu4arkU4UKhy
eGsEeafccfvR1YDOFtwk0VGzm/3L1XwAR3Dz1xcMBVdg7mZpJRibr4BFF5SnxvHY
cD+7s0G5QoZl0pQdZ3YC31TQsN3HZykyjVT8f0nbjFBGQ+m6LqQ=
=UbK2
-----END PGP SIGNATURE-----

--Sig_/6CHsLwRdDyyj3agTjLyET31--

