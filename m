Received: from eggs.gnu.org ([2001:4830:134:3::10]:34242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtGjM-0005Yp-O9
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 13:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtGjM-000581-0N
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 13:18:12 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-8-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1858c2fd-ef9b-85b3-b51b-bebc56b6192c@redhat.com>
Date: Sat, 16 Sep 2017 19:18:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nmFnMHVEkDRGUHOPnMdMw8S9ixOBGj1Di"
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block: support passthrough of
 BDRV_REQ_FUA in crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nmFnMHVEkDRGUHOPnMdMw8S9ixOBGj1Di
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <1858c2fd-ef9b-85b3-b51b-bebc56b6192c@redhat.com>
Subject: Re: [PATCH v3 7/7] block: support passthrough of BDRV_REQ_FUA in
 crypto driver
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-8-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> The BDRV_REQ_FUA flag can trivially be allowed in the crypt driver
> as a passthrough to the underlying block driver.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nmFnMHVEkDRGUHOPnMdMw8S9ixOBGj1Di
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9XMoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Azi8IALONivAAOX6SGcFOL5VIteVjxcoSNO/x
RLhxg1Oak4Ktv0jkcCMiWOpNm0Bk0iwoLf9ffRXbvwBeXhtx1KIHPDyJmInBNJL+
Ixhqs1gQru88vQ7gnngF18TbE+68plhkPHid37crdBCUUxQ5L2GDyLgV2bFbdUqw
6HIZw5pXoGcUOaE6d6CdIizYTTNscIQx7fDYF5f1idzb76hZo00NSJ/cKB3XORc4
BI6/RzkjRYURS+QzDxmTLXQNRKTbEXGzsgAOy7XdNvwEWo0RGsLOvk/Lnq93lha8
fjk3W1Zt1/Ty9FIJyUrZmi0Y70GxJox5OPxP6MMOqbHLBq8zOHPLfWI=
=rCeH
-----END PGP SIGNATURE-----

--nmFnMHVEkDRGUHOPnMdMw8S9ixOBGj1Di--
