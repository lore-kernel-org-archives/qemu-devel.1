Received: from eggs.gnu.org ([2001:4830:134:3::10]:57492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgTZ-0004zp-Jy
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgTY-0004jr-Ey
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:36:01 -0400
Date: Fri, 1 Jun 2018 10:35:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180601093553.GC8687@stefanha-x1.localdomain>
References: <20180601062849.28641-1-famz@redhat.com>
	<20180601062849.28641-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20180601062849.28641-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 06/11] file-posix: Implement
 bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, eblake@redhat.com


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 02:28:44PM +0800, Fam Zheng wrote:
> With copy_file_range(2), we can implement the bdrv_co_copy_range
> semantics.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c      | 98 +++++++++++++++++++++++++++++++++++++++--
>  configure               | 17 +++++++
>  include/block/raw-aio.h | 10 ++++-
>  3 files changed, 120 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbERN5AAoJEJykq7OBq3PIxtYH/jJvroXoSWaiPb030utZHh8s
U5EzqRB9TIWiJKgLxWbFxFCGuuTQqp1QRMAq0SSlYG5ipXhiYSLf1S3IE5ZNGt2B
ufXl3+GxMOz2rzKJ06SfWWt2admi29FIJdD4WsFaRZeGypcd1low1R83wwKtG4xZ
0M5Xf1JshlAptJD7hOOCt4bmEGdH2ZXE0OoRkcN8DtkoGPGb9QBi5H5BR2sWFarh
Bved7D2KoIkciX5gjXMRPJkXcj8rbcoQ6zZ+a+41lyzND6icz0YjHdax2zrp7iE+
vyNvFkmKy7fgwket5h2e5FZ+5s5Yc0eNFMZi6jhQTxJTd7oqjBF/T/uV2U0Kfyo=
=1RBr
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
