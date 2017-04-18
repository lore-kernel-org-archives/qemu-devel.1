Received: from eggs.gnu.org ([2001:4830:134:3::10]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Y7R-0007f4-88
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Y7Q-0007re-8I
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:44:53 -0400
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
Date: Tue, 18 Apr 2017 13:44:43 -0500
MIME-Version: 1.0
In-Reply-To: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c2UuN0pvBlqKCsIlfL107fvW2bqHu2Bvx"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/1] qemu-iotests:
 _cleanup_qemu must be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c2UuN0pvBlqKCsIlfL107fvW2bqHu2Bvx
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
Subject: Re: [PATCH v2 for-2.10 1/1] qemu-iotests: _cleanup_qemu must be
 called on exit
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
In-Reply-To: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 12:45 PM, Jeff Cody wrote:
> For the tests that use the common.qemu functions for running a QEMU
> process, _cleanup_qemu must be called in the exit function.
>=20
> If it is not, if the qemu process aborts, then not all of the droppings=

> are cleaned up (e.g. pidfile, fifos).
>=20
> This updates those tests that did not have a cleanup in qemu-iotests.
>=20
> (I swapped spaces for tabs in test 102 as well)
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>=20
> v2 fixed typo in test 094, s/cleanup/_cleanup/ for the trap function.
>=20
>  tests/qemu-iotests/028 |  1 +
>  tests/qemu-iotests/094 | 11 ++++++++---
>  tests/qemu-iotests/102 |  5 +++--
>  tests/qemu-iotests/109 |  1 +
>  tests/qemu-iotests/117 |  1 +
>  tests/qemu-iotests/130 |  1 +
>  tests/qemu-iotests/140 |  1 +
>  tests/qemu-iotests/141 |  1 +
>  tests/qemu-iotests/143 |  1 +
>  9 files changed, 18 insertions(+), 5 deletions(-)

Looks like you missed (at least?) 063

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--c2UuN0pvBlqKCsIlfL107fvW2bqHu2Bvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9l6bAAoJEKeha0olJ0Nq+qkH/1vzfMQV7okvnYC3scyIb19x
/MHEKdXGs7wHiJNJszsrEacJ4Sb2eRFCqs2cJX+oCnXF1p5Bvc2FIzTj3pSrfgfC
UKU+Wo1y4LYFHWoGClgxy0UKzdyC1/Nqh7UaPi3ms5mRFhDvSscVMjMXiT+T0Ggz
nliRU7NfXkbL3N5GGQ9h38Mb25YYHcBDqckIU1WQOL2uX/6zW6jZNGKq0E6zi6wa
/X2U7NeXJYtfOgjZ81ZIjnTH0g1gL/GHg01olV2I8vYRZDhJ3oa7JRvgBlaKcqOc
l4t6F1UeHchB6Gtlf8WKZ4YF8xNpRDvW3fKswzBiEimJv/Kw6WACtHJ6wouhivU=
=tU96
-----END PGP SIGNATURE-----

--c2UuN0pvBlqKCsIlfL107fvW2bqHu2Bvx--
