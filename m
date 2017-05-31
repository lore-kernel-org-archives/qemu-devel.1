Received: from eggs.gnu.org ([2001:4830:134:3::10]:59419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG30b-0004cn-4h
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG30a-0005zv-BP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:45:53 -0400
Date: Wed, 31 May 2017 13:45:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124540.GX16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-24-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ca23f2aBZR6YDKM9"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-24-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/29] qed: Remove ret argument from
 qed_aio_next_io()
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


--Ca23f2aBZR6YDKM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:04PM +0200, Kevin Wolf wrote:
> All callers pass ret =3D 0, so we can just remove it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ca23f2aBZR6YDKM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrr0AAoJEJykq7OBq3PIO5sH/3RpWVC9AKhOsepT2syfSskb
XQrSA6L9iGbM9SbG/KqPii1pw23V/WChARf+DuDGD2TfhZqVvypNOvKqoiG8/Trb
0kTW5RSnXF0PBJJIeFeGtAnuPpnqk9Ii97mwcCMCbUqP7Xs3MysBb8eR55w5KkaS
ONXwa7rrrdOzWKOyGLfmlxP6bMiMmiK76/VEms0y0OM7V1m5czB8Vca/PK81TLr1
Mir8uVp13ivUiFb+iJkfQjwjIX0uuBD4/MT5tqW12wyndKwjGdUgtm2khcI3gODi
iyVhopkitidfK01A7/eLr5/qjgdKggyC3TVeDNM+iM3uDFqw1Zm/FHYGOv3O5wU=
=28Hh
-----END PGP SIGNATURE-----

--Ca23f2aBZR6YDKM9--
