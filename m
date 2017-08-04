Received: from eggs.gnu.org ([2001:4830:134:3::10]:40583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddYr-0004IP-5g
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddbM8-0005VN-E1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:06:34 -0400
References: <20170804105036.11879-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <478d9f3b-792c-2999-4443-537fcc5b456b@redhat.com>
Date: Fri, 4 Aug 2017 07:04:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170804105036.11879-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ft26TM4Ij1OPhpikXcEe2cTODqKXlj4j6"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block: move trace
 probes into bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ft26TM4Ij1OPhpikXcEe2cTODqKXlj4j6
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <478d9f3b-792c-2999-4443-537fcc5b456b@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10] block: move trace probes into
 bdrv_co_preadv|pwritev
References: <20170804105036.11879-1-berrange@redhat.com>
In-Reply-To: <20170804105036.11879-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 05:50 AM, Daniel P. Berrange wrote:
> There are trace probes in bdrv_co_readv|writev, however, the
> block drivers are being gradually moved over to using the
> bdrv_co_preadv|pwritev functions instead. As a result some
> block drivers miss the current probes. Move the probes
> into bdrv_co_preadv|pwritev instead, so that they are triggered
> by more (all?) I/O code paths.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/io.c         | 8 ++++----
>  block/trace-events | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Arguably, the traces are broken, so this is a bug fix worthy of 2.10.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ft26TM4Ij1OPhpikXcEe2cTODqKXlj4j6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEYrwACgkQp6FrSiUn
Q2roKAf/X6SZOD67pXleY9AJkr9bgb6sIMP4MQ3djOAP83Q2BoIWZ/Y0u45iTOI4
i1lDqRpeA7YyARHU6nq7IAafBRLRrAoVWbttXEVDGNfRdNoktJxOckPAXdVWiF/L
g4728nRuV+GYKeDDZ2b/Au6BGzSIrS0DAIxnrB+3/+0XhneysPj5YbLhT3cd6KI2
/hqrWIaRDrVan9kehIf/o0Ip3vBr3eHdCoo+tDH9SSh5/Afi6c7Pz/H8HT4IbhGB
gt+mV1S3Tk5/kNM3A6uJEuh9g7WK56yYNkJ/ujjD1QvZBSWA3g9/hmmgbXw94/Oe
F0q5yrdssxH3qyIEz9tmqQ0ey6yngQ==
=LG//
-----END PGP SIGNATURE-----

--ft26TM4Ij1OPhpikXcEe2cTODqKXlj4j6--
