Received: from eggs.gnu.org ([2001:4830:134:3::10]:53314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz3Eq-0001Y6-5R
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz3Ep-0007Mw-Cw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:06:36 -0400
Date: Mon, 2 Oct 2017 18:06:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002160615.GG4362@localhost.localdomain>
References: <20170925145526.32690-1-eblake@redhat.com>
	<20170925145526.32690-6-eblake@redhat.com>
	<f305e22b-963e-f1eb-710c-d74c6efc9628@virtuozzo.com>
	<b10bd108-0387-34eb-9aa4-7c5e3f9f63a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <b10bd108-0387-34eb-9aa4-7c5e3f9f63a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.09.2017 um 17:46 hat Eric Blake geschrieben:
> On 09/25/2017 10:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> > 25.09.2017 17:55, Eric Blake wrote:
> >> We've previously fixed several places where we failed to account
> >> for possible errors from bdrv_nb_sectors().=A0 Fix another one by
> >> making bdrv_dirty_bitmap_truncate() take the new size from the
> >> caller instead of querying itself; then adjust the sole caller
> >> bdrv_truncate() to pass the size just determined by a successful
> >> resize, or to skip the bitmap resize on failure, thus avoiding
> >=20
> > nothing is skipped in this version
>=20
> So much for me squashing in a change.  If the maintainer is willing
> (Kevin, is this going through your tree?), we can reword that to:
>=20
> "...pass the size just determined by a successful resize, or to reuse
> the size given to the original truncate operation when
> refresh_total_sectors() was not able to confirm the actual size (the two
> sizes can potentially differ according to rounding constraints), thus
> avoiding..."

I always thought sentences that long were only allowed in German.

Anyway, I'm squashing it in.

Kevin

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ0mP3AAoJEH8JsnLIjy/W41EQAKNUNWXJ0ABVk0xnPlJYibKs
VhUVHCCIWApw8IXMs4vWQ2cP//m4+Pa0MnyjkxqNaYHnwDiQdDmjrsrrBeBezNq+
ehlG61NdPLEPzWa177i+H2+LfjtH4jj3pgZCt2qU4TefuI0t0FympUneE0kn1LTi
xh13518++HznXuezjJY1GRROJlcWOypvG38odx5VE9nTSs34ZpBqNfOomHCjpcUI
+onXYOgtBWRgTJZWBrIjFBB5SRion5816xkBs/4hN4CehgF3vJI+QHAlzyiX5rfZ
EqNjO0bX3TO+Ly7PtfDrxYOxSkEoPHoBbpQp1AbwK8dUigW6RD8woNjbKg5TaN1w
5PAe5yyCmEcgk88ER50aNVwsEGj4Jfkbe7rXabhS8mmSjAvCOIxduhfrvIUUKyFf
8wFHWwVooiAO9okrCe9uCCC9rBq+vMb8ajFC5GUx3x7NgcQ6wtYKCrmPiBH9X0im
cKpu9uHt0J4UOpPJvzAwEY6W95xLUITf7sNEGn6F3fA6xxbD2s9GiHeTDd914LHF
PXLUDxHiJc0jeBn0nld3f2m9Jzx5MKLe8T1psi/Gd0MoRbRPNmVAOmr/zr8um0fv
AZHLRjYQzt9NGhjtMTuouoLFzqcjSswPTgehH7XLmyg1XyD0aNutJD9gX6PwqpEM
+eZxtbjvUZUxubOHIl7h
=P7SO
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
