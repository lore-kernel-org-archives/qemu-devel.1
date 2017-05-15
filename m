Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFkr-0002fd-Rq
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFkn-00038f-JI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:09:41 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAFkn-00038M-D0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:09:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id u65so28122117wmu.3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:09:37 -0700 (PDT)
Date: Mon, 15 May 2017 14:09:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515130934.GE1201@stefanha-x1.localdomain>
References: <20170511144339.13027-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <20170511144339.13027-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/4] make display updates thread safe,
 batch #2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:43:35PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Here is the vga patch queue, with the second patch batch to make display
> updates thread-safe.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-vga-20170511-1
>=20
> for you to fetch changes up to bfc56535f793c557aa754c50213fc5f882e6482d:
>=20
>   vga: fix display update region calculation (2017-05-11 09:50:32 +0200)
>=20
> ----------------------------------------------------------------
> make display updates thread safe, batch #2
>=20
> ----------------------------------------------------------------
> Gerd Hoffmann (2):
>       sm501: make display updates thread safe
>       vga: fix display update region calculation
>=20
> Mark Cave-Ayland (2):
>       cg3: make display updates thread safe
>       tcx: make display updates thread safe
>=20
>  hw/display/cg3.c   | 41 ++++++++++++++++----------------
>  hw/display/sm501.c | 27 ++++++----------------
>  hw/display/tcx.c   | 68 +++++++++++++++++++-----------------------------=
------
>  hw/display/vga.c   |  2 +-
>  4 files changed, 53 insertions(+), 85 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGaiOAAoJEJykq7OBq3PI4TsH/RSxDLXLvwbK1bqwcn09oMWZ
V/V6yY027KfIevVEr9oE5BMlVCWcrfcvNCRUJiCit0p8RjASomrThYuvRYWzkTL8
wF6pXy8GALDP1Gu1WLoE63nej1PZ/UgrYt58pLrOLoGqP4Xgb3PnTgvqEynMRUBL
ySqD9TbC2jeY+f4OVXyCnQeM0UfR0Rr/Ci8LL0bUTr8kDYx2gEghQB4Wz1AZ9CeL
dF9HFQE4Ql+DbBMQ3YaefhbzGwpKMtA0l7K4jIi2WK/1gWperWdmvqqwdaEKBfyr
pt7ZUbevVTvgyJ+82PC4EfiaafGiOPyfiZ9ilsEhYCBK+l3vT11xf4Pd3eSLgf4=
=Mhm+
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
