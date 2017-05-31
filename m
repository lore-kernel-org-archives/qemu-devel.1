Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2hC-0000Fm-GB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2hB-0006n7-OX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:25:50 -0400
Date: Wed, 31 May 2017 13:25:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531122540.GG16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-7-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-7-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/29] qed: Make qed_read_backing_file()
 synchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:47PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrZEAAoJEJykq7OBq3PIvEsH/2oi+Ss3kJM1QBC6fzQtA2m5
6xkj//5pNqdQsCouLA1o1YFowue6ULbfQyVd95u3diGr3M8Rb9XWhuTEKnCCcnSC
ygs9CrffUE0Pf/U8SiS1LB9UTiawaFY+67qb0Kmubl0eYyayWIPxsz+hKV7xdb/B
1FXdFvBP+aX7smx+UzwjGQV9PtRKhykeFplTUA+jeGrKtwiI1t3uv11Zs13ECqtB
P8ngz00R1Wa9d87ii7+/SqQfFUKhRozPeiEMj2WbKVjKR0CdFX4U+On+B6D85ePJ
GGz5uGKZ9mTTwQVVWf2d8nZAcyiT7cp8Rv03ZfPzNNodB7nouh1f1Xp5c0zreHA=
=Fe/s
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
