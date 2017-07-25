Received: from eggs.gnu.org ([2001:4830:134:3::10]:57263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da0fm-0008HL-6X
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da0fj-00066H-1K
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da0fi-00065a-OZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:18:50 -0400
References: <20170725133425.436-1-alex.bennee@linaro.org>
	<20170725133425.436-7-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b04ec3b-dff4-1529-ea97-b82e2c32455d@redhat.com>
Date: Tue, 25 Jul 2017 09:18:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170725133425.436-7-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S8iDUNSgCG7rS3dMrMUTUgFUFblmXE8qF"
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 6/6] docker: reduce noise when
 building travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S8iDUNSgCG7rS3dMrMUTUgFUFblmXE8qF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0b04ec3b-dff4-1529-ea97-b82e2c32455d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 6/6] docker: reduce noise when
 building travis.docker
References: <20170725133425.436-1-alex.bennee@linaro.org>
 <20170725133425.436-7-alex.bennee@linaro.org>
In-Reply-To: <20170725133425.436-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 08:34 AM, Alex Benn=C3=A9e wrote:
> Set the DEBIAN_FRONTEND and locale env vars to stop apt complaining so
> much as we build the image.
>=20
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/travis.docker | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dock=
erfiles/travis.docker
> index 57ac8e1419..605b6e429b 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -1,4 +1,7 @@
>  FROM quay.io/travisci/travis-ruby
> +ENV DEBIAN_FRONTEND noninteractive
> +ENV LANG en_US.UTF-8
> +ENV LC_ALL en_US.UTF-8

LANG is pointless if LC_ALL is set, as LC_ALL takes precedence.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--S8iDUNSgCG7rS3dMrMUTUgFUFblmXE8qF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3U0MACgkQp6FrSiUn
Q2q5bAf/d3w/zjM3LKJjY6C0llCii0Y/KBH2hFMKeVDxG8b6gKeDuaeF4JHyd/1q
nkr4Fza/tup3kXo5aHqk2n6FCrLiaye0FWaayygUa4sihMjz7eWWrjKbCOljJGVW
Tl+RU+EDRF1rlsRlcN3qDEeE7Bz9Cln1cQWAxF6qJ9jRaAEHMTSwWZi++ioKjy29
GvyZUDa0Df6ntMpKj1+6TpiVCUHgL4ANbuEh6vvXaJZ6wvBMlPm1Em7MaDsYaFtW
+JtPy54Re1Y1N6ei0FaDEOtCkX21lDDbq8aj4Jl1nHURWxlZBaTC/64LX/fS763X
pH25gggOzXMrdRm9ofgGt03bayEbYw==
=+mEE
-----END PGP SIGNATURE-----

--S8iDUNSgCG7rS3dMrMUTUgFUFblmXE8qF--
