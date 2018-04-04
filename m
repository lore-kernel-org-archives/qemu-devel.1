Received: from eggs.gnu.org ([2001:4830:134:3::10]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3iO4-00046h-MJ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3iO0-0003Pi-KU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:23:40 -0400
Date: Wed, 4 Apr 2018 14:23:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404132332.GR4467@stefanha-x1.localdomain>
References: <20180329110914.20888-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9uazBBczf8QSjDPd"
Content-Disposition: inline
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/8] qemu-img convert with
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com


--9uazBBczf8QSjDPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 07:09:06PM +0800, Fam Zheng wrote:
> [Posting a preview RFC for the general idea discussion and internal API r=
eview.
> Libiscsi support is being worked on in the meantime.]
>=20
> This series introduces block layer API for copy offloading and makes use =
of it
> in qemu-img convert.
>=20
> For now we implemented the operation in local file protocol with
> copy_file_range(2).  Besides that it's possible to add similar to iscsi, =
nfs
> and potentially more.
>=20
> As far as its usage goes, in addition to qemu-img convert, we can emulate
> offloading in scsi-disk (EXTENDED COPY), and do similar to drive-mirror.
>=20
> The new bdrv_co_map_range can also be an alternative way to implement for=
mat
> drivers in the future, once we make block/io.c use it in preadv/pwritev p=
aths.

I posted concerns about the bdrv_co_map_range() interface.  It would be
safer to only have a copy_range() interface without exposing how data is
mapped outside the driver where race conditions can occur and the format
driver no longer has full control over file layout.

Stefan

--9uazBBczf8QSjDPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxNHUAAoJEJykq7OBq3PI35AH/0tPZRmp2X/8pbHc+/wsW7VN
Djxli4Xofdgcdiu2yrR+Ik45JNU6Q0irrlHabxdwZ8ByltpTrY0XpAJXhoVv38UF
hEmv3YE1zaenUGXkvxe851lCI4FqWkJ7O89+vNRV0JvW2Q7ql+mwR3jHtsnbdHGR
v96x8b0yaICt/nyahvDl6HHudnZfORc+ym8vPelXt0GEVJTZFNwCI+qGTBET8mZE
FooU7LDD+9n64saQHvhWaGxjJl3moyA//R5wXJsIcjHalQnz76wieMyALdzrjOD5
WNdQsNYdV170HMINYA/9gAk5VieFS4umvEg6462J05V4P/8c+43+ognJAVtABbI=
=OeZS
-----END PGP SIGNATURE-----

--9uazBBczf8QSjDPd--
