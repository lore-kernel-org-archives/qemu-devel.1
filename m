Received: from eggs.gnu.org ([2001:4830:134:3::10]:52345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chduz-0004Ji-LG
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chduy-0001AU-QN
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:05:53 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-49-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <05defa76-e4a4-21f6-41de-e8de0cf37ee0@redhat.com>
Date: Sat, 25 Feb 2017 16:05:43 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-49-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QcAHItiAa6wxDpdAL03KQLPFbh2dxPQnT"
Subject: Re: [Qemu-devel] [PATCH 48/54] nbd/server: Use real permissions for
 NBD exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QcAHItiAa6wxDpdAL03KQLPFbh2dxPQnT
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <05defa76-e4a4-21f6-41de-e8de0cf37ee0@redhat.com>
Subject: Re: [PATCH 48/54] nbd/server: Use real permissions for NBD exports
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-49-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-49-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> NBD can't cope with device size changes, so resize must be forbidden,
> but otherwise we can tolerate anything. Depending on whether the export=

> is writable or not, we only require consistent reads and writes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  nbd/server.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QcAHItiAa6wxDpdAL03KQLPFbh2dxPQnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixnUcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A90MH/1lmUeRWfArCA5RREg9idghcyaWwJyhR
+UNYgokyZ00zqG1NK0q0cLNwjV/hLVBAhHQUZpDJetySzZwgPH2q4dNXno2nfcdj
YrIL0YY/orLvJs+6pN+ry5gDhN3oJ/lZ5RwzQ2HGy7uQZWwlnn7o17zR3vwKhPQr
F2kPM7HAzayTMMFxdx1fdsNcIYW4drEigoVSMXuHxm6hD+Q6acMs2eerUkqJWkGi
VgWUwAuB0wAedOy5e+PJkhq5MTGcqE2+pIwX4Gd6ke0VEDqRneWQcpC9X7mxzN4h
gTEZ229BRY2kKKzusyUtJjIvDAjtXNQM9Y2DVgyuGvdv8NwEul/Q0mA=
=qxqb
-----END PGP SIGNATURE-----

--QcAHItiAa6wxDpdAL03KQLPFbh2dxPQnT--
