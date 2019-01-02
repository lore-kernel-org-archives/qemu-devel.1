Received: from eggs.gnu.org ([208.118.235.92]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gehDM-0000De-S4
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gehDL-0004x5-Us
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:09:44 -0500
Date: Wed, 2 Jan 2019 14:09:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102140936.GT24009@stefanha-x1.localdomain>
References: <20181228145055.18039-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ceuyUbi+oA5bUa/n"
Content-Disposition: inline
In-Reply-To: <20181228145055.18039-1-jcfaracco@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] dmg: Fixing wrong dmg block type value for
 block terminator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org


--ceuyUbi+oA5bUa/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2018 at 12:50:55PM -0200, Julio Faracco wrote:
> This is a trivial patch to fix a wrong value for block terminator.
> The old value was 0x7fffffff which is wrong. It was not affecting the
> code because QEMU dmg block is not handling block terminator right now.
> Neverthless, it should be fixed.
>=20
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  block/dmg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--ceuyUbi+oA5bUa/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLMYgAAoJEJykq7OBq3PISnUIAIREEpoX4A1LE+QgN2ivsCUO
DsRuyzOVfOmJQ2vj255xL664ZW/9F3/GLGVthRIJ6oBN40vLH4d0ZhBNFmmb1dvU
Wk4ffsNHwxA+RoVjMrsSqKz9x1YtZlE+zatEKfX4pcmeL9O+KpzetoluW0q+0Dtm
NhpIWT4D6dTadtsaYs56gedMjKOb1EO/HsQdUS2YE4mCp6OFH+QHitTTcUL8OM6G
+Ip26+gaCTmhKRIMd/M0SFyr96W/QGMcaH4RTnoVH4oDUxeg8YL12/q0HAK2Ube4
v0M8WiXd/zQX8+cUL2R6QQPEUh7o/Eo2GMI6Afvr0KKTw4KNIM5OmbxnK2ZlYh0=
=MllY
-----END PGP SIGNATURE-----

--ceuyUbi+oA5bUa/n--
