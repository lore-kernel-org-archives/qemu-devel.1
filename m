Received: from eggs.gnu.org ([2001:4830:134:3::10]:51877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4cmJ-0001nh-Pq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 21:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4cmI-0006gE-RM
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 21:04:11 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<399631b6632f0a605339391ff76c90468ebd54ee.1508257445.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9eec2de6-5b7d-0450-8882-d2606d24fc0e@redhat.com>
Date: Tue, 17 Oct 2017 20:03:56 -0500
MIME-Version: 1.0
In-Reply-To: <399631b6632f0a605339391ff76c90468ebd54ee.1508257445.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nwbOdbwSbIwmFxpvnkVOdSj19RFp5hTCT"
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu-iotests: refuse to run if
 TEST_DIR contains spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nwbOdbwSbIwmFxpvnkVOdSj19RFp5hTCT
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Message-ID: <9eec2de6-5b7d-0450-8882-d2606d24fc0e@redhat.com>
Subject: Re: [PATCH v5 01/10] qemu-iotests: refuse to run if TEST_DIR contains
 spaces
References: <cover.1508257445.git.jcody@redhat.com>
 <399631b6632f0a605339391ff76c90468ebd54ee.1508257445.git.jcody@redhat.com>
In-Reply-To: <399631b6632f0a605339391ff76c90468ebd54ee.1508257445.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 11:31 AM, Jeff Cody wrote:
> Currently, not all qemu-iotests work if TEST_DIR has spaces, and they
> also might not be safe.  Refuse to run if TEST_DIR in this case, at
> least until all tests are fixed sometime in the future.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e6b6ff7..e2163cc 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -102,6 +102,14 @@ if [ -z "$TEST_DIR" ]; then
>          TEST_DIR=3D`pwd`/scratch
>  fi
> =20
> +case $TEST_DIR in
> +    *[[:blank:]]*)
> +        echo "The TEST_DIR pathname '$TEST_DIR' contains whitespace. "=


Echoes a trailing space. Do we care?

> +        echo "This is currently unsupported by qemu-iotests"

Is it just whitespace, or should we also be wary of other shell
metacharacters (such as quotes or glob characters)?  In test 197, I did
an alternative check for anything that is not alphanumeric, -, or _ (and
allowing / between names).

> +        exit 1
> +        ;;
> +esac
> +
>  if [ ! -e "$TEST_DIR" ]; then
>          mkdir "$TEST_DIR"
>  fi
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nwbOdbwSbIwmFxpvnkVOdSj19RFp5hTCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnmqHwACgkQp6FrSiUn
Q2rjNQf/aAjYM9TB3HhK8fUkxlduFL0uUxWnGFZXT8xpYJTvfsPX99cJMVvEKrLB
eQInZL1sI7w0aAB5Pt3HHBKHFlewYqJkBZYfP0mgr7AaW7UiuzCq0WgDaiEThyOF
aTEpQ0udiRUfwqmTyoQKlGSdn+pfkK6ejCYoXM7Pil5PiGb5M2TuCErmYTI5j01d
Lq/TAYxNEdiGPGmITjNhMA+nkztMFYk6qPQycwgTN55BFwIdluAe7piR4muNZfsH
bt83GAhtS0O5yDBXVDFWEMHbymVjbN+/HtYPJzP3B3J85k9mlKvSvqCJ0geWBWfB
3GKHxZND9wqt8xy3B+S+BOdwKLxcGg==
=aDJ4
-----END PGP SIGNATURE-----

--nwbOdbwSbIwmFxpvnkVOdSj19RFp5hTCT--
