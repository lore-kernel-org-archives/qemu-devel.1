Received: from eggs.gnu.org ([2001:4830:134:3::10]:40157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPlnT-0004hK-Iw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPlnO-000833-QS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:29:03 -0400
Date: Mon, 4 Jun 2018 10:28:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604092854.GC13674@stefanha-x1.localdomain>
References: <20180601092648.24614-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <20180601092648.24614-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 00/10] qemu-img convert
 with copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 05:26:38PM +0800, Fam Zheng wrote:
> v9: Don't break older libiscsi. [patchew]
>=20
> v8: Fix compiling against new glibc and libiscsi on Fedora 28 where v7 had
>     conflict definitions. [Stefan, myself]
>     - Add HAVE_COPY_FILE_RANGE in configure.
>     - Drop IDENT_DESCR_TGT_DESCR from scsi constants header.
>=20
> v7: Fix qcow2.
>=20
> v6: Pick up rev-by from Stefan and Eric.
>     Tweak patch 2 commit message.
>=20
> v5: - Fix raw offset/bytes check for read. [Eric]
>     - Fix qcow2_handle_l2meta. [Stefan]
>     - Add coroutine_fn whereever appropriate. [Stefan]
>=20
> v4: - Fix raw offset and size. [Eric]
>     - iscsi: Drop unnecessary return values and variables in favor of
>       constants. [Stefan]
>     - qcow2: Handle small backing case. [Stefan]
>     - file-posix: Translate ENOSYS to ENOTSUP. [Stefan]
>     - API documentation and commit message. [Stefan]
>     - Add rev-by to patches 3, 5 - 10. [Stefan, Eric]
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
> offloading in scsi-disk (handle EXTENDED COPY command), and use the API in
> block jobs too.
>=20
> Fam Zheng (10):
>   block: Introduce API for copy offloading
>   raw: Check byte range uniformly
>   raw: Implement copy offloading
>   qcow2: Implement copy offloading
>   file-posix: Implement bdrv_co_copy_range
>   iscsi: Query and save device designator when opening
>   iscsi: Create and use iscsi_co_wait_for_task
>   iscsi: Implement copy offloading
>   block-backend: Add blk_co_copy_range
>   qemu-img: Convert with copy offloading
>=20
>  block/block-backend.c          |  18 ++
>  block/file-posix.c             |  98 +++++++++-
>  block/io.c                     |  97 ++++++++++
>  block/iscsi.c                  | 314 +++++++++++++++++++++++++++++----
>  block/qcow2.c                  | 229 ++++++++++++++++++++----
>  block/raw-format.c             |  96 +++++++---
>  configure                      |  17 ++
>  include/block/block.h          |  32 ++++
>  include/block/block_int.h      |  38 ++++
>  include/block/raw-aio.h        |  10 +-
>  include/scsi/constants.h       |   4 +
>  include/sysemu/block-backend.h |   4 +
>  qemu-img.c                     |  50 +++++-
>  13 files changed, 908 insertions(+), 99 deletions(-)
>=20
> --=20
> 2.17.0
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFQZWAAoJEJykq7OBq3PIwC4H/AxsoNFvQkJwhyxEYbbA+So+
J/NmO9D4k5pRcsfvyPEsClOyk0ebc9xDEojSEDmpMRHBwm885PI7tfqVhWsgB7aj
i2RjPuEe8aWE9Zzb63TA7naroh3Ql8RLBD/3EVwUh12yY1uoVXntJzzcIZHwwLJa
oYRDVKZ//qjGgpbq0dTG+O0bkmiKg7bKL88AzjbpFh96Le1pVgMAb2RFzA0eUalJ
D5VmhGIDExoWomvmnl4KYK6gp2aDM7h40E5t+imSKWSbHQFxzsZg4/AXyC2cicyz
q4I8Oiw/32DjwlPhC6TP1qwjxXHe8t7IJxkdMBdM19SBhNYA8ao/U5hKAs4zUcM=
=n1Tw
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
