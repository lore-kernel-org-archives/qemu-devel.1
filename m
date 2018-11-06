Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJy4v-0000p2-9i
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJxs1-0004oY-PI
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gJxs1-0004gM-JZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:42:01 -0500
Date: Tue, 6 Nov 2018 09:41:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181106094153.GC13475@stefanha-x1.localdomain>
References: <20181104222312.3548-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20181104222312.3548-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, famz@redhat.com, peter.maydell@linaro.org, jcody@redhat.com, berrange@redhat.com


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 11:23:12PM +0100, Paolo Bonzini wrote:
> Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HT=
TPS is
> the preferred protocol because it adds some protection against
> man-in-the-middle when cloning a repo.
>=20
> This patch series updates git:// URLs and changes them to https://.  The =
https:// URL format is:
>=20
>   https://git.qemu.org/git/<project>.git
>=20
> The old git:// URL format was:
>=20
>   git://git.qemu.org/<project>.git
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  _download/source.html | 2 +-
>  contribute.md         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4WHhAAoJEJykq7OBq3PINcsH/jVgk+HWMzXZfwQktUkd1Ike
e9FHtiOraEjHrXPYp6z+R4hW3mBQN6MbcvvTKps+BRAd4gJerKl8SEotuGJPtKhz
PLS2OacGwFjAptICpouiADr+vuwnvt2Domoiynrh7NoI2BpQfBlFNbi97ghbE/Rk
m34VxMWSdj+izeOZdNwl3DJG8QRrS3X+jPBx5NJ9aDv96z/TdrVYFOvdto24MAyk
rM992tMF0fvJ83+BBKmMqm4mveRaEZpy8/FiMj2X02QfU+pBovmbb98XWCoCmbVT
O7OiLPR5rnL8+DtOu4qaBgFmSYay1NpTQPUTs78bn7kPCc78RaXWKAoryOeKV1Y=
=s+4T
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
