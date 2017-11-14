Received: from eggs.gnu.org ([2001:4830:134:3::10]:54134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEhFI-0002M5-HV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEhFH-00029V-Lc
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:51:44 -0500
References: <20171114184127.24238-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e0210ef-5720-d9b8-d7e2-6877fc0ce320@redhat.com>
Date: Tue, 14 Nov 2017 13:51:36 -0600
MIME-Version: 1.0
In-Reply-To: <20171114184127.24238-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SoXMHJdLoNkxUCtu9ULIVmr3AHh9XUVdl"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: Fix overly broad madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SoXMHJdLoNkxUCtu9ULIVmr3AHh9XUVdl
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Message-ID: <1e0210ef-5720-d9b8-d7e2-6877fc0ce320@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: Fix overly broad madvise()
References: <20171114184127.24238-1-mreitz@redhat.com>
In-Reply-To: <20171114184127.24238-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 12:41 PM, Max Reitz wrote:
> @mem_size and @offset are both size_t, thus subtracting them from one
> another will just return a big size_t if mem_size < offset -- even more=

> obvious here because the result is stored in another size_t.
>=20
> Checking that result to be positive is therefore not sufficient to
> excluse the case that offset > mem_size.  Thus, we currently sometimes

s/excluse/exclude/

> issue an madvise() over a very large address range.
>=20
> This is triggered by iotest 163, but with -m64, this does not result in=

> tangible problems.  But with -m32, this test produces three segfaults,
> all of which are fixed by this patch.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SoXMHJdLoNkxUCtu9ULIVmr3AHh9XUVdl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLSUgACgkQp6FrSiUn
Q2q9kAf6AmgFz3wl3/N5BiIL9skfizcvK9KYIWSk0pUyf/7bv3UK8xCnQLLjrZPP
GNJPQOEO8xHeoYVEtKFqh1gKvoi1qWoaJW9HJqSKCQt37QYgvhyVZf70OIjOBYU0
iNLShTBCvY1JGl71phDhULX2MKLhFwUDYfiSx3qUadRCaUNlT9YtEOAAyozZkhoL
NjCgdqHNzVbwNQsrhWeIDgXgziofb+JhECDEU/bGh071+LhMN460RjpM1L9Urbuk
4Y5Xd1tz2wc8zdbTQ5yAheBGzeATDMjkBEUCQ+a6M8CidoUPX3p9lYt728siyNqU
iwUjZrwtuQrrLuYyOEe9E8x/jX3B+w==
=/Zcp
-----END PGP SIGNATURE-----

--SoXMHJdLoNkxUCtu9ULIVmr3AHh9XUVdl--
