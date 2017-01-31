Received: from eggs.gnu.org ([2001:4830:134:3::10]:52621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZs0-0000Pk-OS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZs0-0004kC-0e
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:57:20 -0500
Date: Tue, 31 Jan 2017 14:57:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131145714.GQ18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-12-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-12-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 11/21] backup: move r/w error handling code
 to r/w functions
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


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:54PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> It simplifies code: we do not need error_is_read parameter and
> retrying in backup_loop. Also, retrying for read and write are separate,
> so we will not reread if write failed after successfull read.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 141 ++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 74 insertions(+), 67 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKXKAAoJEJykq7OBq3PIY0sH/35ZjKfW+YOlVY7dGts+9OVy
1cYxf4OiDw2fV8jQ0B2GolWXD94cUaSNwxqiPhr+AMplJSd8fnBCPSqOLrxW3Gwn
0/0o1j0qgEBAZsXR61Y/VXvY2W2jmveRal1C0xSSv9UYe84+o3L8lfz6OCD6IySo
uKTVCJg45coAtOOcYMFlwB1U1xaPQysK7y5Yxu3Z6xBt68lzRWeNif4LICbaYYDv
G/gcjmcrHS/desZUVl6NbjGa4Na+nRFdOuKrYL0ysmD8dMXmh1kWriMP06705aFw
CNEu0OXUN2UllGeVRnAyfdnEfph3XKoC//g7pyC/gHxd7q5VAU1Abtqu3aYnPGg=
=50py
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--
