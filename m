Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C8C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D537A20679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j1Ki3d/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D537A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXxWU-0004JH-Ri
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 20:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXxVc-0003s3-8y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXxVY-0007W2-Jn
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:13:16 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38139)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXxVX-0007Uk-VS; Thu, 21 Nov 2019 20:13:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Jz2C17WKz9sPc; Fri, 22 Nov 2019 12:13:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574385187;
 bh=wrsTkK8axZyZq8GB+ZgpIjcOpW1q1ZlGhMlhoe92P2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j1Ki3d/xdOSnTWlxzhvW0oy5UG1ydoBcMviGLKso/pkqZ7NoOgJxQfgo9iqgqcsRz
 EQpeE9n+Y5Xt+iyGeimLfSaxLuDvrOxYmk++75NkyX9Fbe8NFgFwRpiqd+PqZAlHuG
 ByQniTETzHCuxujSjmpf1wne30+XThpqgx30Nzxo=
Date: Fri, 22 Nov 2019 12:12:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices at machine init
Message-ID: <20191122011244.GW5582@umbus.fritz.box>
References: <20191118092222.15691-1-clg@kaod.org>
 <20191119005232.GH5582@umbus.fritz.box>
 <2c2dfb82-e5cd-ef94-3542-8ec92b1ef001@kaod.org>
 <20191119220507.GX5582@umbus.fritz.box>
 <20191121153507.GF3556@minyard.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3/Wm4stOzDzLYPbq"
Content-Disposition: inline
In-Reply-To: <20191121153507.GF3556@minyard.net>
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
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3/Wm4stOzDzLYPbq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 09:35:07AM -0600, Corey Minyard wrote:
> On Wed, Nov 20, 2019 at 09:05:07AM +1100, David Gibson wrote:
> > On Tue, Nov 19, 2019 at 07:49:33AM +0100, C=E9dric Le Goater wrote:
> > > On 19/11/2019 01:52, David Gibson wrote:
> > > > On Mon, Nov 18, 2019 at 10:22:22AM +0100, C=E9dric Le Goater wrote:
> > > >> The BMC of the OpenPOWER systems monitors the machine state using
> > > >> sensors, controls the power and controls the access to the PNOR fl=
ash
> > > >> device containing the firmware image required to boot the host.
> > > >>
> > > >> QEMU models the power cycle process, access to the sensors and acc=
ess
> > > >> to the PNOR device. But, for these features to be available, the Q=
EMU
> > > >> PowerNV machine needs two extras devices on the command line, an I=
PMI
> > > >> BT device for communication and a BMC backend device:
> > > >>
> > > >>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,ir=
q=3D10
> > > >>
> > > >> The BMC properties are then defined accordingly in the device tree=
 and
> > > >> OPAL self adapts. If a BMC device and an IPMI BT device are not
> > > >> available, OPAL does not try to communicate with the BMC in any
> > > >> manner. This is not how real systems behave.
> > > >>
> > > >> To be closer to the default behavior, create an IPMI BMC simulator
> > > >> device and an IPMI BT device at machine initialization time. We lo=
ose
> > > >> the ability to define an external BMC device but there are benefit=
s:
> > > >>
> > > >>   - a better match with real systems,
> > > >>   - a better test coverage of the OPAL code,
> > > >>   - system powerdown and reset commands that work,
> > > >>   - a QEMU device tree compliant with the specifications (*).
> > > >>
> > > >> (*) Still needs a MBOX device.
> > > >>
> > > >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > >=20
> > > > This doesn't apply to ppc-for-5.0 for me.  I'm not sure which change
> > > > in there it's conflicting with, but there seems to be something.
> > >=20
> > > Sorry I should have been more precise.
> > >=20
> > >=20
> > > This is because we need an IPMI patch to be merged first in=20
> > > Corey's tree :
> > >=20
> > >   ipmi: Add support to customize OEM functions
> > >   http://patchwork.ozlabs.org/patch/1185187/
> > >=20
> > > and another one merged in the PPC tree:=20
> > >=20
> > >   ppc/pnv: Add HIOMAP commands
> > >   http://patchwork.ozlabs.org/patch/1185185/
> > >=20
> > >=20
> > > David, if Corey agrees, I think it would be simpler if you took=20
> > > them all.
> >=20
> > Ok.  Corey, could I get an Acked-by from you?
>=20
> Sure
>=20
> Acked-by: Corey Minyard <cminyard@mvista.com>

Sorry, I wasn't clear.  It's the prerequisite "ipmi: Add support to
customize OEM functions" patch that I'm after an Acked-by for, rather
than thos one - I generally like to have that if I'm taking a patch
through my tree that isn't in the area I'm tagged as maintainer for.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3/Wm4stOzDzLYPbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3XNgwACgkQbDjKyiDZ
s5KStBAAnMJnQ9Ec/xKlncAEDDMcbXDjwqsoIWv76vfUg3RvuhiaJnADVAx5NLjV
L1Z1iwMrZpY3izG2ssSIqfNneSBOuRapqO07I3HZWJi5HIymoaC+Cn4pT6U84Ke2
gl8BJ9kaT2AX5qQLZQIcrliagSPgopjvb3VL4sGK1xImD286Nd2Xs4Z29rtnCTlN
46cPDlbCAbT+bkOeKlN1w8jDeOvTegxQhajNaPSfgl9BHAe4D/ca3BDOw9i4rJWW
ervEhlriSB+CdUEUkUrraKp7prEe61spUI1hWkcFMktS5jqI38F8XL8Ugp8pBOiv
omyMw1yFGFX7NDc8l2HYP7puTk3Sd4wH7i3LwR+FKflYp4fXxSU5qUfhJvr/brvn
gXzHENsSyF62Xpzz5ROFLIkSHW5r7fyv0bad7Kn8ePtCXvTDibIwlF3f00jeQ02t
VVN3yq5k/GBC7bw7vd0LwrsStEDH/8ed9fhNzyk4a54oAG5msbhK44w012eONd4I
YBUiQ9vll39evxsYHlvF20M8NBYmoKFmb6J+1LPWDmVPwN681EalcYDjuBSBGtZ2
r1t4tevJIV8LFuh31u1EOMexTANfrtVsE2xto+z2v7B5l5FPgMUl615h7UCdbnPp
Vr2Wom2c0tbD4nPnR13J36lYcV9JiEAZRjmTU5Bx0XqFZptxfD8=
=LNJb
-----END PGP SIGNATURE-----

--3/Wm4stOzDzLYPbq--

