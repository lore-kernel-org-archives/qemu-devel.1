Received: from eggs.gnu.org ([2001:4830:134:3::10]:49835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7mMT-0004gI-WF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7mMQ-0007HL-Qd
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:22:17 -0400
Date: Mon, 8 May 2017 13:22:11 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508172211.GJ22428@stefanha-x1.localdomain>
References: <20170506124314.23354-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <20170506124314.23354-1-aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/block: Introduce rotational qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2017 at 02:43:12PM +0200, Aurelien Jarno wrote:
> The Linux kernel uses different I/O scheduler depending if the block
> device is a rotational device or not. Also it uses rotational devices
> to add entropy to the random pool.
>=20
> This patch add a rotational qdev property so that the block device can
> be configured as a rotational device or a non-rotational device. Default
> to true to not change the default behavior.
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  blockdev.c               | 4 ++++
>  include/hw/block/block.h | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKlDAAoJEJykq7OBq3PIvA4H/jnorkYuhCAVonogLIBE+gAH
RnhwbbbrbOMi3RhI03B5rE8aOgOVeCCtXEbMM/HaXukxhBvNBm4go6h57JhPx5TN
zE6MZ2cXUWQz1Oo+HIOIE+3IvKPQXkOoy/nIy3Du06IrNBCW9mOL8YP8wysyv+QM
216ZKyUsZY8VttpITEQAZwMDO+YVr3Uer1KDq3/Zoj/GJKTWyB/BWTgKa5ws7a3c
hU/QHce5aCF6T1L4uYfMMqWCP4ettqc2T+Ji170D0nNaPSvUJEKsd86PsQnr+7Wa
C4UihnFUl+o+0T9c1+X9/miKSy11vo2nK3YtrdRqr/E83oykawjLzGBKWJWgoiQ=
=IU6z
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
