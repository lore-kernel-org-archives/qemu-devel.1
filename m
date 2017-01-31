Received: from eggs.gnu.org ([2001:4830:134:3::10]:48631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZZU-0002hd-CJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZZT-0006b9-IU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:38:12 -0500
Date: Tue, 31 Jan 2017 14:38:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131143801.GN18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 08/21] backup: skip unallocated clusters
 for full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 05:28:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> +            if (is_top || bdrv_has_zero_init(blk_bs(job->target))) {

  /*
   * Returns 1 if newly created images are guaranteed to contain
   * only zeros, 0 otherwise.
   */
  int (*bdrv_has_zero_init)(BlockDriverState *bs);

This function does not cover arbitrary images opened with bdrv_open(),
only those created with bdrv_img_create() immediately before opening.

This means that the check is only valid with backup->mode !=
NEW_IMAGE_MODE_EXISTING.

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKFJAAoJEJykq7OBq3PIz3AH/3ZZ1lvFQCj2zhwSxy2JVL2q
bZSMg70TO5/RwT7PA1YZeCHgaocC3ted8pwt4SQFw4UixM6OYRlo+9GCG9OgR01N
b4Gf2MdLeu3+88kk2C2sX7Vc12iuGPCpH1Zk7uw0/DfMq9O5xcrcBs0QWzYRyWQK
c8hRXKue6gTFOSRrSqTtG9jrwesKHsBoUicrzUe5DcME7payfjsYQicWbtgBnkVw
CuHq8Msy6bi7EXdHpxugT+9OloLgU3Vd3tfMoFOjMewsT4zPVHFxOxY8jDhNnG2u
ASIrOontF3WQEZp5VjBF4TAtqddwm3TJ7FBgh3hQBKwOGx3DIOZ2bMY6YIPPP1c=
=p7yV
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
