Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFuL-0003AY-Oh
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFuK-00066N-Tk
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:29 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e0c69c9d-199d-6ee2-9b10-1d77adc514ea@redhat.com>
Date: Sat, 16 Sep 2017 18:25:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="frj6fnd4rdbfNpXe5ksRIINTJWj3G7EHS"
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block: use 1 MB bounce buffers for
 crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--frj6fnd4rdbfNpXe5ksRIINTJWj3G7EHS
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <e0c69c9d-199d-6ee2-9b10-1d77adc514ea@redhat.com>
Subject: Re: [PATCH v3 1/7] block: use 1 MB bounce buffers for crypto instead
 of 16KB
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-2-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> Using 16KB bounce buffers creates a significant performance
> penalty for I/O to encrypted volumes on storage which high
> I/O latency (rotating rust & network drives), because it
> triggers lots of fairly small I/O operations.
>=20
> On tests with rotating rust, and cache=3Dnone|directsync,
> write speed increased from 2MiB/s to 32MiB/s, on a par
> with that achieved by the in-kernel luks driver. With
> other cache modes the in-kernel driver is still notably
> faster because it is able to report completion of the
> I/O request before any encryption is done, while the
> in-QEMU driver must encrypt the data before completion.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--frj6fnd4rdbfNpXe5ksRIINTJWj3G7EHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9UG8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADncIALQ69xtviQVAvucTMXjnpuZ0YyNqXRC3
gfz8MS5Yis/ZDuTdtmaO7NsUZKBdtCJfljgPlqFrzaZmElqDanFKwu8gkIrTakTy
vIwaKIzgA2oIvLOIcGpQzoo4feItJTVSiPaFNFkiXmcIZ4OFASWcm8lNcY9J2xA7
sPAtFWCM4wLXpfxNwUaLQNZ6+4tMn8Ou1ixcy/FQz0Rm0Rljy/ibOKo4COZjFruf
THrD16Zk2ZtSPwIeaezSt9y3CLyvl0AsOBlZf5SZhKTpnnkMnKsbv5+nRF5ViJO9
PA3Nz27+NbcNmHtmBiT8RiLwYxulOIixd/Y88Ng8dvGks9WsZjIFa88=
=JzQC
-----END PGP SIGNATURE-----

--frj6fnd4rdbfNpXe5ksRIINTJWj3G7EHS--
