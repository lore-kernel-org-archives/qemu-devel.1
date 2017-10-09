Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1e9j-0007Fm-6g
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1e9i-0000at-Cb
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:56:03 -0400
References: <20171009163456.485-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eec73418-f6d3-d336-a61a-d4da49a74767@redhat.com>
Date: Mon, 9 Oct 2017 21:55:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171009163456.485-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EPLAjbaEIoublgjQnNHU3BxLvpkNKMPsJ"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Add _filter_actual_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EPLAjbaEIoublgjQnNHU3BxLvpkNKMPsJ
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <eec73418-f6d3-d336-a61a-d4da49a74767@redhat.com>
Subject: Re: [PATCH 0/2] iotests: Add _filter_actual_image_size
References: <20171009163456.485-1-mreitz@redhat.com>
In-Reply-To: <20171009163456.485-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 18:34, Max Reitz wrote:
> The actual size of an image depends on the host filesystem.  Therefore,=

> it should be filtered from the test output if it's not part of the test=

> itself (and if it is, the test should take extra care, like 106 does).
>=20
> So let's put the filtering sed line from 067 and 087 into a common
> filter function and use it in 184 and 191.

Thanks for the reviews, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--EPLAjbaEIoublgjQnNHU3BxLvpkNKMPsJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnb1EcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AilcH/1+EJiAPeWuyLzntXovkawJz+VFRAGTC
L46pQoa2tZ7AbeUW7XnflGb4QT5HT21C3TthuGOC+H2Qq666DXGO+peyf6g5PLOT
/V7wo5PKhlzCG1ih6SycGq6bQGdJ3x88ui5twY3mgUr263un8OjEUdDvxTIljOx2
XG+6FZ/NX2axGsjLnGBdYtnZntcLoeIPvoykTZNE3mzp9Qdxvtg+Rlx6/BZ1U40/
rI5R0cSt7LziNhrJxfZ8MLtdAi80a01/WmSVxUqFK7vrBgoOpolVZEKMNX1gatZv
O6pLWCWXlyUSsz6fFpbTrMDLmbde/PEGqDrZbc2cXnbf6GbwuWbyxRg=
=IbRZ
-----END PGP SIGNATURE-----

--EPLAjbaEIoublgjQnNHU3BxLvpkNKMPsJ--
