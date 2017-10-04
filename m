Received: from eggs.gnu.org ([2001:4830:134:3::10]:52252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzr3T-0008Gm-JW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzr3S-0000OE-R9
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:18:11 -0400
References: <20171004152553.30263-1-mreitz@redhat.com>
	<20171004152553.30263-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5419c3f4-d78d-061b-03d0-15e8c06b5b55@redhat.com>
Date: Wed, 4 Oct 2017 16:18:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171004152553.30263-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="03QRXIUwH3HSax5tmvnBkKKvaUrxc04ux"
Subject: Re: [Qemu-devel] [PATCH v6 6/6] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--03QRXIUwH3HSax5tmvnBkKKvaUrxc04ux
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <5419c3f4-d78d-061b-03d0-15e8c06b5b55@redhat.com>
Subject: Re: [PATCH v6 6/6] tests: Add check-qobject for equality tests
References: <20171004152553.30263-1-mreitz@redhat.com>
 <20171004152553.30263-7-mreitz@redhat.com>
In-Reply-To: <20171004152553.30263-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 10:25 AM, Max Reitz wrote:
> Add a new test file (check-qobject.c) for unit tests that concern
> QObjects as a whole.
>=20
> Its only purpose for now is to test the qobject_is_equal() function.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/Makefile.include |   4 +-
>  tests/check-qobject.c  | 325 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/.gitignore       |   1 +
>  3 files changed, 329 insertions(+), 1 deletion(-)
>  create mode 100644 tests/check-qobject.c

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--03QRXIUwH3HSax5tmvnBkKKvaUrxc04ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnVUAsACgkQp6FrSiUn
Q2pNJwgAjf+0okiDGSVNERVTYxeKoRkaQ5/VsbtfLXd+97l1LyaHPKJlIvtLW9Sw
How3+56lyavkK33FVjU3DdPPSa0nGMU9KDHvVBvhH1G0IKOgVgnxmutMI25+cSAn
XB63AOHG4IkklE4tmIsZ9LTIpt5OZQoaptfRZqor4dpFVED2R7+wUqIx/C0uUc/E
/Kfm3QlS97IQmKlXwNwfoUtlgaIhYlQVHjXc+dfF/0d3GAdJklmLmCwlvg3VTOsO
6VN6yMs1t4rj9qd6I0d3dKAQx6UTU0TTvmowFZi5XSdjlCP5pCU880LTRo4k4wY/
Vxxaxv1/JtDNmPKpk7ImExBWM0m5fA==
=XRnH
-----END PGP SIGNATURE-----

--03QRXIUwH3HSax5tmvnBkKKvaUrxc04ux--
