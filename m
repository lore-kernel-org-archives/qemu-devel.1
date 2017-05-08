Received: from eggs.gnu.org ([2001:4830:134:3::10]:41270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lnm-0004My-MM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lnj-0005gp-JH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:46:26 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:34284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7lnj-0005gi-Ex
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:46:23 -0400
Received: by mail-qk0-x236.google.com with SMTP id k74so57159313qke.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 09:46:23 -0700 (PDT)
Date: Mon, 8 May 2017 12:46:20 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508164620.GE22428@stefanha-x1.localdomain>
References: <20170505085724.GB7278@kentang.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20170505085724.GB7278@kentang.lan>
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 09:57:24AM +0100, Mark Cave-Ayland wrote:
> Hi Stefan,
>=20
> This pull request contains just the fixes for the Coverity warnings spott=
ed by Peter from
> the last set of cg3/tcx patches. Please pull.
>=20
>=20
> ATB,
>=20
> Mark.
>=20
>=20
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>=20
> for you to fetch changes up to 8eb57ae3f9afdd8d911f3b2862e05cd0bb042b4e:
>=20
>   cg3: add explicit ram_addr_t cast to scanline page variable (2017-05-05=
 09:49:00 +0100)
>=20
> ----------------------------------------------------------------
> qemu-sparc update
>=20
> ----------------------------------------------------------------
> Mark Cave-Ayland (2):
>       tcx: fix cut/paste error in update_palette_entries()
>       cg3: add explicit ram_addr_t cast to scanline page variable
>=20
>  hw/display/cg3.c |    2 +-
>  hw/display/tcx.c |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKDcAAoJEJykq7OBq3PIJGAH/3kBoT9A2GALm/Jlyqacf5BO
nSLkGXTMwi7JfLCmGS+uhHwcKaBprUYuyRb7v4yMua0lNU6Wx5bKkBp3fjuid3Dw
dqZEWvFO1flfA6SBfpXbjALHm6mrvJOEAzJIl5uTZoRhKVtK98Ho4DiLIlTdkcnQ
gkwqtLYIjMF6U8nRrGR43mEUaM5WpwUntjdxO68Z00cxAG+kEd7p6PBugxHdM62b
amO31VXcPAqiuLWunwqUKsTYDkSTsiXxMgO9q75vP17Wdc/R0BrgaPyAVP8Ds6xz
WR2dJQesF9IRvs3MtTsCvUOMQBcqh37MGUT9nnGaWXP2Cu+mQqv5cuDWIOv2aZs=
=Muzj
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
