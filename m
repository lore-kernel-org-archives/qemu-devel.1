Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvjb6-00065y-Al
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvjOx-0003TU-2m
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:23:51 -0400
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9fec287c-0ce0-b2d2-2e31-1f2820bac051@redhat.com>
Date: Fri, 31 Aug 2018 15:23:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180830015734.19765-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aEWYX501bXrZvhlarElbpgP62KmE7y0FO"
Subject: Re: [Qemu-devel] [PATCH v3 5/9] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEWYX501bXrZvhlarElbpgP62KmE7y0FO
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com
Message-ID: <9fec287c-0ce0-b2d2-2e31-1f2820bac051@redhat.com>
Subject: Re: [PATCH v3 5/9] block/mirror: utilize job_exit shim
References: <20180830015734.19765-1-jsnow@redhat.com>
 <20180830015734.19765-6-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-30 03:57, John Snow wrote:
> Change the manual deferment to mirror_exit into the implicit
> callback to job_exit and the mirror_exit callback.
>=20
> This does change the order of some bdrv_unref calls and job_completed,
> but thanks to the new context in which we call .exit, this is safe to
> defer the possible flushing of any nodes to the job_finalize_single
> cleanup stage.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--aEWYX501bXrZvhlarElbpgP62KmE7y0FO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluJQVgACgkQ9AfbAGHV
z0AT5wf+PTSatD4w5gXDn9z946QTn7pyeT1/hxF1HauVepDmLaEsNXbk7djvdqa9
PFoBZzL2NbypO2fZAxtSEdPfX3uRCLpKdcVrMEUAuhmIkuRfs+GIWoRpACXdBCvA
N9dxrdygRfE9FU7ceSLZFVmzSgeFAVja3sqzZtp9WGljqq/MKLLy0fFzksvwA+3F
Zf/e1uQ//T9Y5AvS3hlz6HU3Fz8C1HXl4XN7+niWGPplwWCBTUUtehlW7DCostUo
VJ+C8Ur+XKZjlqzSfw67n6bMfVEb1bIdoiLTKa1JqNvmJZhXdWId8iV+gFPdTS5w
powxhwtjbUzmgnDG9HEPFneVV2e35Q==
=K/jR
-----END PGP SIGNATURE-----

--aEWYX501bXrZvhlarElbpgP62KmE7y0FO--
