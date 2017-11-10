Received: from eggs.gnu.org ([2001:4830:134:3::10]:60802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDGNr-0005uU-PH
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDGNq-0000lW-TG
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:58:39 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ad2ad20-9b88-9c1f-ffca-ffb2d2d62f2c@redhat.com>
Date: Fri, 10 Nov 2017 14:58:27 -0600
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BpU7DK5dadtdojLLppWfUKQ4KK56gWgWS"
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/5] qcow2: Unaligned zero cluster
 in handle_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BpU7DK5dadtdojLLppWfUKQ4KK56gWgWS
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <0ad2ad20-9b88-9c1f-ffca-ffb2d2d62f2c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/5] qcow2: Unaligned zero cluster
 in handle_alloc()
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-3-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 02:31 PM, Max Reitz wrote:
> We should check whether the cluster offset we are about to use is
> actually valid; that is, whether it is aligned to cluster boundaries.
>=20
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728643
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728657
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cluster.c      | 13 ++++++++++++-
>  tests/qemu-iotests/060     | 16 ++++++++++++++++
>  tests/qemu-iotests/060.out | 10 ++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BpU7DK5dadtdojLLppWfUKQ4KK56gWgWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGEvMACgkQp6FrSiUn
Q2oEYgf9Gr+smIx+E1ZldqC0G/SatEFNfqLsD8gWMlOqyFm2cwkwbq9Vy9cfyv2P
aScCAb9+twjGlQNDQcpEqN13OFU97u+WXQf/ln4+x6bsEDJewsrk2xB7pvByPr3w
MPSBeQXmNf2ui5TTFRVe3U+z2z25tBWPfymj4Mt30wL6It9MPmGgA6diLhpBcxNS
GTg7Q43lwN4Od1i0vjO2v1odNt2Q6QXTmSgFym3uI04BLrtFUigQarXxojGVnGmh
y2LY+Jv5z+MDg0nZqDvKVs3KMdcIFziUw8r++KLZd1XgalAKtASDgx5CaQGMLaS0
b1xDZSDABEWbhkbVsn2DJS4yQNb3jQ==
=+YRo
-----END PGP SIGNATURE-----

--BpU7DK5dadtdojLLppWfUKQ4KK56gWgWS--
