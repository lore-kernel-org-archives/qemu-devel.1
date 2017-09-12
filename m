Received: from eggs.gnu.org ([2001:4830:134:3::10]:36164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsh5-0006z1-Mq
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsh4-0007DK-K8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:26:07 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-8-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa875409-615c-ce28-c292-86a870c8c971@redhat.com>
Date: Tue, 12 Sep 2017 16:25:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-8-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o3sOgARMeNEICbEGe3CFPOrqqc2Dh0cWb"
Subject: Re: [Qemu-devel] [PATCH 07/10] qemu-iotests: disintegrate more
 parts of common.config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o3sOgARMeNEICbEGe3CFPOrqqc2Dh0cWb
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <aa875409-615c-ce28-c292-86a870c8c971@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] qemu-iotests: disintegrate more parts
 of common.config
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-8-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> Split "check" parts from tests part.
>=20
> For the directory setup, the actual computation of directories goes
> in "check", while the sanity checks go in the tests.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/common        | 24 ++++++++++++++++++++
>  tests/qemu-iotests/common.config | 49 --------------------------------=
--------
>  tests/qemu-iotests/common.qemu   |  1 +
>  tests/qemu-iotests/common.rc     | 25 ++++++++++++++++++++
>  4 files changed, 50 insertions(+), 49 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> index abacc24114..ee313af92f 100644
> --- a/tests/qemu-iotests/common
> +++ b/tests/qemu-iotests/common
> @@ -48,6 +48,14 @@ set_prog_path()
>      fi
>  }
> =20
> +if [ -z "$TEST_DIR" ]; then
> +        TEST_DIR=3D`pwd`/scratch

8-space indent looks odd compared to the rest of the file.

> @@ -153,6 +158,26 @@ else
>  fi
>  ORIG_TEST_IMG=3D"$TEST_IMG"
> =20
> +if [ -z "$TEST_DIR" ]; then
> +        TEST_DIR=3D`pwd`/scratch

We probably ought to clean things up to use $PWD instead of `pwd`
everywhere as a minor optimization (why fork, when bash already has the
right information for you?) - but that can be separate.

Split looks okay to me,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o3sOgARMeNEICbEGe3CFPOrqqc2Dh0cWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4UOYACgkQp6FrSiUn
Q2pQLAf/ThFrM01rz51WU2c7tZcMBuOvbr/qYNflIih4N1tuzzMlIvTNX+GpiFOj
8ymkLAlUxSaVFOOyOaz2VjuE/p6cIA7Kg30S49MchvyDWS7sSav6abiktdBCAQfx
YqPXa3k/WWhisfOyGDMkjDtCVx/md8Wy1GnYIXl+qqSP3fCFh9QFLN0JV1DYOta1
EOtHkbsFpqnGMoAFg/OgkKknFg2p6xDK6fj/DQERq+QLD68CBjMu2IsMdBptPU0e
FXvQSINIEWt8ZxwLWAsV8EROPWg0L04cIR5QEEDaRXC5+xnf8qG0gifrh1Uerqlz
6jGjgQXgNfWA8HY5QJkUQ/2iGMjYGg==
=/enM
-----END PGP SIGNATURE-----

--o3sOgARMeNEICbEGe3CFPOrqqc2Dh0cWb--
