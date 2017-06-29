Received: from eggs.gnu.org ([2001:4830:134:3::10]:34147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQa4X-0004WV-5R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQa4T-0005M9-7Y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:05:29 -0400
Date: Thu, 29 Jun 2017 15:05:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170629140521.GC18146@stefanha-x1.localdomain>
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
	<20170627224616.18538-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20170627224616.18538-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: pass bdrv_*
 methods to bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 01:46:15AM +0300, Manos Pitsidianakis wrote:
> The following functions fail if bs->drv does not implement them:
>=20
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
> bdrv_media_changed
> bdrv_eject
> bdrv_lock_medium
> bdrv_co_ioctl
>=20
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c    | 45 ++++++++++++++++++++++++++++++++++-----------
>  block/io.c |  4 ++++
>  2 files changed, 38 insertions(+), 11 deletions(-)

Will you send a block/raw-format.c patch that removes the forwarding
functions that are no longer needed?

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZVQkhAAoJEJykq7OBq3PIA/QIAJWlLse2yKc5ViFS9KfVkH5Z
aOYHdY4GqIGdPVq8JrykXT+v4p6Wjr1jiZxtQkOrrI4TtxJLz9rT/e445Y8lM2eF
x4pCohX18uyLcBiiQhuTz8/BJG/mKtUXZzQM87QRYUyy572s66r/okOLEqbn3g16
pVfKehPEQy3xkOSyi72vQ/9R7M7pjePEJpcWSzwtdAGbD/rZK9qTrhECL0PbQchJ
/MDb3y46XL/pAQIGKDcvcTfhD+qWFE/ub7H7ChAai4y0XqaG+uBv0Wmk0vaEUPou
Ypd39Y4pBYg8SCb7siiq+XEFlomkQpHAP0bcDW7gOoxhFew/60NbQ2r0ldN2Sa8=
=WMn3
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
