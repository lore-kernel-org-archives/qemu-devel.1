Received: from eggs.gnu.org ([2001:4830:134:3::10]:48450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECdV-0004OC-5W
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECdT-0008VO-Q9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:06:09 -0500
Date: Tue, 6 Dec 2016 10:04:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206100457.GI12630@stefanha-x1.localdomain>
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <1480973521-28945-1-git-send-email-jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org, stefanha@redhat.com, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:31:58PM -0500, Jeff Cody wrote:
> The following changes since commit bc66cedb4141fb7588f2462c74310d8fb5dd4c=
f1:
>=20
>   Merge remote-tracking branch 'yongbok/tags/mips-20161204' into staging =
(2016-12-05 10:56:45 +0000)
>=20
> are available in the git repository at:
>=20
>   https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>=20
> for you to fetch changes up to 76b5550f709b975a7b04fb4c887f300b7bb731c2:
>=20
>   qemu-doc: update gluster protocol usage guide (2016-12-05 16:30:29 -050=
0)
>=20
> ----------------------------------------------------------------
> Gluster block patches for -rc3
> ----------------------------------------------------------------
>=20
> Prasanna Kumar Kalever (3):
>   block/gluster: fix QMP to match debug option
>   block/nfs: fix QMP to match debug option
>   qemu-doc: update gluster protocol usage guide
>=20
>  block/gluster.c      | 38 ++++++++++++++++-----------------
>  block/nfs.c          |  4 ++--
>  qapi/block-core.json |  8 +++----
>  qemu-doc.texi        | 59 +++++++++++++++++++++++++++++++++++++++-------=
------
>  qemu-options.hx      | 25 ++++++++++++++++++++--
>  5 files changed, 93 insertions(+), 41 deletions(-)

BlockdevOptionsGluster.debug(-level) does not have "Added in 2.8" so I
had to dig through git-blame(1) to verify that it was indeed added in
the current release cycle.

In the future please make sure all QAPI changes are marked by version.
If there tricky changes you can include a statement showing you are
aware of QAPI backwards compatibility ("These new options were added in
the 2.8 release cycle and can therefore still be changed without
breaking backward compatibility").  This will make me confident that
you've checked the QAPI changes.

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRo1JAAoJEJykq7OBq3PI2fsH/R2VyvU5+zifBoisRfCFiK+A
SJDqgF/5V6ZgLilHdXRaHQYCjv3v3Vq8IGcaBUM0Ttiyo4tZTjVAvZW7bJs/Xoy6
Pd2idw2b/E8g2ZhR66mIFUjmm2vvEQtXk5oRarCc+SP9mm6X815fwSFutZXRTVdI
v0z8ukD8igOksQfMWFI2RXr2dLkRt4F9W9gQvDY38xH/rJ9F+9bEHI1somoTOA42
z56C1xlLhEk/irVpr+HBp0/TMskQmRjuC1BWHtj552psIXAvwX6Lnd9BJ2oUL8t5
dlUYhuuhQvLwioxZZZZ2N8kst7qtalppyN6o3WgZzDHPgUlpKs43dm4rKRxu5mQ=
=/dn/
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
