Received: from eggs.gnu.org ([2001:4830:134:3::10]:34048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG3C6-0002pk-Aj
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG3C5-0000Wb-Mh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:57:46 -0400
Date: Wed, 31 May 2017 13:57:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531125738.GD16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-30-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G/vVCphCGw+yuveY"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-30-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 29/29] block: Remove
 bdrv_aio_readv/writev_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--G/vVCphCGw+yuveY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:10PM +0200, Kevin Wolf wrote:
> @@ -2083,28 +2075,6 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUI=
OVector *qiov, int64_t pos)
>  /**************************************************************/
>  /* async I/Os */
> =20
> -BlockAIOCB *bdrv_aio_readv(BdrvChild *child, int64_t sector_num,
> -                           QEMUIOVector *qiov, int nb_sectors,
> -                           BlockCompletionFunc *cb, void *opaque)
> -{
> -    trace_bdrv_aio_readv(child->bs, sector_num, nb_sectors, opaque);

Please remove unused trace events from the trace-events file.

--G/vVCphCGw+yuveY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLr3CAAoJEJykq7OBq3PISM0H/1mhF1W358TewOcekf9HxjI9
sKJ44HQKHb6GK0B8KppfMoYYsNLQ9uKcGdNfGd0UJT+OGLrdZdMsojWg0EdihN9i
+awj1TKPCX8Jeb59P4cjBbxAlSbSdcrb6O2QjwOC5GDhOPu/ZZLFq6SvQ9JjelmU
IffsaOL1Ga4jRDrwse4+5t1cLftEKccmU2l8XolSIklVkv1fXcrdtyiBc0RtAyGG
Z5s++5wx4awL8DT1CNGRCs/U8JoR1ygLA0dmb6jOMMorG6mGbF7nfRGxIdrvHa7J
tilWynU/eKNQnD3AJ8qSJvK9jRicJWOwjdC9j9xYDIFQ4QjoqDPKDhFzeOCQ7mQ=
=ERhy
-----END PGP SIGNATURE-----

--G/vVCphCGw+yuveY--
