Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4oz-0002yC-3a
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4oy-00067Y-8N
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:39:13 -0500
References: <20171207201320.19284-1-stefanha@redhat.com>
	<20171207201320.19284-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b633a44-09ac-c4f8-b1f4-5e52afd0503f@redhat.com>
Date: Thu, 7 Dec 2017 16:38:57 -0600
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4MSLX1gXW4OB1FaVuSi3FlqpB7E3ntRWf"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] blockdev: add
 x-blockdev-set-iothread force boolean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4MSLX1gXW4OB1FaVuSi3FlqpB7E3ntRWf
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b633a44-09ac-c4f8-b1f4-5e52afd0503f@redhat.com>
Subject: Re: [PATCH v2 3/6] blockdev: add x-blockdev-set-iothread force
 boolean
References: <20171207201320.19284-1-stefanha@redhat.com>
 <20171207201320.19284-4-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 02:13 PM, Stefan Hajnoczi wrote:
> When a node is already associated with a BlockBackend the
> x-blockdev-set-iothread command refuses to set the IOThread.  This is t=
o
> prevent accidentally changing the IOThread when the nodes are in use.
>=20
> When the nodes are created with -drive they automatically get a
> BlockBackend.  In that case we know nothing is using them yet and it's
> safe to set the IOThread.  Add a force boolean to override the check.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json |  6 +++++-
>  blockdev.c           | 11 ++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4MSLX1gXW4OB1FaVuSi3FlqpB7E3ntRWf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopwwEACgkQp6FrSiUn
Q2qePwf/Uc51n2AQ08oYyzFjDi3AZkx+tk6HWWqhLkcKWMQjQj7k+EyZ5LBdZLUZ
qtwO2WLb0XmNbQvseLKb9kTjh/RWUEVSCL5vK02m5NSSCaFAAcuEA8usj+fqu120
FJcQ06XC/QYyLyEu6JWtec9PyDAcNsl8pSqFppq0u+UH69EF9mCfJ0PJHr28kP+C
JZsLBX9N/VdVDoNAds6l9hSuSc2TR1Zaa3ikPUXWgY9C1xU3BTmU4aDZn/6uRkje
nNxY6zHNKO3C533yqg7dkgztTXLDRszqy+8MLTQw2mdo9XjxjtL20x9T1Bhx5LvS
Ymwlbcysr6TO6WlQF4ZkgD0RnvINCA==
=8AgK
-----END PGP SIGNATURE-----

--4MSLX1gXW4OB1FaVuSi3FlqpB7E3ntRWf--
