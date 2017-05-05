Received: from eggs.gnu.org ([2001:4830:134:3::10]:54164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6jmF-00021v-1V
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6jmE-00084l-4n
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:24:35 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <14b0d29d-0a4f-c7aa-b364-a08198aa4cb2@redhat.com>
Date: Fri, 5 May 2017 22:24:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1juLJqB33h6Luen7qLMPB9V4MIc3djvKt"
Subject: Re: [Qemu-devel] [PATCH v12 03/10] qcow2: Correctly report status
 of preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1juLJqB33h6Luen7qLMPB9V4MIc3djvKt
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <14b0d29d-0a4f-c7aa-b364-a08198aa4cb2@redhat.com>
Subject: Re: [PATCH v12 03/10] qcow2: Correctly report status of preallocated
 zero clusters
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-4-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> We were throwing away the preallocation information associated with
> zero clusters.  But we should be matching the well-defined semantics
> in bdrv_get_block_status(), where (BDRV_BLOCK_ZERO |
> BDRV_BLOCK_OFFSET_VALID) informs the user which offset is reserved,
> while still reminding the user that reading from that offset is
> likely to read garbage.
>=20
> count_contiguous_clusters_by_type() is now used only for unallocated
> cluster runs, hence it gets renamed and tightened.
>=20
> Making this change lets us see which portions of an image are zero
> but preallocated, when using qemu-img map --output=3Djson.  The
> --output=3Dhuman side intentionally ignores all zero clusters, whether
> or not they are preallocated.
>=20
> The fact that there is no change to qemu-iotests './check -qcow2'
> merely means that we aren't yet testing this aspect of qemu-img;
> a later patch will add a test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: rename helper function
> v11: reserved for blkdebug half of v10
> v10: new patch
> ---
>  block/qcow2-cluster.c | 45 +++++++++++++++++++++++++++++++++++--------=
--
>  1 file changed, 35 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--1juLJqB33h6Luen7qLMPB9V4MIc3djvKt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM33cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYP4IAJx0X+7CMrDXyfNmMHUebWSDfK+7thQW
/3/iL6osTEnNdOIttgFfF39acjlJrdwXRuaMigNobb2KkdR+u+AOlGDbDyUl1I1v
r4FAH/sUpOHo8zD821JM9b1SdEC5Sr1LW+ISE0oCdv8mvql0mfdDb4ryvzactr3k
Ayn6NjHpYxc9kJY0fR3fmvcfit3wTt1YsLnX+TCWQdUZ8sgnBvzZVhjZB1SqNO8b
9PZ4I/rmHA4R11KmoxCNsfVYfAGlVeBziV9qtyWQZVZdJC/FkyNVP4lNKLdMHqTF
kywBFUlpSqvWml7M8Xkf4siQukd34rnuT9JBgcLyiglq9Mp2kY2eaF4=
=kw1o
-----END PGP SIGNATURE-----

--1juLJqB33h6Luen7qLMPB9V4MIc3djvKt--
