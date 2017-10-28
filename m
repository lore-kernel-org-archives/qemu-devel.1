Received: from eggs.gnu.org ([2001:4830:134:3::10]:45875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0V-0004g7-Jt
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0R-0000eb-Nu
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8K0R-0000dp-FW
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:03 -0400
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c287efce-4926-32dd-b591-e02ad5edf8fc@redhat.com>
Date: Sat, 28 Oct 2017 07:25:34 +0200
MIME-Version: 1.0
In-Reply-To: <20171027131412.18830-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ViLx1rTx7bax37102S8PLwTABQjfgwJ8d"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] build: don't create temporary files
 in source dir
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
--ViLx1rTx7bax37102S8PLwTABQjfgwJ8d
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c287efce-4926-32dd-b591-e02ad5edf8fc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] build: don't create temporary files
 in source dir
References: <20171027131412.18830-1-berrange@redhat.com>
 <20171027131412.18830-3-berrange@redhat.com>
In-Reply-To: <20171027131412.18830-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 03:14 PM, Daniel P. Berrange wrote:
> There are cases where users do VPATH builds with the source directory b=
eing on
> a read-only volume. In such a case they have to manually run the comman=
d
> 'git-submodule.sh ...modules...'  manually ahead of time. When checking=
 for

One of the two "manually" can be removed (either one, and the sentence
still makes sense)

> status we should not then write into the source dir.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index c66567d409..586ff32293 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -31,10 +31,10 @@ fi
>  case "$command" in
>  status)
>      test -f "$substat" || exit 1
> -    trap "rm -f ${substat}.tmp" EXIT
> -    $GIT submodule status $modules > "${substat}.tmp"
> -    test $? -ne 0 && error "failed to query git submodule status"
> -    diff "${substat}" "${substat}.tmp" >/dev/null
> +    substat_tmp=3D$(mktemp)

Is mktemp portable enough?  Hopefully so.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ViLx1rTx7bax37102S8PLwTABQjfgwJ8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln0FM4ACgkQp6FrSiUn
Q2qIBgf9HKdti2U2v7ofdf+CRc5qTfxCS+SP49N4XXigOHXkIdz8z1fysQZktG0/
dvwaVnJNXjAthY7IS5R3G5jlTHXn4cktrakvVw9rrWlsHFEKZLNpePKn9zSPS8ke
Cmr9LwbzwHFKARB2pmfoay8Jpl8i77IhXFNEc3P+ExIw80x7nNQTxl2SGhF673c0
kDi8Q0Kcy+iSrgM6qeY9Q4oh+C+YhgZQ0Nw3ZGigPOAQfDaEzenTWuJzfq0uNxJR
OWnCZ1AcrWg17j+jw4RMdkuEQHiH78FHPOSZgfChS0xpVGgQBGSafXZo4BTn6SpD
JrKAWo2gi4ep+MfUSubJQxMXCa/L7A==
=qNBS
-----END PGP SIGNATURE-----

--ViLx1rTx7bax37102S8PLwTABQjfgwJ8d--
