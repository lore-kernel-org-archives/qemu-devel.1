Received: from eggs.gnu.org ([2001:4830:134:3::10]:52483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBlQP-0006WQ-1j
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBlQN-0001C8-T9
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:15:21 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-2-rkagan@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42359b37-0520-5c71-7a7a-9d347c0475da@redhat.com>
Date: Thu, 26 Apr 2018 13:15:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-2-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8dDJQG5LY2kqyMv2KLKvuPoo5nJ347Nb8"
Subject: Re: [Qemu-devel] [PATCH 01/17] block: iterate_format with account
 of whitelisting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8dDJQG5LY2kqyMv2KLKvuPoo5nJ347Nb8
From: Eric Blake <eblake@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <42359b37-0520-5c71-7a7a-9d347c0475da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] block: iterate_format with account of
 whitelisting
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-2-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-2-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:19 AM, Roman Kagan wrote:
> bdrv_iterate_format (which is currently only used for printing out the
> formats supported by the block layer) doesn't take format whitelisting
> into account.
>=20
> As a result, QEMU lies when asked for the list of block drivers it
> supports with "-drive format=3D?": some of the formats there may be
> recognized by qemu-* tools but unusable in qemu proper.
>=20
> To avoid that, exclude formats that are not whitelisted from
> enumeration, if whitelisting is in use.  Since we have separate
> whitelists for r/w and r/o, take this as a parameter to
> bdrv_iterate_format, and print two lists of supported formats (r/w and
> r/o) in main qemu.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8dDJQG5LY2kqyMv2KLKvuPoo5nJ347Nb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriFzEACgkQp6FrSiUn
Q2rYZAgAm67b2HCzFcVsZiZRsY6FgCZ5EbEpJi0gqiRLiuyhUhbqKg4Ruv9Wfu4t
cA9cTYQe6qKb5ECeUcnet3lVsqcUxFo+cKVyKchHBbvAwTmgFSgQRRT/9YmK3M/i
E2qvXiQlNIXe8F2nEXdr/NcXjKsyi71QD3opLVQZfpGESX/6yr6fuwzs9eT+OJrF
g9hQkkxi39bqGKNRt4HDOW01JUF68mvsYAMmGjJxN7T55qXyojWYmIDoVHZs2aJS
tJ0aP2fAAeXhbwnW1/Fy+alfP4pNnk6Qmc9ZbNky2zojbulmj3vuj5A5iJJw6T1H
lyJj3wJURTy54cevX1wIRN+rRp2bnQ==
=UjhH
-----END PGP SIGNATURE-----

--8dDJQG5LY2kqyMv2KLKvuPoo5nJ347Nb8--
