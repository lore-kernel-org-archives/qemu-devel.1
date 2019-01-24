Received: from eggs.gnu.org ([209.51.188.92]:53323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmjVY-0000VP-Le
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmjVW-0003xu-Qx
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:13:44 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org> <87munqieiv.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f16734e0-1ec3-15e7-5a06-7b2c804c80a9@redhat.com>
Date: Thu, 24 Jan 2019 12:13:31 -0600
MIME-Version: 1.0
In-Reply-To: <87munqieiv.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3D2mFh5BTPnuzTcSbirLPosbvC5Yqptw1"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3D2mFh5BTPnuzTcSbirLPosbvC5Yqptw1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <f16734e0-1ec3-15e7-5a06-7b2c804c80a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org> <87munqieiv.fsf@dusky.pond.sub.org>
In-Reply-To: <87munqieiv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 3:35 AM, Markus Armbruster wrote:

>     To gauge the bug's impact, let's review non-interpolating users of =
this
>     parser, i.e. code passing NULL context to json_message_parser_init(=
):
>=20
>     * tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>       tests/test-visitor-serialization.c
>=20
>       Plenty of tests, but we still failed to cover the buggy case.
>=20
>     * monitor.c: QMP input
>=20
>     * qga/main.c: QGA input
>=20
>     * qobject_from_json():
>=20
>       - qobject-input-visitor.c: JSON command line option arguments of
>         -display and -blockdev
>=20
>         Reproducer: -blockdev '{"%"}'
>=20
>       - block.c: JSON pseudo-filenames starting with "json:"
>=20
>         Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=3D16682=
44#c3
>=20
>       - block/rbd.c: JSON key pairs
>=20
>         Pseudo-filenames starting with "rbd:".
>=20

Missed curl as being impacted. You'd have to do a v2 pull request to
mention it now...

https://bugzilla.redhat.com/show_bug.cgi?id=3D1668244

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3D2mFh5BTPnuzTcSbirLPosbvC5Yqptw1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxKAEsACgkQp6FrSiUn
Q2r5LAf9FbMvWnPHtHFnjwehJPAEyUXx5vc83/HELnumth4gRqXcCxB97CxUTSXP
b1ZEZhFVSd+Rms8smL2hIiUubEj1QziDtQcqePkPXD8M04Zqg1mJnJPwmO/TQWJt
C4ouk/z4a6NJlZZ4E9LoCHlzcGq8w4Yr/IjlccJ82qFNjFhk70vB72FkiwHxlpwj
2s+fnUcAl+Au2uMjp94H7m+KxuylkgXZs5EihB6Ev33KTpdDYB6NrvVYM6fSWNZs
qrBncXGChVQW+JqU1CvcT3PjujcIC1w0pVOW/sse0DGmZu4trmGDSR7E4CvdCC5o
4AVykdz8KT1BYEyXkjuYB2RKoEKZ5A==
=TkgS
-----END PGP SIGNATURE-----

--3D2mFh5BTPnuzTcSbirLPosbvC5Yqptw1--
