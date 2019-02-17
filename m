Received: from eggs.gnu.org ([209.51.188.92]:52575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0008BR-1C
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0005cr-0a
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:05 -0500
Date: Mon, 18 Feb 2019 10:49:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217234917.GJ2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023083585.1011724.2868047424353921455.stgit@bahia.lan>
	<57083069-924d-ddc5-2132-2e3b9588e968@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPTHnM80CEnHQ2WJ"
Content-Disposition: inline
In-Reply-To: <57083069-924d-ddc5-2132-2e3b9588e968@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 09/10] spapr/irq: Use the "simple" ICS
 class for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--mPTHnM80CEnHQ2WJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:02:16PM +0100, C=E9dric Le Goater wrote:
> On 2/15/19 12:40 PM, Greg Kurz wrote:
> > The "simple" ICS class knows how to interract with KVM. Adapt sPAPR to =
use
> > it instead of the ICS KVM class.
>=20
> You are changing the type name. What about migration ?

As with ICP this would be a problem if the ics-kvm class had any extra
migration state, but it doesn't.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mPTHnM80CEnHQ2WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp8vwACgkQbDjKyiDZ
s5KblRAAw/PU0Ym3qBAEeqUxrYaOErP0rI0JdzufxcGKe4TKGX58e6tO4VG0aqgF
dKyE7cd9ueKAco/xMuSKcwGGktJpVGiWvoErfwo8babAfuq7RVspIYv7R+ph+qsJ
tf1c319K2+x+3D7jZ3S6YProf4RnnXgo7UZe8SjrpLUl089FYKkUW1yoODtEzTRy
dKnbgih6GO5yQPhUL57DfLun7x6JK9FGD0b8cd/c4msQv3RFfvxzGBjSp/AtpJfs
0HWRnci8IiO/lv9nuGA7+fyymaoV3OYmTQN3qHCpQvcynwAgfYYxphRZuR/djvuu
2gW/sHpqbeODgFXLzaaBmqhOW5Y9uaqNJHJUxu91FeVI9U/gG/OgJB/f64XUp+/B
+bT9BEz0mwiMLUL2z36SIJq1JGTDyGHfXmsvg7QXNETuwaRk/0WKVZQcIYvnmHDK
XvaCDG0ljhIgjte+fRaM+Yy2VE+D0NhDO3zujwdHn3r6OIzdfE4XRm45Xz7RGvJT
nwBSttTPg6T7KpMfkOeZprDjLmhFd7oebPXDxkSLiczCX33skCrIEJZU1gUIMV4r
U7BPhbcDbLa218Punh6ofHrjhk0a5CEk9i5dhABwBNiNfIAvQyqt4dknmQQhqZB1
ILAq7vn+AkBceCYuP9aZ50yycXZ882l3GDR58l073e9T4Cd3GQs=
=MhkS
-----END PGP SIGNATURE-----

--mPTHnM80CEnHQ2WJ--
