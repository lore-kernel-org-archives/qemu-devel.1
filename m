Received: from eggs.gnu.org ([2001:4830:134:3::10]:57102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d652f-0002Cj-Eo
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d652e-0006My-Ia
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:49 -0400
References: <20170503231120.23507-1-mreitz@redhat.com>
	<20170503231120.23507-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ce3b8e4-3473-3c1a-98b0-8f8d80d60481@redhat.com>
Date: Wed, 3 May 2017 19:54:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170503231120.23507-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bi4Re3gQiPemaNr4SeCGiXCQ7qREUT3Vn"
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Fix preallocation size formula
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bi4Re3gQiPemaNr4SeCGiXCQ7qREUT3Vn
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9ce3b8e4-3473-3c1a-98b0-8f8d80d60481@redhat.com>
Subject: Re: [PATCH 1/4] qcow2: Fix preallocation size formula
References: <20170503231120.23507-1-mreitz@redhat.com>
 <20170503231120.23507-2-mreitz@redhat.com>
In-Reply-To: <20170503231120.23507-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 06:11 PM, Max Reitz wrote:
> When calculating the number of reftable entries, we should actually use=

> the number of refblocks and not (wrongly[1]) re-calculate it.
>=20
> [1] "Wrongly" means: Dividing the number of clusters by the number of
>     entries per refblock and rounding down instead of up.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Bi4Re3gQiPemaNr4SeCGiXCQ7qREUT3Vn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCnvRAAoJEKeha0olJ0NqkpcIAK7OExHJtuJt31Q8rf47elTD
r6KtIsqwN+BO/9tsUVtEStjSg3fNSScHYrjfEdrha9bixwHAOz8/YLXkiD+L2ZOI
VH742trZXdsC2MTe7BDuvDKAtpBnWEJrWo0I7k5SBmwJaKKcLknAKN163DE64r6m
enj9ilN+LUjkMTDY9tnqwiLP6I4hlDk9iGkpKVCItVInmxIWh0WdbF8tUhMh8OeR
VwRQjxtFYUUtKC/9cvHw4iwZ4fHY3WbKs93w5iI77jKMe5LES79VObvCsDjshd5T
EMW4HXsjOmOelogpk/pFvosDIGK91AjiMAcdgh0Xcuaaa22AqmiyzW6R6cNT10Y=
=Aecu
-----END PGP SIGNATURE-----

--Bi4Re3gQiPemaNr4SeCGiXCQ7qREUT3Vn--
