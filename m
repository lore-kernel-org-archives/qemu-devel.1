Received: from eggs.gnu.org ([2001:4830:134:3::10]:49743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2ah-0004vy-50
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2ag-0003x1-Fg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:19:07 -0400
Date: Wed, 31 May 2017 13:18:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531121857.GD16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-4-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-4-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/29] qed: Remove callback from
 qed_read_table()
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


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:44PM +0200, Kevin Wolf wrote:
> Instead of passing the return value to a callback, return it to the
> caller so that the callback can be inlined there.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-table.c | 79 ++++++++++++++++++-------------------------------=
------
>  1 file changed, 25 insertions(+), 54 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrSxAAoJEJykq7OBq3PIZQYH/26QBTaBqx/8r4SG4aPsZHOE
XVtLyTkmCa5VdAERvXC0LIC1qU2FCHLnf9VCXXZk12isuuTPsCatxKXND78c5EE6
62qcA/oZdmhLJdxo2eMKHtxM8bLN/MBf8pKaZiXPoggZo+E1AdjLdP/7YMcshLPz
wu22KOh2rHijdh1jezF+t0jxYRLT3Ow5X6XdKEOksVrG81+NgB7fF+xYs+2UVS9j
CD+Gh93G//rtiyBK3J3LVGUMsqH3azsLijmVD6brwnAdP2X5MZS9/iBL03of7quP
uHMDsEBhsnDF1rbBE91I4x4wI7hRMaXCM9N4mrV9bKkriKHGy5Hf0XlcjVLlhaY=
=i8qQ
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
