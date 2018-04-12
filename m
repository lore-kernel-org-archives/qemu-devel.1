Received: from eggs.gnu.org ([2001:4830:134:3::10]:36125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6QAx-0004Fl-V1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 20:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6QAu-0007GC-R1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 20:33:19 -0400
Date: Thu, 12 Apr 2018 10:30:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412003026.GB9425@umbus.fritz.box>
References: <20180411070418.6304-1-david@gibson.dropbear.id.au>
	<89ae5f83-ee3a-9d71-1f66-019821109c49@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <89ae5f83-ee3a-9d71-1f66-019821109c49@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 for-2.13 0/2] Helpers to obtain host page
 sizes for guest RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: ehabkost@redhat.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 03:54:20PM +0200, Paolo Bonzini wrote:
> On 11/04/2018 09:04, David Gibson wrote:
> > This series makes some small changes to make it easier to obtain the
> > host page size backing given portions of guest RAM.  We use this in a
> > couple of places currently, and I have one or two more to add in some
> > upcoming code.
> >=20
> > Assuming there are no objections, what should be the procedure for
> > staging this?  Can I put it in my for-2.13 ppc tree, even though it's
> > technically generic code, or should it go through someone else's tree?
>=20
> Yes, go ahead:
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I'm assuming that's an ack to putting it through my tree.

In which case, done, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrOqKAACgkQbDjKyiDZ
s5Igjw/9H1nLPClSALKQb6SuOmhoynJwJVp4K2QaNHnS0mL7fo6ezB+geDIYBbzv
rlMzB89GqTH9/csBbRH/Ybf1/tMwHh0MCzmdkr+xyh49Efvy8JFoX0XZPaJUMDSN
P7hIuRImawVgbt6hrnOfr9TngDEyGumpXuLUFX7lA4XmUEZgyeeuAoUpN3OAijwh
sNpmzQOokq3B7LZPfliOpHzAymhJt1Gng+85x2ot65tkp8o1rrs1Q+DT972bUVyz
4bNd/QyzIQf9mfZ0Ul3JVNspnj9ldLe/FJ02RvlG41zy3HOlJhJhqQ7gp8/CzvXn
piTpIrdPnc+Qv/TcP822u8aKBJ0J6PJgOTAblgZV4He4tv/EEqXbwXRK/FOzMVnB
6xrPOomZgSfGqKCh7AUWJzUygSx5zw6/f8oZH3iGr9mw/zXZxMHH/Ri6weJg7D2n
o2PX8mfvRYMrjv3rHnZ9Wy+vngMxa33Or+St2QlwBC/qBFouoxoFpk1aqZn/9+j0
8Kn38SfR8armwaJiFU9BAV+DYVw7ASeEE+8kHz9rP99wM8TuXMqooq0Hn1gHGX5c
dCCuGX3wOdvvQQ0SbkoXksb6jRs6XafuVSwQSXDAdkHB2aYD8T6j1t0t7j5mVZQU
A+FGrfqVHgiCbOuDPP3wGnB2a17GFSn2hLGMFbtFiA3cRvmygZw=
=+rKi
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
