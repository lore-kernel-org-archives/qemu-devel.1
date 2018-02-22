Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozgo-0000In-CB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozgn-00055n-GZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:50:10 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-15-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8247ddef-ba42-6b8b-b879-1f7d41760a9d@redhat.com>
Date: Thu, 22 Feb 2018 23:50:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-15-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="psuUTmhIjavAzyMePviaIsPtMyqL4E3s6"
Subject: Re: [Qemu-devel] [PATCH v2 14/36] block: x-blockdev-create QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--psuUTmhIjavAzyMePviaIsPtMyqL4E3s6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <8247ddef-ba42-6b8b-b879-1f7d41760a9d@redhat.com>
Subject: Re: [PATCH v2 14/36] block: x-blockdev-create QMP command
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-15-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> This adds a synchronous x-blockdev-create QMP command that can create
> qcow2 images on a given node name.
>=20
> We don't want to block while creating an image, so this is not the fina=
l
> interface in all aspects, but BlockdevCreateOptionsQcow2 and
> .bdrv_co_create() are what they actually might look like in the end. In=

> any case, this should be good enough to test whether we interpret
> BlockdevCreateOptions as we should.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json      | 12 ++++++++
>  include/block/block_int.h |  2 ++
>  block/create.c            | 76 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c             |  3 +-
>  block/Makefile.objs       |  2 +-
>  5 files changed, 93 insertions(+), 2 deletions(-)
>  create mode 100644 block/create.c

Reviewed-by: Max Reitz <mreitz@redhat.com>


--psuUTmhIjavAzyMePviaIsPtMyqL4E3s6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPSRkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aw44IALbyo7U4BfnzxPEzca5nhMtncBUCvcQd
ecPDMxwzjiMb0F54Ln8EcqPJzYswbSDqzQMX94wmbW/2S8y2RWQtbOQYn69eVOH7
7+wBrRa5dVUnW5T57SusyzVVmD+G5904JsUdden2sm7A5s2IqPlmAyLocJRGUqhs
KgSujqnmjNuJ5BE6YJsmJsUDVM0TuHkLta9IrFAsSsaS+GcKTaMcwGouR4wE7G35
s/CcUC9fxwutCVlc5dvJELkypQyOSmVZUfor/8U9xwRVV7u0R2u0On7CSBFoJJd6
gnmSBgsGwKOBIv5cAdtkwliMInmSGfHOzI3othKT3IcYIS3DuJOTz+E=
=zf8B
-----END PGP SIGNATURE-----

--psuUTmhIjavAzyMePviaIsPtMyqL4E3s6--
