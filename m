Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E03DC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B701222B6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jMLwJ2Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B701222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXD7Z-0004Ua-91
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 18:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXD6b-0003RF-5f
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXD6Z-00022x-IE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:40:20 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:35349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXD6Z-00020P-6Y; Tue, 19 Nov 2019 18:40:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Hj3y6sJrz9sPT; Wed, 20 Nov 2019 10:40:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574206814;
 bh=Lpl7SdEVqaXUWtR6xcA1wfxgTUWucIR+HgvpxuFAVis=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jMLwJ2IizDrBGv22j0bw/fVmQqEHGI2qSk+of0zaRIF3nK4s2Hs7EuOAquSIaYb37
 gLf8X5QgaAoaZklizefU1ZjlZ9D+NfpqpaFMAk9CY6XCGarUbMR9K3fOQBscFxHOTs
 rooF7SGFd4poIYGJA3MPxMSPS+m3i7g6Ti6EWvCU=
Date: Wed, 20 Nov 2019 09:05:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices at machine init
Message-ID: <20191119220507.GX5582@umbus.fritz.box>
References: <20191118092222.15691-1-clg@kaod.org>
 <20191119005232.GH5582@umbus.fritz.box>
 <2c2dfb82-e5cd-ef94-3542-8ec92b1ef001@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KH9S6eoVXLBawpUJ"
Content-Disposition: inline
In-Reply-To: <2c2dfb82-e5cd-ef94-3542-8ec92b1ef001@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Corey Minyard <cminyard@mvista.com>,
 Oliver O'Halloran <oohall@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KH9S6eoVXLBawpUJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 07:49:33AM +0100, C=E9dric Le Goater wrote:
> On 19/11/2019 01:52, David Gibson wrote:
> > On Mon, Nov 18, 2019 at 10:22:22AM +0100, C=E9dric Le Goater wrote:
> >> The BMC of the OpenPOWER systems monitors the machine state using
> >> sensors, controls the power and controls the access to the PNOR flash
> >> device containing the firmware image required to boot the host.
> >>
> >> QEMU models the power cycle process, access to the sensors and access
> >> to the PNOR device. But, for these features to be available, the QEMU
> >> PowerNV machine needs two extras devices on the command line, an IPMI
> >> BT device for communication and a BMC backend device:
> >>
> >>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D=
10
> >>
> >> The BMC properties are then defined accordingly in the device tree and
> >> OPAL self adapts. If a BMC device and an IPMI BT device are not
> >> available, OPAL does not try to communicate with the BMC in any
> >> manner. This is not how real systems behave.
> >>
> >> To be closer to the default behavior, create an IPMI BMC simulator
> >> device and an IPMI BT device at machine initialization time. We loose
> >> the ability to define an external BMC device but there are benefits:
> >>
> >>   - a better match with real systems,
> >>   - a better test coverage of the OPAL code,
> >>   - system powerdown and reset commands that work,
> >>   - a QEMU device tree compliant with the specifications (*).
> >>
> >> (*) Still needs a MBOX device.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > This doesn't apply to ppc-for-5.0 for me.  I'm not sure which change
> > in there it's conflicting with, but there seems to be something.
>=20
> Sorry I should have been more precise.
>=20
>=20
> This is because we need an IPMI patch to be merged first in=20
> Corey's tree :
>=20
>   ipmi: Add support to customize OEM functions
>   http://patchwork.ozlabs.org/patch/1185187/
>=20
> and another one merged in the PPC tree:=20
>=20
>   ppc/pnv: Add HIOMAP commands
>   http://patchwork.ozlabs.org/patch/1185185/
>=20
>=20
> David, if Corey agrees, I think it would be simpler if you took=20
> them all.

Ok.  Corey, could I get an Acked-by from you?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KH9S6eoVXLBawpUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UZxMACgkQbDjKyiDZ
s5JYrg/5AZ7XjpwZGtTjWoRouC1OZ3aHSTpJlv+V3Nx8SXyZ3pQvIXSENHscOQ2z
xTjS8bbpAV3Y5gfGfqJWONme/qI9eOFhc/LOASll7UqjiZvJbHs18HNrOf2VCtJG
b2XrftAAyuRWPRQEw53GIG1k8JdCp5DE3cLQaVSbcnHvqQsXJRHzgOINQzb1y0+E
hhjGMmJgZ+58EDrDqvrsAH/7COUwFZb9qnezidngZi4IwnvAn5mBBRtH6vvG12gX
ODudJi2sBS16anVwN9pLI1VeSjvpX83XtkyUhsbmWoClAwBbR/ZLQAfB0sHXUyy/
gf6l36YNe/jwHQGfbPDXjWXFXL/5Uf0H86hNncl7G3Gqhjxkd9M9SMOO1p0izqDY
qdCfVXdT1g1KYJ+2MVqwH1WuQKtUcLfOH0/AOVVC6z86shpttAfqVJRsI3bMNXGb
luilXF5gx4ng+hqQlS8UGn07cH5IdiPgQLk0ZPZ8IWyeL5ANTS+Y+jlENv7Y4lMp
3jAn0SwawbWyONLIK8yAsE2wdsq4Y9wVwNcePz7ox7fyaEjlTtZpPI4F4QPTCo+d
QHo3lczMkyYzrPyAkis4LiBnptLWV7GMEyLV9ht8cMmW362+wYxVV8RAuATUw49s
oE28Kcb9UiyZoHqxfFLgc0i9f6DVyP8vOgMjoSRCj4Ij1CjjMb4=
=fQl9
-----END PGP SIGNATURE-----

--KH9S6eoVXLBawpUJ--

