Received: from eggs.gnu.org ([2001:4830:134:3::10]:42389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8trp-0000lj-Ma
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8trk-0007DC-Pd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:35:17 -0400
Date: Thu, 11 May 2017 15:35:09 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511193509.GH24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 05/16] block: Propagate
 BLK_PERM_AIO_CONTEXT_CHANGE down the graph
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


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:45PM +0800, Fam Zheng wrote:
> bdrv_set_aio_context can take care of children recursively, so it is
> okay to pass down the perm.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c       | 10 ++++++----
>  block/vvfat.c |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLztAAoJEJykq7OBq3PIzZoIALzgesr3r5aPAPp54g/W6Z25
sGrFMW1/nOXJXlHXRCSrvbaNg9BQQRWNFKJKax/1K+dTrZS5XOUCwoEPlDtchcNX
mfJrww5iCD/FUaqPy2iO6lOwR1LSL19Kt3rFsWfwHIOHHgqJjctKU2fIWViJuc9g
Uht7J0ojsdENYh8JYTQ6PhkQ5QB3nwNJ776nzf3+MNk0ODCT3C9RfvNkAS/blEfR
pcA5Jf/0lRxiwVHo11vyHOfyXk9YkALMvvWMVuhET8PtBsA/Iy2dq4CtTgDJK6Jk
a152dQCIKxsIRXLov74+R1PmrIYPloiovvNAAinFLQ/OK6kglZcUIxBEmhIr2O4=
=vh1y
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
