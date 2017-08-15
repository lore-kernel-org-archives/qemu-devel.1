Received: from eggs.gnu.org ([2001:4830:134:3::10]:53387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhaFA-0002hC-4t
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhaF9-00065a-4E
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:42:44 -0400
Date: Tue, 15 Aug 2017 21:40:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170815114028.GS3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<9a1b25fc97fa35cd8c6294b1014931d832ef8240.1502643878.git.balaton@eik.bme.hu>
	<20170814044233.GF3452@umbus.fritz.box>
	<alpine.BSF.2.21.1708141306530.10227@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708141306530.10227@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 08/12] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 01:16:13PM +0200, BALATON Zoltan wrote:
> On Mon, 14 Aug 2017, David Gibson wrote:
> > On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > Needs a commit message: where does this controller appear? what's
> > distinctive about it? is there a link to a datasheet or programming man=
ual?
>=20
> This is just a generic PCI SATA controller, quite common and also used in
> PCs. Nothing special about it apart from guests running on Sam460ex usual=
ly
> have a driver for it (unlike other already emulated SATA controllers) and=
 it
> is simpler to implement than the on board SATA controller of the 460EX and
> also has two ports instead of one so more useful to have.
>=20
> I could add this as commit message if you think that would be better or j=
ust
> submit it separately through the IDE branch then use from these patch
> series.

Please do add that as a commit message.  We probably should get an ack
=66rom Jon Snow for this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmS3asACgkQbDjKyiDZ
s5K5PRAA3bTArWzxBL0lyQ2fy3lUXqrjPZpjnQQ4/ZsAz2vAe48Co/VI8wWgsAbu
H33wxLy2qMFMj9jnnbkuonvlrAhIEC8Fstb5jyIv18PzF7UElYRkA2uTeTgnz1no
rlICSGO8e7riYsG9R1FXBpCmVmzuaXrdoyG6XOPqJodBsoUxw0yzQ24JgoMazOVt
oC7hqvjtu2D+4/9z6+Bo9G946HUQn5oVGy20xOYwiwGKI0EBNb+Q6JK3s7A6GEK/
fmRXXLVMV7cfTCmMs5ZzuF2kD/ZHlxtfgw7BW1IyQ0cMka+9CrTNZ1cjBfHHl1O9
2FsAeGp4yeAn2K5CazJYvDDhtByW1V/31YIGhQlw7yWXcjNTjNqtD37OLA9zDQLP
zP0doV6uJw6PvTVKPKGfSGxQefzTNqtUQcwWT7lcnoWWWYDaXUNPwtpGgSO7klvD
pnN83xJacnVMpWUann8gWt89J+1pHeuynJ1HprS+t3WQbTbrkcbOMTFpmGcxqNUB
AqfNHCE2JpHX0WBX7cNqh9ZPGD8p21yDmV4m590fmT5Mz3KWmBxWmisoHyN87VqA
VHGYkLvpLAz7gbj3sILnFqNXnWqfIqIWudXpDfQ7NKorBZm1L0imKm1j+FXaZ1hK
s6Boec+CMiqY80BkSr/iHkftuiwpyV+HXgGWDSRghvBEAmEQQdU=
=xZGH
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--
