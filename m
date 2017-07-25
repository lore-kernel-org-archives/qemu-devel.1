Received: from eggs.gnu.org ([2001:4830:134:3::10]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsd5-0007ZV-5I
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsd2-00059G-33
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:43:35 -0400
Date: Tue, 25 Jul 2017 14:18:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725041841.GA8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1500894439.10674.76.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 09:07:19PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-24 at 19:50 +1000, David Gibson wrote:
> > On Mon, Jul 24, 2017 at 05:00:57PM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
> > > > On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=E9dric Le Goater wrote:
> > > > > These flags define some characteristics of the source :
> > > > >=20
> > > > >  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with=
 a
> > > > >                        specific hcall H_INT_ESB
> > > >=20
> > > > What's the other option?
> > >=20
> > > Direct MMIO access. Normally all interrupts use normal MMIOs,
> > > each interrupts has an associated MMIO page with special MMIOs
> > > to control the source state (PQ bits). This is something I added
> > > to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
> > > to work around broken HW (which happens on some P9 versions).
> >=20
> > Ok.. and that's something that can be decided at runtime?
>=20
> Well, at this point I think nothing will set that flag.... It's there
> for workaround around HW bugs on some chips. At least in full emu it
> shouldn't happen unless we try to emulate those bugs. Hopefully direct
> MMIO will just work.

Hm.  That doesn't seem like a good match for a per-irq state
structure.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll2xp8ACgkQbDjKyiDZ
s5IHQA//T0okvh4HLOAE1812GD9jls/rj+nDoDLt1aRbF9JKP+whWOYT+c6nElJ9
hhFi8cFRpnzIlHkZ3bcILyiYdNoLlz6Gu5hfHP+o0Je7P3KPH6UzHXT5EazzDNfN
/iyk6Bdbpi8g6qMWOymCxqB67H7STnHFBEvBA5MAoGv1Rd3u+QcGKW85UGW33E17
YTcL7S2W8uPtRsXT7ORaWXaaPmQBUSEEXoqjQyyrwn7Q6II9+YOHJ1lyUNTMolvT
Wptcql58w/auZdGghJ5Od80JDQKFE8Njd6ZbjUB/d61TLRTHr7AXliDXFJ0VdYxT
movDESnMtYdtMZAxiWQVslgJbRm+2ZB8U+3Wxi2SgjlUdhfVp0MPUpUDcnN1z8cI
nPVv/g2KcnYqzee1ZwtgGwVOWl7nZsc7VJrTWU5EodMjn3G1oFhX9/qrWMeHywq0
E1YA42+Vkzx51GH468uwBfhrn23O85os1/MRGfzjIIzywZnxcj1lnmLA6OqHZzYU
kPgtuio+s02VsBsgKlKyT1jL56oO30mAag4HkpKuJNERWnIMBzemUfx+zUfjbxbi
lQDCc5qxlOvIwHLtUo1PU0AixagWV/L/D0yTRgxV3VZ0429nAA9ez6l4rv5ycUL3
POnfOexGdaoLa2WZv1aaFUej9GTeTItBXU+FT9QgjEnXEBqgbzg=
=LA/O
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
