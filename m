Received: from eggs.gnu.org ([2001:4830:134:3::10]:45892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0W-0004iD-VC
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0W-0000in-7a
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8K0V-0000hv-Ua
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:08 -0400
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c601a875-8133-727a-c0f0-d8727059b9c6@redhat.com>
Date: Sat, 28 Oct 2017 07:28:11 +0200
MIME-Version: 1.0
In-Reply-To: <20171027131412.18830-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CGUx7OlMPX7WE4K0Nj2M9LipLJLVk2ivb"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] build: allow automatic git
 submodule updates to be disabled
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
--CGUx7OlMPX7WE4K0Nj2M9LipLJLVk2ivb
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c601a875-8133-727a-c0f0-d8727059b9c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] build: allow automatic git submodule
 updates to be disabled
References: <20171027131412.18830-1-berrange@redhat.com>
 <20171027131412.18830-4-berrange@redhat.com>
In-Reply-To: <20171027131412.18830-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 03:14 PM, Daniel P. Berrange wrote:
> Some people building QEMU use VPATH builds where the source directory i=
s on a
> read-only volume. In such a case 'scripts/git-submodules.sh update' wil=
l always
> fail and users are required to run it manually themselves on their orig=
inal
> writable source directory.
>=20

> @@ -1297,11 +1299,15 @@ for opt do
>    ;;
>    --with-git=3D*) git=3D"$optarg"
>    ;;
> +  --enable-git-update) git_update=3Dyes
> +  ;;
> +  --disable-git-update) git_update=3Dno
> +  ;;

Consistent, which makes...

>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
>        exit 1
> -  ;;
> +      ;;

=2E..this an unrelated whitespace change?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CGUx7OlMPX7WE4K0Nj2M9LipLJLVk2ivb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln0FWsACgkQp6FrSiUn
Q2pgRggAqD94omShHP+9KIg+B0cATB73LCqLJ9ixafgljB/qt54iZGajt3FUXc2Y
8bRPp0WOlrCkjBEAx3Tvtdr5Rj6oTC45xFQVkiX3afQ9i0jjhAH7VFf84GvPsOTL
L11/X94e/OHFuCNQ4vplqz/XPmIFOQVZgno7fvQ+m9L74PzxKGri+dO4WDwn3nbw
PBlbpYQcyn7ewfsDWKWhZJOVln1tlAxy8xEygDGOGXZHl9/YJb8g9hWsvg6qPWvp
Yo4Dhk4qGT3ZI4W4xZv4RMhQ7IexB0/mP+e5poalU85aZ8cJdZ+EfaXG2ApOmMYm
CuAaAJmjFOsGklevuEq6iWBExwwKtQ==
=BOzm
-----END PGP SIGNATURE-----

--CGUx7OlMPX7WE4K0Nj2M9LipLJLVk2ivb--
