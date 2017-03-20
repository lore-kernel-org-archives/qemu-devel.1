Received: from eggs.gnu.org ([2001:4830:134:3::10]:56118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuH0-0002H5-Np
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuGz-0005an-PN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:10:46 -0400
Date: Mon, 20 Mar 2017 09:43:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320094351.GA17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 12/16] block/qcow2:
 Extract qcow2_calc_size_usage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:41:13PM +0100, Max Reitz wrote:
> We will need very similar functionality for full/falloc preallocation in
> qcow2_truncate(). Although we will not be able to reuse much of the
> actual code, it still makes sense to keep all of this in one place.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 126 +++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 68 insertions(+), 58 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz6RXAAoJEJykq7OBq3PIHZsH/2pBT0kF/hcDjHT8pdI5sdJM
HXJJTQGWBP3JegONQkL3RVOQOfb+xOiRmx90fQ3BUM77VKKJ7FGZZcE9/CmRFUIE
xfhxXKKXWdgw5lP3i5xmr+kESxiFMNZWQqlVno7Jfs40ZAn6+IDZKTtdqgnnp7uz
Z47uDBr0CSC/lb+WpQ017fsK7KGSBqB3SRuLtFMr+5yVNxCkpvlyeqnKYxfnyN1R
ArHhWUXzFWD9AyjFmvLINbFNOb6Xab9nNGsUvOX2KR0Si1ITALx32ohEl1SK68ve
hMA73YAjU6XqwH1z12OS33mrkQCmVkg4kZm07KWb+5ucysgDAUO5kzcRshRNxq4=
=FSRJ
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
