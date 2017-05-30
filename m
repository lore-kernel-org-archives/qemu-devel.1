Received: from eggs.gnu.org ([2001:4830:134:3::10]:60167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFohF-0004st-N6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFohB-0005hf-5A
	for qemu-devel@nongnu.org; Tue, 30 May 2017 17:28:57 -0400
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-11-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f17d11e-c32b-6e9c-fdd2-9174affd9e5a@redhat.com>
Date: Tue, 30 May 2017 16:28:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170526165518.7580-11-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u0EjiCnmnK33WHhaj8fSscAWCSPQqEiQH"
Subject: Re: [Qemu-devel] [PATCH v3 10/16] block/qcow2: Lock s->lock in
 preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u0EjiCnmnK33WHhaj8fSscAWCSPQqEiQH
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <5f17d11e-c32b-6e9c-fdd2-9174affd9e5a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/16] block/qcow2: Lock s->lock in
 preallocate()
References: <20170526165518.7580-1-mreitz@redhat.com>
 <20170526165518.7580-11-mreitz@redhat.com>
In-Reply-To: <20170526165518.7580-11-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 11:55 AM, Max Reitz wrote:
> preallocate() is and will be called only from places that do not lock

Maybe: "that do not otherwise need to lock"

> s->lock: Currently that is qcow2_create2(), as of a future patch it wil=
l
> be called from qcow2_truncate(), too.
>=20
> It therefore makes sense to move locking that mutex into preallocate()
> itself.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u0EjiCnmnK33WHhaj8fSscAWCSPQqEiQH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLeQNAAoJEKeha0olJ0NqClgH/i55dxSCh0MTtt1/z8QG62sa
IEs53xaIEFxH9C8tQn8tW4d69y++Px451WBgTdk8tybjk9tA6sr3ggCsgi5+fhGB
u6ztyTQwP1uPHPQwMtmMNDas/GPfr1n9McuxkqnLImo8gfTrust19D9hDq2G7xit
xGAXZqpyVQUligC/ot5IufNSTbYqXQ/JviByNPQQEQ8Jam6uiV6hMam0jBtZemjH
m4mvJ/fw3kHs3oODSfDFDF52n9DLjIhT6AGfmNEwbsW/bPqo4ZkV9hEORVZmOKhb
YcIRGsqqsRHBrG0k+g3vHHr38TlBvleIskjVtT+rOZuB/QmEDbbpeRHTVTFwTao=
=8CZU
-----END PGP SIGNATURE-----

--u0EjiCnmnK33WHhaj8fSscAWCSPQqEiQH--
