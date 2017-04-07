Received: from eggs.gnu.org ([2001:4830:134:3::10]:53407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPqt-0000AX-MF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPqq-0001Iq-IF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:06:43 -0400
Date: Fri, 7 Apr 2017 10:06:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407090633.GF13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<114fed348a816c240ed64fa1c5edb863f45ec1e9.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <114fed348a816c240ed64fa1c5edb863f45ec1e9.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/9] block: add
 bdrv_set_read_only() helper function
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


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:28:43PM -0400, Jeff Cody wrote:
> We have a helper wrapper for checking for the BDS read_only flag,
> add a helper wrapper to set the read_only flag as well.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c               | 5 +++++
>  block/bochs.c         | 2 +-
>  block/cloop.c         | 2 +-
>  block/dmg.c           | 2 +-
>  block/rbd.c           | 2 +-
>  block/vvfat.c         | 4 ++--
>  include/block/block.h | 1 +
>  7 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51aZAAoJEJykq7OBq3PIV8EH/1Rvm+0RC2/K6lrPl3rsdT2z
/mq6rNd7E1adqa/RNYRwHqcyDFZh7BOYlBEARq3nCqYAlhDO+LvIBg786mg9NKAG
X1I4+6xZHJp2VIaHMNXCzAXg7Y0SbXGnUtUu5YRBgUSPSPsjgJb80VVqGQ7nDF50
0RRG889gN2ulKHJ6Pyy5xkl0r+hMzrQ/pjgr9IWxjtFHG8KhW/+hr/RM5SBBwXn9
J2CZOexdmyp4WzvMpoUbKRLwpQ6qL45V/OcRl71QTIykQ+F9S4lWlFPociMfgfIs
f9/yEPq4Yuhv0BzO+Il4I2ZPMWJURbdS/y+zpt/s61zyEbs1pUqtw0dEUeZ6cOo=
=R/Q1
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
