Received: from eggs.gnu.org ([2001:4830:134:3::10]:46813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG23D-0007Qw-4i
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG239-00068W-63
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:49:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fG238-00068A-UV
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:48:59 -0400
Received: by mail-wr0-x243.google.com with SMTP id p18-v6so32212254wrm.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 05:48:58 -0700 (PDT)
Date: Tue, 8 May 2018 13:48:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508124856.GO19710@stefanha-x1.localdomain>
References: <1525431107-44981-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="keoAwTxaagou87Dg"
Content-Disposition: inline
In-Reply-To: <1525431107-44981-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] rename included C files to foo.inc.c,
 remove osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--keoAwTxaagou87Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 12:51:47PM +0200, Paolo Bonzini wrote:
> osdep.h is only needed for files that are compiled directly.
> Remove it from included C source files, and rename them to
> *.inc.c so that scripts/clean-includes knows to skip them.
>=20
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/cris/translate.c                            |    2 +-
>  .../cris/{translate_v10.c =3D> translate_v10.inc.c}  |    0
>  target/mips/translate.c                            |    2 +-
>  .../{translate_init.c =3D> translate_init.inc.c}     |    0
>  target/ppc/int_helper.c                            |    2 +-
>  target/ppc/{mfrom_table.c =3D> mfrom_table.inc.c}    |    0
>  target/ppc/translate.c                             |    2 +-
>  .../ppc/{translate_init.c =3D> translate_init.inc.c} |    1 -
>  ui/vnc-enc-zrle.c                                  |   22 ++++++++++----=
------
>  ui/{vnc-enc-zrle-template.c =3D> vnc-enc-zrle.inc.c} |    0
>  10 files changed, 15 insertions(+), 16 deletions(-)
>  rename target/cris/{translate_v10.c =3D> translate_v10.inc.c} (100%)
>  rename target/mips/{translate_init.c =3D> translate_init.inc.c} (100%)
>  rename target/ppc/{mfrom_table.c =3D> mfrom_table.inc.c} (100%)
>  rename target/ppc/{translate_init.c =3D> translate_init.inc.c} (99%)
>  rename ui/{vnc-enc-zrle-template.c =3D> vnc-enc-zrle.inc.c} (100%)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--keoAwTxaagou87Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8Zy4AAoJEJykq7OBq3PIc94IAL+kkiQ2JfA9IacV/+aJZsbv
6aAcebFpYSvYqGYfi783LGQepPeI3ndt8IPRJMAaBEmbGRUyJWmE5qgnE4TwyZ3c
ukKRZ1BGuotviKgTqlyjk0YCIgRIJYnUoB6dAnsKdFkNVHNj6PlSYGn8FEbZHM+x
WwWrpr8kFqBEDpsD//MkBo9tenFtFMzsZH23idb4hacea01fHBVUmo4/JeESWzo6
0pa2Gkm/XfR3Gd9a5fKxIqjZqfWzjF++79BQOO/EBxtWXVFiAZxzsFNtKgIDzTZy
lryID8yCI6tzLjllVGl07pyjwlpsOtk2WET+Hf7j42hlhPnlT994vmFeJpZHyYk=
=sImD
-----END PGP SIGNATURE-----

--keoAwTxaagou87Dg--
