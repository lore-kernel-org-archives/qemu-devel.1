Received: from eggs.gnu.org ([2001:4830:134:3::10]:60985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyvn-0008Bl-RQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyvm-0008NA-TA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:24:31 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<2b46336dbc0958554ef7883d95a61de88533337d.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a334ce65-5227-2912-df8e-5bdd19e56404@redhat.com>
Date: Wed, 31 Jan 2018 21:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <2b46336dbc0958554ef7883d95a61de88533337d.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zYUB5IUR4PcJmSuII73Ok0xnau4pmVWHk"
Subject: Re: [Qemu-devel] [PATCH v3 20/39] qcow2: Update
 qcow2_get_cluster_offset() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zYUB5IUR4PcJmSuII73Ok0xnau4pmVWHk
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <a334ce65-5227-2912-df8e-5bdd19e56404@redhat.com>
Subject: Re: [PATCH v3 20/39] qcow2: Update qcow2_get_cluster_offset() to
 support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <2b46336dbc0958554ef7883d95a61de88533337d.1516978645.git.berto@igalia.com>
In-Reply-To: <2b46336dbc0958554ef7883d95a61de88533337d.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> qcow2_get_cluster_offset() checks how many contiguous bytes are
> available at a given offset. The returned number of bytes is limited
> by the amount that can be addressed without having to load more than
> one L2 table.
>=20
> Since we'll be loading L2 slices instead of full tables this patch
> changes the limit accordingly using the size of the L2 slice for the
> calculations instead of the full table size.
>=20
> One consequence of this is that with small L2 slices operations such
> as 'qemu-img map' will need to iterate in more steps because each
> qcow2_get_cluster_offset() call will potentially return a smaller
> number. However the code is already prepared for that so this doesn't
> break semantics.
>=20
> The l2_table variable is also renamed to l2_slice to reflect this, and
> offset_to_l2_index() is replaced with offset_to_l2_slice_index().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--zYUB5IUR4PcJmSuII73Ok0xnau4pmVWHk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyJfISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzFIIAJQZOphUaZ00STBSNIdrunVJLgwZjQKh
c/eS7o99KhYtLF4FFqfXDRYZL8TEIyggh9uhZJ6cZKoyv3aK9a3kEdhfLfKEcPRV
PhrzGnux1vd+S8dXd7EyrGwBe3ysZbymwqb88U3Dfo4kLdAM4ixWr23jEshQuQct
6SxcjToOa2n8UqenZMfAhAFeagi3NqP8oS0XTKnkGdcir05DquTPs2Upu/Xa23/v
BEEb0TE2RFdeu2wZyIBHN8L1TxxFqIzGa/YPShfz4UtLrRulDCQq0iRbaI0RASvw
gFcbC7NY5QljTcdyKXOj4FW6qAN3v6w57p+bQJzw8sY+Pt1HoSstuWY=
=8Jui
-----END PGP SIGNATURE-----

--zYUB5IUR4PcJmSuII73Ok0xnau4pmVWHk--
