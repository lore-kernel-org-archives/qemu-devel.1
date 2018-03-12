Received: from eggs.gnu.org ([2001:4830:134:3::10]:58900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evUru-0006Cm-F1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evUrt-0007Sb-N3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:20:30 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-5-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <919b155f-f17c-6a8c-82fc-9574069f225f@redhat.com>
Date: Mon, 12 Mar 2018 22:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yV3NAJHruzPocXw0bowhOwXQiTDwtz4L8"
Subject: Re: [Qemu-devel] [PATCH 4/7] qed: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yV3NAJHruzPocXw0bowhOwXQiTDwtz4L8
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <919b155f-f17c-6a8c-82fc-9574069f225f@redhat.com>
Subject: Re: [PATCH 4/7] qed: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-5-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to qed, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  25 ++++++-
>  block/qed.c          | 204 ++++++++++++++++++++++++++++++++++---------=
--------
>  2 files changed, 162 insertions(+), 67 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--yV3NAJHruzPocXw0bowhOwXQiTDwtz4L8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqm7w4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACRAH/2UOiEtH96kGO+JGFW0DSLyKCRXxw725
K6WAmad+mJrbiOcigK/gUughlQ1rElIW+vkUDdakJicvek0gz9ksroUYPHhbugoQ
zwuXFuyjqxvwavg8rx7htogLtSb75bvS2X4zdiwwsfBWZyiI8h+bPW3qHLC3XqlL
GqEkeMIiL0kQbsYxKEsRqbohgM3HfifF49DQck+SElYRXnVsCEMbbDv3SCR3f7hs
+2hSP6BJ7Vn4lL7CmwB081YS50MfAtLbt3Hjza9hj/ZkUb0rkP5Mldn11NKLv9vJ
8KId/kA6wAIooxOJueEcWlCMw+V63G+nvuul7GKixE2MCCS3Z6U2auI=
=91QO
-----END PGP SIGNATURE-----

--yV3NAJHruzPocXw0bowhOwXQiTDwtz4L8--
