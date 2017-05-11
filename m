Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uMa-0007l0-EL
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uMV-0003Fc-HN
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:07:04 -0400
Date: Thu, 11 May 2017 16:06:55 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511200655.GL24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-10-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-10-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/16] commit: Allow aio context change
 on s->base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:49PM +0800, Fam Zheng wrote:
> The block job has the aio context change notifier, we should allow it
> here as well.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/commit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Aside from my question about another user calling bdrv_set_aio_context()
on base in a similar situation in an earlier patch:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMRfAAoJEJykq7OBq3PIZsQH/0c90/jHDJl5m7d/fubnoqpq
0rAp+eeTKwopHzKKLjLh3CFIg5s1qIofGM1EM8FRDRmBne1ZHJisSM/4MIA90K/t
/WVdNLxcBAqAzECXpx/D4Ad+KYZ1S71mhWJ42k/3T5nmB5iPASfviOFbBXmVwdg/
n83I7Ts2oXm5m1k2Mq2Ql7ueQ+/ooj1mi3X2oezjhuTjqwMit96uiM83z2FF+jk/
NhbbKqw2a6jtBVaEnwK03QxRhDAr3Eme2fEToN14PPxK7trpXaOyTQXWfgW/mC21
KISHbSM/D6aUceauCZNGA1B9WDrZSQ8UQdY6DGWi6zESl6oqI4CLzkK2agKjGMA=
=gqqR
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--
