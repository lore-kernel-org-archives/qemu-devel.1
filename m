Received: from eggs.gnu.org ([2001:4830:134:3::10]:33218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwaI7-0000Gr-EY
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwaI6-00015F-HV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:47:47 -0400
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ab20de4-7111-34cc-5f21-05e68682f097@redhat.com>
Date: Mon, 25 Sep 2017 15:47:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170925122808.14561-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VOfqbgenhLGAfIVUB0C9sMJobQqQLar6U"
Subject: Re: [Qemu-devel] [PATCH 5/5] commit: Remove overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VOfqbgenhLGAfIVUB0C9sMJobQqQLar6U
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <3ab20de4-7111-34cc-5f21-05e68682f097@redhat.com>
Subject: Re: [PATCH 5/5] commit: Remove overlay_bs
References: <20170925122808.14561-1-kwolf@redhat.com>
 <20170925122808.14561-6-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> We don't need to make any assumptions about the graph layout above the
> top node of the commit operation any more. Remove the use of
> bdrv_find_overlay() and related variables from the commit job code.
>=20
> bdrv_drop_intermediate() doesn't use the 'active' parameter any more, s=
o
> we can just drop it.
>=20
> The overlay node was previously added to the block job to get a
> BLK_PERM_GRAPH_MOD. We really need to respect those permissions in
> bdrv_drop_intermediate() now, but as long as we haven't figured out yet=

> how BLK_PERM_GRAPH_MOD is actually supposed to work, just leave a TODO
> comment there.
>=20
> With this change, it is now possible to perform another block job on an=

> overlay node without conflicts. qemu-iotests 030 is changed accordingly=
=2E
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h  |  3 +--
>  block.c                |  6 +++--
>  block/commit.c         | 62 ++++++++++++------------------------------=
--------
>  tests/qemu-iotests/030 |  4 ----
>  4 files changed, 20 insertions(+), 55 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VOfqbgenhLGAfIVUB0C9sMJobQqQLar6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJa2oACgkQp6FrSiUn
Q2qNsgf/QvSZqU9dwLgnlq6uCsBRj2kUKPaJzv2SPBeb0MCZULkQUhcdqh8aXJIj
1pLuJG/Xv9ICTfJMUY6zdtGjSRGSIWLpYHWNsobBA3gs8hDW24f8tgKEKgFyw4aR
Z3vUmmZ/+heVhqyMizGSkthorE/NcXdO6/s7VRgA0HlLtNIHDlRlivceajCG63HX
r28R7SrAV9nBV6bppRJFrUL6s3pQXpCEMaL1StTUDHQolLN9olSYPtGwwOZn6NaK
dsikZG1yzbUB9s29XNdatMbCky8IVnrLTV6fEqbXmNmj8aviO40LH+IMWgy3RC+B
9kNJ6fJL39r6lfm76AuxYmjDrw++PQ==
=rEuA
-----END PGP SIGNATURE-----

--VOfqbgenhLGAfIVUB0C9sMJobQqQLar6U--
