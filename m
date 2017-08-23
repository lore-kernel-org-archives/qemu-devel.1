Received: from eggs.gnu.org ([2001:4830:134:3::10]:33920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkbSa-0006Ie-2c
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkbSZ-0008Is-3Q
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:37:04 -0400
References: <20170821135530.32344-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5075708-3e8e-b701-620a-a3f069964c5d@redhat.com>
Date: Wed, 23 Aug 2017 14:36:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170821135530.32344-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qnscqCeuJRKK4DxUKjN1XlO2JEhkpPVxs"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: allocate
 cluster_cache/cluster_data on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qnscqCeuJRKK4DxUKjN1XlO2JEhkpPVxs
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <c5075708-3e8e-b701-620a-a3f069964c5d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: allocate
 cluster_cache/cluster_data on demand
References: <20170821135530.32344-1-stefanha@redhat.com>
In-Reply-To: <20170821135530.32344-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2017 08:55 AM, Stefan Hajnoczi wrote:
> Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1=
)
> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
> s->cluster_data when the first read operation is performance on a
> compressed cluster.
>=20
> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any=

> code paths that can allocate these buffers, so remove the free function=
s
> in the error code path.
>=20
> This patch can result in significant memory savings when many qcow2
> disks are attached or backing file chains are long:
>=20
> Before 12.81% (1,023,193,088B)
> After   5.36% (393,893,888B)
>=20
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qnscqCeuJRKK4DxUKjN1XlO2JEhkpPVxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmd2VMACgkQp6FrSiUn
Q2oekQf/YMa/buh9RhCoeS0OFLlJyc0c8gD3E8Vqka1SiqnYOdoPmK6BOpAgzbuN
gyBG2SExQpWnOTwXIp27Hwy+K3f6iybX9Wk2OrU1NhjmIqs0ALq0Tt0qqsaF54ZG
SIG2XXbaML21Y5vT8Fnij0HD75O4wsdmONNJShNzg7jTP2VkzvGhQLUojuitCgtY
683NXtFHTOwRX/chpJb86x/5/ffbfFShCufZc8WGJNng15rSe6qX3QJP8yrn0vZb
9hlJP1kWUGon4zu+KsZNZeEqeTMnCJaRwzaCcS98BkLg6NskD0jPF6d/2QroZGyx
mMSF2KiuJ6isr6P4hhue899WbixUFA==
=QobY
-----END PGP SIGNATURE-----

--qnscqCeuJRKK4DxUKjN1XlO2JEhkpPVxs--
