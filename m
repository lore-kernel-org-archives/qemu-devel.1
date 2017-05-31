Received: from eggs.gnu.org ([2001:4830:134:3::10]:55034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5kZ-0008MM-E6
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5kY-0008S8-Jq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:41:31 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <de149152-b4a6-45fa-f081-b6579a228ae5@redhat.com>
Date: Wed, 31 May 2017 17:41:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170509173342.29286-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KGf2txnkVRvkM5EEgdKMdEOAl2lCtMaIq"
Subject: Re: [Qemu-devel] [PATCH v5 3/5] iotests: reduce PBKDF iterations
 when testing LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KGf2txnkVRvkM5EEgdKMdEOAl2lCtMaIq
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <de149152-b4a6-45fa-f081-b6579a228ae5@redhat.com>
Subject: Re: [PATCH v5 3/5] iotests: reduce PBKDF iterations when testing LUKS
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-4-berrange@redhat.com>
In-Reply-To: <20170509173342.29286-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-09 19:33, Daniel P. Berrange wrote:
> By default the PBKDF algorithm used with LUKS is tuned
> based on the number of iterations to produce 1 second
> of running time. This makes running the I/O test with
> the LUKS format orders of magnitude slower than with
> qcow2/raw formats.
>=20
> When creating LUKS images, set the iteration time to
> a 10ms to reduce the time overhead for LUKS, since
> security does not matter in I/O tests.
>=20
> Previously a full 'check -luks' would take
>=20
>   $ time ./check -luks
>   Passed all 22 tests
>=20
>   real  23m9.988s
>   user  21m46.223s
>   sys   0m22.841s
>=20
> Now it takes
>=20
>   $ time ./check -luks
>   Passed all 22 tests
>=20
>   real  4m39.235s
>   user  3m29.590s
>   sys   0m24.234s
>=20
> Still slow compared to qcow2/raw, but much improved
> none the less.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/149           |   3 +
>  tests/qemu-iotests/149.out       | 118 +++++++++++++++++++------------=
--------
>  tests/qemu-iotests/common.filter |   3 +-
>  tests/qemu-iotests/common.rc     |   3 +
>  4 files changed, 67 insertions(+), 60 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--KGf2txnkVRvkM5EEgdKMdEOAl2lCtMaIq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLuQfEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJDl
B/4t0ZfvacxhkzvqmwmDBW3ORZglB70kvzGY9JKHP9RKP9ChCpCsAzPJElNF26tN
boCaXbOBP/A1DePm311bakRI1C5/7wJnJCEb2VZM+7P/NOX3OYJmm16onAQAl9pw
tJ/sDSbKfVgk5JXk+9Luhc+gNF/I0qcAUc7PtCbnoZnges0d1IjnX/7nSll9ndFF
mMRrQHMgRqH4w80oMdKWs/OxI3VPZFvmhA/PsskpNaCfveUwzSumFyfxgFruUeYu
RY14qiDVwyTweLXQIjvCXLds4ejtV4rrBGkee1aIAjvg0lsG0X1WYIq2p6awrz8A
rs6v7kFNzEp6QizmK/xe7KPo
=ioPp
-----END PGP SIGNATURE-----

--KGf2txnkVRvkM5EEgdKMdEOAl2lCtMaIq--
