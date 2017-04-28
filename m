Received: from eggs.gnu.org ([2001:4830:134:3::10]:47502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4BxT-0002ma-DD
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4BxS-0001do-KE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:53:39 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-9-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f73dfa75-5a2c-234b-0eea-3ebe7dc7f507@redhat.com>
Date: Fri, 28 Apr 2017 21:53:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-9-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u3m6dtNtXr8uvJWG4fHN6AI2TfAatcjED"
Subject: Re: [Qemu-devel] [PATCH v10 08/17] qemu-io: Switch 'map' output to
 byte-based reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u3m6dtNtXr8uvJWG4fHN6AI2TfAatcjED
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <f73dfa75-5a2c-234b-0eea-3ebe7dc7f507@redhat.com>
Subject: Re: [PATCH v10 08/17] qemu-io: Switch 'map' output to byte-based
 reporting
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-9-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> Mixing byte offset and sector allocation counts is a bit
> confusing.  Also, reporting n/m sectors, where m decreases
> according to the remaining size of the file, isn't really
> adding any useful information.

Since this map doesn't leave out any range in the image file -- not
really, no. :-)

>                                 Update the output to use
> byte counts, and adjust the affected tests (./check -qcow2 102,
> ./check -vpc 146).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: rebase to updated test 179
> v9: new patch
> ---
>  qemu-io-cmds.c             |  5 ++---
>  tests/qemu-iotests/102.out |  4 ++--
>  tests/qemu-iotests/146.out | 30 +++++++++++++++---------------
>  tests/qemu-iotests/179.out | 22 +++++++++++-----------
>  4 files changed, 30 insertions(+), 31 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--u3m6dtNtXr8uvJWG4fHN6AI2TfAatcjED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDnbkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8rsH/35LOsA0sDRXACWUPpIcOVUh+julLlrQ
IGw2RwMRAqxSEONw9U5v1slWbqj2Y+EmpmjdEP9gFgQJ8XSsxYgJQOYrmEFPNo1k
LB4UC+LP7xJJvyK/b/5eMOzawj2/QRjB5OLXPR8D6XW5y74hxoDSHqZWN6ikMyJw
L666VGaRrcRLhAUb5GlCfrhM3hScMrqdtZhjpzUev9PPfr1oqVv5vzdu6+ALgdO4
zecXhoO8pvlpuaw8jKD6abC/kCfYJD8I4BZojyat3ttrXJwsIXJ04qFAyF98/No7
M3X5FvpnerLSUMC6DYICzioUCghcfOAAuqv5k1JtaiZ4N2yrTvOKRZY=
=fRKL
-----END PGP SIGNATURE-----

--u3m6dtNtXr8uvJWG4fHN6AI2TfAatcjED--
