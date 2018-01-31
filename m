Received: from eggs.gnu.org ([2001:4830:134:3::10]:52762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyNh-0006tO-FH
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyNg-0002wb-QT
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:49:17 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<1bf8f7ede9cfebffd11fb9e30c6e497d441b89cf.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a924a2b3-cdee-6e3c-31ac-dbc4e90a2493@redhat.com>
Date: Wed, 31 Jan 2018 20:49:08 +0100
MIME-Version: 1.0
In-Reply-To: <1bf8f7ede9cfebffd11fb9e30c6e497d441b89cf.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HeZUcvdchMkS7kAgTEKTZgFjy8fK4KO4g"
Subject: Re: [Qemu-devel] [PATCH v3 14/39] qcow2: Add
 offset_to_l2_slice_index()
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
--HeZUcvdchMkS7kAgTEKTZgFjy8fK4KO4g
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <a924a2b3-cdee-6e3c-31ac-dbc4e90a2493@redhat.com>
Subject: Re: [PATCH v3 14/39] qcow2: Add offset_to_l2_slice_index()
References: <cover.1516978645.git.berto@igalia.com>
 <1bf8f7ede9cfebffd11fb9e30c6e497d441b89cf.1516978645.git.berto@igalia.com>
In-Reply-To: <1bf8f7ede9cfebffd11fb9e30c6e497d441b89cf.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> Similar to offset_to_l2_index(), this function takes a guest offset
> and returns the index in the L2 slice that contains its L2 entry.
>=20
> An L2 slice has currently the same size as an L2 table (one cluster),
> so both functions return the same value for now.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HeZUcvdchMkS7kAgTEKTZgFjy8fK4KO4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyHbQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A09gH/0bcU2xMUv//nTp5A2pH4J/CO4XORM/X
ezZ6VIo3nyzaJnisjylyYSY0H7/LR8h9rljRUMvGttaO2atAnQVg41ZlHhE4hZrr
1MztCm0w0DWsJ11kiy2NPhjida2MRdb2L43H+8eFcEB2nrOhYuuUBkaJPDm/2KKF
EAq1TIod63nTMHr44jkjlTkIdwRWTqne2WgODmBkpRsewxUoSNMtvncnbhvShGQw
A9bGYq/zskNpvkT5y/biiIA6RUPWoJ1ECFHDIhihF4G0bIn9c4TsMeo6rX897SrF
t5/MDoziMDv8acRHOX2xM7of96NR2VGViC/ciVCMNDlqVZNoRkKke90=
=JOXb
-----END PGP SIGNATURE-----

--HeZUcvdchMkS7kAgTEKTZgFjy8fK4KO4g--
