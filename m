Received: from eggs.gnu.org ([2001:4830:134:3::10]:60387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6ewR-0005EO-O3
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6ewO-0006Rr-I0
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:14:47 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6ewO-0006Rb-A4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:14:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id u65so1930361wmu.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:14:44 -0700 (PDT)
Date: Fri, 5 May 2017 16:14:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505151440.GE14316@stefanha-x1.localdomain>
References: <20170503213659.11828.39423.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20170503213659.11828.39423.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PULL 0/3] VFIO fixes 2017-05-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 03:38:39PM -0600, Alex Williamson wrote:
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170503.0
>=20
> for you to fetch changes up to 6e4e6f0d403b1fb25f9dfdbe17754c643997753d:
>=20
>   vfio/pci: Fix incorrect error message (2017-05-03 14:52:35 -0600)
>=20
> ----------------------------------------------------------------
> VFIO fixes 2017-05-03
>=20
>  - Enable 8-byte memory region accesses (Jose Ricardo Ziviani)
>  - Fix vfio-pci error message (Dong Jia Shi)
>=20
> ----------------------------------------------------------------
> Dong Jia Shi (1):
>       vfio/pci: Fix incorrect error message
>=20
> Jose Ricardo Ziviani (2):
>       vfio: Set MemoryRegionOps:max_access_size and min_access_size
>       vfio: enable 8-byte reads/writes to vfio
>=20
>  hw/vfio/common.c | 14 ++++++++++++++
>  hw/vfio/pci.c    |  4 ++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJbgAAoJEJykq7OBq3PIsMUH/jrJ3YyDa5D4YeBYZke3NU19
9dIchtzcmEY2bz+y8t72AWKqXigYyUOjAAV6RfIbJUMu4cCgmfe6zD67Y7f6nnPr
fwimcpPdZzFiCPD4ZPpso/ssghG/D6LHVwo2HU601aFZ8bjed+XMR4JCFlSygszC
jq1K9nitqPLmwcdgYFWtegfwEGQze6kIacBBPP4SDVTWK3iq8y4BipDbj9uAv0R3
nubVO2E5sy4mIYAsQPzLu5xtHBtjVBF1nVDFkSu53qz6YjNkoScAZeLKFtbIjfRz
/hWlyjAWh4GvvtLtxgptJsCblp0YPoFOkfRYlO1xBdYSpzBUfRk/LFkXq9Vnh4U=
=8JI+
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
