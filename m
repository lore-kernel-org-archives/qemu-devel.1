Received: from eggs.gnu.org ([2001:4830:134:3::10]:47486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPpzU-0007jm-AK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPpzT-0004kd-Ad
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:53:12 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-5-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dd6223f-5e14-ae0a-ba84-b94d2d64e09d@redhat.com>
Date: Tue, 27 Jun 2017 07:53:02 -0500
MIME-Version: 1.0
In-Reply-To: <1498566850-7934-5-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1puhRfpPHBfDlcP4udC6mfFIXg4XD0CkH"
Subject: Re: [Qemu-devel] [PATCH 4/4] block/qcow2: add zlib-fast compression
 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1puhRfpPHBfDlcP4udC6mfFIXg4XD0CkH
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com
Message-ID: <8dd6223f-5e14-ae0a-ba84-b94d2d64e09d@redhat.com>
Subject: Re: [PATCH 4/4] block/qcow2: add zlib-fast compression algorithm
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
 <1498566850-7934-5-git-send-email-pl@kamp.de>
In-Reply-To: <1498566850-7934-5-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2017 07:34 AM, Peter Lieven wrote:
> this adds support for optimized zlib settings which almost

Start sentences with a capital.

> tripples the compression speed while maintaining about

s/tripples/triples/

> the same compressed size.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2-cluster.c |  3 ++-
>  block/qcow2.c         | 11 +++++++++--
>  block/qcow2.h         |  1 +
>  qemu-img.texi         |  1 +
>  4 files changed, 13 insertions(+), 3 deletions(-)
>=20

> +++ b/block/qcow2.h
> @@ -173,6 +173,7 @@ typedef struct Qcow2UnknownHeaderExtension {
>  enum {
>      QCOW2_COMPRESSION_ZLIB          =3D 0xC0318301,
>      QCOW2_COMPRESSION_LZO           =3D 0xC0318302,
> +    QCOW2_COMPRESSION_ZLIB_FAST     =3D 0xC0318303,

Back to my comments on 1/4 - we MUST first get the qcow2 specification
right, rather than adding undocumented headers in the code.  And I still
think you only need one variable-length header extension for covering
all possible algorithms, rather than one header per algorithm.  Let's
get the spec right first, before worrying about the code implementing
the spec.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1puhRfpPHBfDlcP4udC6mfFIXg4XD0CkH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUlUuAAoJEKeha0olJ0NqAXUH/2XqclM0H6i9yLttRa7R8uqK
FtdlQQATtNfmGBqhYGKXqQOF99R/W7jXufVkaB/0nhBtfwUKknOLqc8FzfdtVEOP
FzAVNcDjXvVQUjVvMOxfTFPv79lwjBoRDvD53gQb6CXwMmyunlvqF+b2uqLmyqTz
hpdtQe1ZbhuklKK9LenSz+PTO691izTv+gu8kyFi6PjCFBjtC/fRI1bTm6kn18zW
9KMpb5/EeqK+UIuFk3v9nVrGVZ71UEGM2Un1vHuxYWI5Uc5zYuOBRb/ztsd+eBS/
B2lANpaexjJPHUz3vEjc6NygCuhkwLjbUVCL6ge9t0u/BQpOFbZ5PUX879sODVA=
=+eJH
-----END PGP SIGNATURE-----

--1puhRfpPHBfDlcP4udC6mfFIXg4XD0CkH--
