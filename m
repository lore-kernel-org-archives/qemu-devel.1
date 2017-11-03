Received: from eggs.gnu.org ([2001:4830:134:3::10]:54674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgqS-0003yu-45
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgqP-0006yJ-11
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAgqO-0006xN-Na
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:37:28 -0400
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b80e76fb-66ac-ac3b-5541-e4b81e11eb43@redhat.com>
Date: Fri, 3 Nov 2017 13:37:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bNN8MwIBqJ7WgUS0T8tmFqk4xkmGQ1WAS"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] build: delay check for empty git
 submodule list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bNN8MwIBqJ7WgUS0T8tmFqk4xkmGQ1WAS
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b80e76fb-66ac-ac3b-5541-e4b81e11eb43@redhat.com>
Subject: Re: [PATCH v3 5/5] build: delay check for empty git submodule list
References: <20171103153333.6416-1-berrange@redhat.com>
 <20171103153333.6416-6-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 10:33 AM, Daniel P. Berrange wrote:
> We short circuit the git submodule update when passed an empty module l=
ist.
> This accidentally causes the 'status' command to write to the status fi=
le. The
> test needs to be delayed into the individual commands to avoid this pre=
mature
> writing of the status file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bNN8MwIBqJ7WgUS0T8tmFqk4xkmGQ1WAS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8t2YACgkQp6FrSiUn
Q2pJpwgAnZLY3JfBeuu3J6fHwoDV7vp1YGuGoDFC56m+JUxIX7VnOSMSvtanfG1j
OWltSpYrsjg7ccE1ErwwQwCtWV/q8+uaAjgw2aB74YeTao2vLZoWNXZ/Sp1a+XDg
eppCqGRk6xjN0VPgPYs8UN1oSdlKaHJoFak/GpuVNGe0kAvtK44XvVxy84Ks8ml/
QQP0IuqtZCEJb6/Q9dcxlzVD3N3Gl09fZYOEGiVCjfwKoE88obtPpjTHMOMU252t
6TcspjxYLZJivzMSbwefvwzyipdR3K2+uXGE9xOwBb8iJvq3+uPawRHDA4Q0M3Tu
IOLOAicixqfodIUKwvL9/3toMtSg/Q==
=cK4X
-----END PGP SIGNATURE-----

--bNN8MwIBqJ7WgUS0T8tmFqk4xkmGQ1WAS--
