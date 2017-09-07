Received: from eggs.gnu.org ([2001:4830:134:3::10]:54037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpxk0-0005V6-KQ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpxjq-000107-NZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpxjq-0000zf-H7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:25:02 -0400
References: <20170907141245.31946-1-famz@redhat.com>
	<20170907141245.31946-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2d4ea72-f64c-517d-046b-b5dbd0705b22@redhat.com>
Date: Thu, 7 Sep 2017 09:24:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170907141245.31946-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4x2GJmfk7qpDe62evGFBHDql9GaggjXV0"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docker: Enable features explicitly
 in test-full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4x2GJmfk7qpDe62evGFBHDql9GaggjXV0
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c2d4ea72-f64c-517d-046b-b5dbd0705b22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docker: Enable features explicitly in
 test-full
References: <20170907141245.31946-1-famz@redhat.com>
 <20170907141245.31946-3-famz@redhat.com>
In-Reply-To: <20170907141245.31946-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2017 09:12 AM, Fam Zheng wrote:
> Also avoid "set -e".
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-full | 82 ++++++++++++++++++++++++++++++++++++++++++=
++++----
>  1 file changed, 76 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4x2GJmfk7qpDe62evGFBHDql9GaggjXV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxVrgACgkQp6FrSiUn
Q2qkCQf/ZLnNb4ODRmz8mP/USS6Lu2W8kjY8qmwdZHVaNqYrcKgKp8WqXxmZm0TB
aBGLUxlluLPUqnmrYxTrBWg9ajaNTKKwG+GbQFPqmkHp5euoQV9AdIBi74CIfHU8
Inx7iVwB0lXjcelcVnDGPn3WTZrI5Ve1iQRXFdDt9EKpL4FdymWrceA8n8EZTNKK
Z9072zIdh2g6+F9U6RFvQynCk06FVfxu6so80gYUrWwTfVjZoVB6D1q1yzyosl/I
NidaqRGILBJ3d3YqXH9YNSujPSx9heo0pEkgxsjenjrfHQHyhpQJDaxBiZXwnzyk
sgNqA6iXybp5RY4Yfp8ImOx/82v0AA==
=CYLx
-----END PGP SIGNATURE-----

--4x2GJmfk7qpDe62evGFBHDql9GaggjXV0--
