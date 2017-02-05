Received: from eggs.gnu.org ([2001:4830:134:3::10]:57000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUmZ-0007Ee-AU
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUmY-0000ZI-LB
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:55:39 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-5-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <793ed5e9-0970-35f0-eb59-e2dc73c46956@redhat.com>
Date: Sun, 5 Feb 2017 22:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-5-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GaV0AqxAoQptClIMVMb7R9mD8UcAkImh1"
Subject: Re: [Qemu-devel] [PATCH v12 04/16] qemu-img: Set "share-rw" flag in
 read-only commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GaV0AqxAoQptClIMVMb7R9mD8UcAkImh1
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <793ed5e9-0970-35f0-eb59-e2dc73c46956@redhat.com>
Subject: Re: [PATCH v12 04/16] qemu-img: Set "share-rw" flag in read-only
 commands
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-5-famz@redhat.com>
In-Reply-To: <20170123123056.30383-5-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Checking the status of an image when it is being used by guest is
> usually useful, and there is no risk of corrupting data, so don't let
> the upcoming image locking feature limit this use case.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GaV0AqxAoQptClIMVMb7R9mD8UcAkImh1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXn1ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ay5EIAKoVGcbCt4YBxIL1n1nN86lN4Z0foFWE
pJkPYbfFlHCOSXrpYHNc68nUbNdrN+npZ+JW5L5YMEKFWuJyFEM5/HflsMlWfU0i
kq1e84hQ2BcHkL4MZocnRLVTKyICeUcnEeu0Dd/wyJfoRIYDATNiQy7LqlFa9JMp
ZNXGJUH/DdnTbZyPkFi8+9O4Y+XyDLwxfCBX+5NW50XICQlwpvmXGslbCwIpuYHw
lqvGYu/jfUxjbmDW6AixPiTxwCdPC20OJFmyX+NisA8k838OSfTNK3+3Ff+KLIGV
bPJlEWKpEbqNCwCTIiItJWvAqXRVSjjDj9fvPrb8MPVnUX0Ck+KhsfM=
=V+AK
-----END PGP SIGNATURE-----

--GaV0AqxAoQptClIMVMb7R9mD8UcAkImh1--
