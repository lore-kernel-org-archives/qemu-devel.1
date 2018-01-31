Received: from eggs.gnu.org ([2001:4830:134:3::10]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxvx-00066q-Uq
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxvw-0000vW-Ma
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:20:37 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d93a5872-8b9a-aa6a-83e4-d32c9e1ccbdf@redhat.com>
Date: Wed, 31 Jan 2018 13:20:26 -0600
MIME-Version: 1.0
In-Reply-To: <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mQpTET8AD9FEYlCY3kSK83zMmCXJPIdGQ"
Subject: Re: [Qemu-devel] [PATCH v3 36/39] qcow2: Allow configuring the L2
 slice size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mQpTET8AD9FEYlCY3kSK83zMmCXJPIdGQ
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <d93a5872-8b9a-aa6a-83e4-d32c9e1ccbdf@redhat.com>
Subject: Re: [PATCH v3 36/39] qcow2: Allow configuring the L2 slice size
References: <cover.1516978645.git.berto@igalia.com>
 <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
In-Reply-To: <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 09:00 AM, Alberto Garcia wrote:
> Now that the code is ready to handle L2 slices we can finally add an
> option to allow configuring their size.
>=20
> An L2 slice is the portion of an L2 table that is read by the qcow2
> cache. Until now the cache was always reading full L2 tables, and
> since the L2 table size is equal to the cluster size this was not very
> efficient with large clusters. Here's a more detailed explanation of
> why it makes sense to have smaller cache entries in order to load L2
> data:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html
>=20
> This patch introduces a new command-line option to the qcow2 driver
> named l2-cache-entry-size (cf. l2-cache-size). The cache entry size
> has the same restrictions as the cluster size: it must be a power of
> two and it has the same range of allowed values, with the additional
> requirement that it must not be larger than the cluster size.
>=20
> The L2 cache entry size (L2 slice size) remains equal to the cluster
> size for now by default, so this feature must be explicitly enabled.
> Although my tests show that 4KB slices consistently improve
> performance and give the best results, let's wait and make more tests
> with different cluster sizes before deciding on an optimal default.
>=20
> Now that the cache entry size is not necessarily equal to the cluster
> size we need to reflect that in the MIN_L2_CACHE_SIZE documentation.
> That minimum value is a requirement of the COW algorithm: we need to
> read two L2 slices (and not two L2 tables) in order to do COW, see
> l2_allocate() for the actual code.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mQpTET8AD9FEYlCY3kSK83zMmCXJPIdGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyFvoACgkQp6FrSiUn
Q2qFZwf9Gi0sXNa3vOyuOj52lvVlDAFKCN+4aV1tqzko8DL0zsFlmYi4k+grZgWX
t9/UCzOGHEE21eGOl7W1Vv2AFE0MVisoVhLdvpiRCc0BzdfJa1kNqD+y7ocIWfzR
uvL51fPCat3HGl/u7onUkkEtwMBDdF8VLgAA8sBp1AbxpTqg2kcv3jZMgL2ZN2RG
tRkOhDyz/5M6a+k9B/S6Sog2+2MHekiFwIBLYYQwcU4FrKBbBV/oaoyF2A1OnxkD
4561mDqeuiQmxBtEsQssImWBGaNX9y881iDKKOL42a73fkq9iyG0VdAWM3YiD3ey
wGAttZANO2L67m/KLkIfKC8vfhogkA==
=jHyG
-----END PGP SIGNATURE-----

--mQpTET8AD9FEYlCY3kSK83zMmCXJPIdGQ--
