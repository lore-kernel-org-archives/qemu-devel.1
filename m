Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbbBQ-0006Eb-Po
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbbBQ-0007Am-5e
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:57:52 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-9-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a169f2b7-1e12-dfb1-8990-ab335be491ea@redhat.com>
Date: Wed, 8 Feb 2017 23:57:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oQmkX0qT4OihS2a7LQT2daqqmqT14rl7m"
Subject: Re: [Qemu-devel] [PATCH v3 08/18] qcow: make encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oQmkX0qT4OihS2a7LQT2daqqmqT14rl7m
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <a169f2b7-1e12-dfb1-8990-ab335be491ea@redhat.com>
Subject: Re: [PATCH v3 08/18] qcow: make encrypt_sectors encrypt in place
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-9-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-9-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 11:18, Daniel P. Berrange wrote:
> Instead of requiring separate input/output buffers for
> encrypting data, change encrypt_sectors() to assume
> use of a single buffer, encrypting in place. One current
> caller uses the same buffer for input/output already
> and the other two callers are easily converted to do so.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c | 44 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oQmkX0qT4OihS2a7LQT2daqqmqT14rl7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibomYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgxwH/0BuDOhxQmL8MROzcz+eBcEZcA1q++4U
GFwwaC9q0MarN21nDwaM8W1STnqufJHNSZpQR4XocVg8CzJx1CpgYyAUpnvBZahm
WWIBeRdAnnkg1NQHi8DVfhYcrL/YrW7w/ZuppUnDf7zmUbwMLrHNfPQw8JN0ZpfJ
7zLyiA3iiwBAtYDGnaHq6J5Lp5zZZ5QuXYsNLsU6r7dMkRkgDhWN2fh7WjLdyMeJ
vsidXrnnLz1TP4k/heiRcRTe6AbefMdk6Q14RkEFOCkTrFS0eWXUYnrztjhg1nor
uCsATuXUImsKI/wzXx95p2DCtqo2XRQN4zU2/hujUHq6n3zRM1RS6Po=
=N1KI
-----END PGP SIGNATURE-----

--oQmkX0qT4OihS2a7LQT2daqqmqT14rl7m--
