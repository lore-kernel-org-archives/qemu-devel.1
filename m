Received: from eggs.gnu.org ([2001:4830:134:3::10]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQUs-0006J7-Kk
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQUr-00011x-Ph
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:48:02 -0400
Date: Fri, 7 Apr 2017 10:47:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407094754.GK13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<6a596585429c0834158ad1b9da092df3f7dc4dee.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <6a596585429c0834158ad1b9da092df3f7dc4dee.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 7/9] block/rbd - update variable
 names to more apt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:28:49PM -0400, Jeff Cody wrote:
> Update 'clientname' to be 'user', which tracks better with both
> the QAPI and rados viarable naming.
>=20
> Update 'name' to be 'image_name', as it indicates the rbd image.
> Naming it 'image' would have been ideal, but we are using that for
> the rados_image_t value returned by rbd_open().
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY52BKAAoJEJykq7OBq3PIHWUIAJ5Ikb+chlggD60LLBTctrFh
khs7hdr6AqnAEM0s3sRJwoKxegtMtOPE6ia8wVDYS0SbKbt5+LcOxLBrS61BNPVj
YQtUZ4XvitRJ+tRss2VocKAWNYQFdxjL0smqqZAGU7LtiCpgJyfw7KpWInqJhE0r
D/mc4oDkEUWmGBPExxGul2IGDm80M7MvLq1puDdMvLXeZTT+YYWYzM3ptTREQWdi
BQeRiC9JxODNb3AvzPiTeSOynH8umqy1RAxJsG7hylV/UuBPCk+dNvVAlWLKb1Rm
dhX4/nzvBL/H7Uzud2+qHcrpWKzQU1z1qwzbApYCycJfyf1VoLScRVUIu9LKJ0k=
=4782
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
