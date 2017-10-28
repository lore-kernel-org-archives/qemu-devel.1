Received: from eggs.gnu.org ([2001:4830:134:3::10]:49191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K8w-00082V-2D
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K8s-00070T-55
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8K8r-0006yR-Sr
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:58:46 -0400
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-5-berrange@redhat.com>
	<f440be99-e1dc-267f-50fd-52d03533f62a@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2372c0e-86dc-1d94-2509-ae3860cf7044@redhat.com>
Date: Sat, 28 Oct 2017 07:58:37 +0200
MIME-Version: 1.0
In-Reply-To: <f440be99-e1dc-267f-50fd-52d03533f62a@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gfCV4V1JPvd8S481Du3nSw8uIGiBrueRC"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] build: don't fail if given a git
 submodule which does not exist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gfCV4V1JPvd8S481Du3nSw8uIGiBrueRC
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2372c0e-86dc-1d94-2509-ae3860cf7044@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] build: don't fail if given a git
 submodule which does not exist
References: <20171027131412.18830-1-berrange@redhat.com>
 <20171027131412.18830-5-berrange@redhat.com>
 <f440be99-e1dc-267f-50fd-52d03533f62a@ozlabs.ru>
In-Reply-To: <f440be99-e1dc-267f-50fd-52d03533f62a@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/28/2017 03:27 AM, Alexey Kardashevskiy wrote:
> On 28/10/17 00:14, Daniel P. Berrange wrote:
>> If going back in time in git history, across a commit that introduces =
a new
>> submodule, the 'git-submodule.sh' script will fail, causing rebuild to=
 fail.
>>

>> +do
>> +    $GIT submodule status $m 1> /dev/null 2>&1
>> +    if test $? =3D=3D 0
>=20
>=20
> ./scripts/git-submodule.sh: 29: test: 0: unexpected operator

Ah, right, =3D=3D is a bashism.

>=20
> This helps:
>=20
> -    if test $? =3D=3D 0
> +    if test "$?" -eq "0"

Or 'if test $? =3D 0'

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gfCV4V1JPvd8S481Du3nSw8uIGiBrueRC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln0HI0ACgkQp6FrSiUn
Q2pjBAgAmVnF/jWGTwo4+gqXXylv3stlV33eptDZvTv+NlS2lp20jW52Ua3jdYFC
aj2Met7ogcgQeJzcKlyuj2Ij3PZPHgVt39haTwa5TenYeNzn0hnI4qVE+T92QUqz
LhPf3qGOS5CQeK39RRdpZGKOtm3Sh492hyQlLJYDVPH5ieKISHdy/2U1jvogmOa8
y4FWXFEKamgcADMb2xNN8OaRSCzJOSsDuMbFupUIuX9A7/jDORyyULIbqRROxECp
/geeBTi0hiTgNNhwLQPiFoMo4QQlx3i5sxNx3UecqDAKDq+yn0NFThMiY3fFHNUI
73aDNZ0K9oeRvdeXIjEgcU5/lYJR4Q==
=xBI/
-----END PGP SIGNATURE-----

--gfCV4V1JPvd8S481Du3nSw8uIGiBrueRC--
