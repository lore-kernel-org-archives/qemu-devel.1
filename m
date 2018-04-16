Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f82fD-0002vA-8p
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f82fC-0001fo-7Q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:51:15 -0400
References: <20180406151731.4285-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <55f6042f-f077-1860-877f-adb57db254ad@redhat.com>
Date: Mon, 16 Apr 2018 13:51:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180406151731.4285-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MF5DYTBD9RwXiVe7j9l1PWoJCPNfCHMEu"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Skip 181 and 201 without
 userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MF5DYTBD9RwXiVe7j9l1PWoJCPNfCHMEu
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <55f6042f-f077-1860-877f-adb57db254ad@redhat.com>
Subject: Re: [PATCH 0/2] iotests: Skip 181 and 201 without userfaultfd
References: <20180406151731.4285-1-mreitz@redhat.com>
In-Reply-To: <20180406151731.4285-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-06 17:17, Max Reitz wrote:
> My non-Fedora testing system does not have a kernel with userfaultfd
> support which causes 181 and 201 to fail.  That is annoying.  This
> series makes those tests recognize the issue and convert it into a
> _notrun.
>=20
>=20
> Max Reitz (2):
>   iotests: Add failure matching to common.qemu
>   iotests: Skip 181 and 201 without userfaultfd
>=20
>  tests/qemu-iotests/181         | 13 ++++++++++
>  tests/qemu-iotests/201         | 13 ++++++++++
>  tests/qemu-iotests/common.qemu | 58 ++++++++++++++++++++++++++++++++++=
+++-----
>  3 files changed, 77 insertions(+), 7 deletions(-)

Ping (considering these are test suite fixes, I'd merge them without
review, too, though.)

Max


--MF5DYTBD9RwXiVe7j9l1PWoJCPNfCHMEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrUjigACgkQ9AfbAGHV
z0BRJwf/WcUCAbnK58SCuyhjH9P7uyqDePseUJExywAO2mrbhK3OKW/w0a8Jv+Q9
um0ZuFUxJ3god+IB17l499Wj03Lr9ZThn98g+B55tH/fdFOBvYl1qNdkJ5FFDkHo
11F9sn9f9sskY6viSzmz2jtDNz0TQHcFNOpHFPgUQeINMg8c0pUoNqEbtltNK8EX
lJq7udaCE/WPWAvmBwpNPxCOiTqlJP+5dg07XSdnNMg+hd/L14cQ9tecUTl+FjlV
/jiyGb4KmSQqKD2yf2+IFFedzKOPyMzW+ldQzjKN+d9G7rH+o8qhrO+1KYUVKQoh
Hfmc1rmUFJfDD+ee3fL7yqzgYC3LPg==
=gOpT
-----END PGP SIGNATURE-----

--MF5DYTBD9RwXiVe7j9l1PWoJCPNfCHMEu--
