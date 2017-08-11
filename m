Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dg7Mv-0003jd-Sl
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dg7Mq-0000XD-P1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:40:41 -0400
Date: Fri, 11 Aug 2017 11:32:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170811103211.GD4568@stefanha-x1.localdomain>
References: <20170811015749.20365-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <20170811015749.20365-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: Fix trace message for
 disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 08:57:48PM -0500, Eric Blake wrote:
> NBD_CMD_DISC is a disconnect request, not a data discard request.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Although this is not 2.10 material in isolation (it is only a
> bad trace message), I don't mind including it in a larger pull
> request; I'm still planning to fix the issue of a client hanging
> on a malicious server in time for -rc3 (whether via Vladimir's
> patch or a smaller one that I'm testing locally).
>=20
>  nbd/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZjYerAAoJEJykq7OBq3PIwSUH/A1hRUXUuXxUKMo2XrcEJEsE
0AQ2HRhbasUlb9IrxFJeoAS58dbJzVm10Ao5b66Pu8VV94AB9J3lxQFsWEc3xNpl
gmL6hSO1ozf28LSVJFdan0cLWCfuaTa5ONkAG+p5o1zEDk7aL39NsrfTFC9lhpgA
hnCYiRktnWC+S4RrYHH3Md2p8HGfftUFkn/VguP7xj5EGW4XYbNoe5YaKxoJygdA
QGK04NPQGAsWWS6VV+LeoruqrR334wEuQGH6rU/G2bwC+H7FVo1K0kq2RVv0NxPM
8xtgktBhb4laSr/4xKWuQtnOjbchSMLG15/lH9Iw4yZin/KFuR0BEO9Kv39L5kc=
=6dgY
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
