Received: from eggs.gnu.org ([209.51.188.92]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3Ris-0008Cn-2V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3RhS-0008E6-2y
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:39:07 -0400
Date: Mon, 11 Mar 2019 21:38:54 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190311203854.GC21327@angien.pipo.sk>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, berto@igalia.com, qemu-devel@nongnu.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 17:50:07 +0100, Kevin Wolf wrote:
> We introduced the auto-read-only option to fix the problem that block
> jobs that reopen a backing file read-write don't work any more when all
> nodes are created individually with -blockdev. The reason is that
> bs->file of these backing files doesn't inherit the read-only option
> from the format layer node any more if it's created separately.
>=20
> The way auto-read-only was designed to fix this is that it just always
> opens the file node read-write if it can, so reopening the format layer
> node is enough to make the backing file writable when necessary.
>=20
> This works in principle, but not when libvirt uses sVirt: Then QEMU
> doesn't even have the permissions to open the image file read-write
> until libvirt performs an operation where write access is needed.
>=20
> This series changes auto-read-only so that it works dynamically and
> automatically reopens the file read-only or read-write depending on the
> permissions that users attached to the node requested.
>=20
> See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1685989
>=20
> v2:
> - Added test for and fixed snapshot=3Don,read-only=3Don regression [Berto]
> - Added test for and fixed commit regression [Peter]

I've quickly tested it with non-active commit and it works in this
scenario as expected.

I'll give it a bit more thorough test in the morning.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyGx1sACgkQHGwCByjY
1GpMew//Q6kHHF2C/78Raeh+lXzVRhT8Rkg5DWrPUBezdQ9Rz1rvsCXHYqd+HJt4
5PMEF8gLFqQxOqO8zA4wXdiX9QlLHPuiQuuJa3hT/yCt6pv2AMY3Edfflb68kYkk
ETUPJz6/nTO+Ya4ZaBj5+3YB36BWM3Ow6GqGZ5Q2JHgxIHAGuSzCl7ATd4/L+WUO
FCbCqMHbmrB6cbMDEYS5gD5JrLR2he1oRwX4mpz5NjnvLTEV7jq1CYeGQweSB01B
wTMWreFK8a/hIZsAjr5C1uEKcZK0su+5VU50cbXs6p/s7oQ8LCaTvnGKaHsq7JnG
3mCCmX6WGN0qBmbi1WuqS2lx4T2U+8aScWk8ehsugopU1gZWqBkOgbcGt7BEehRd
r2RhG/7SiTdv5zv1tAgFTBqXrn0UmLrgLmJdn0Lt0bI6kAqC4PMzFH9n109uK5b9
A+8KgR4sBnNiXgbKA/MODSOZEUOqiV7kisSToRnz9W4pdJ0E0c2VtPrVRJ5TDyB8
Om4ZmGRbckh4uXRKK46TGUl2zhn4hx5Q+R+ii4dJQ5mWOD7lgXBcLaONI3hO+X48
cBuiekpJNvRFY/mdT8+xomI7QW7GOMjug+URNJNRzyJsboZbamkeLJW7F5prlppL
IxPX3EIXXTAcLJZj1m/XkO1JLPlu9JIZDf/EO4Mn9BPk7ZgwdCY=
=zBDm
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
