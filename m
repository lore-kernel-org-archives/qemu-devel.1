Received: from eggs.gnu.org ([2001:4830:134:3::10]:49234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0ZY-0006Hm-85
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0ZX-0002tg-Eu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:09:48 -0400
Date: Wed, 31 May 2017 11:09:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531100940.GE15666@stefanha-x1.localdomain>
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20170526165518.7580-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 04/16] qemu-img: Expose
 PreallocMode for resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 06:55:06PM +0200, Max Reitz wrote:
> Add a --preallocation command line option to qemu-img resize which can
> be used to set the PreallocMode parameter of blk_truncate().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c    | 33 ++++++++++++++++++++++++++++++---
>  qemu-img.texi |  7 ++++++-
>  2 files changed, 36 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpZkAAoJEJykq7OBq3PIpd0H/jWW2dBxJzTvtlgcs2LSy2dU
oBlXaJ7ZKUjx/IEon14/pz148CDNCWoUbq2kalfBRmJrHhhBPIX/qEOUoArUPGTO
SiW/ONeSk49jTTcPq7BRrZg2rXBasZ+0dDSfWqBCS6vjEYN21liwoWa5eiAWR3pf
F6+XTx55g4yQZvL1ubHTFeuUv86JX3U6QYvWjUbV+/Hm43bqJ++/IfgMMqe/lSqX
EpUjx7sO42dS91tmcwIjMOxooJ98ezlkC1B/1Ri2lLz3z5UAPXqZKVDph0dstwdw
nYqcqVLrw08O4aU3Jn3xi0QO3hrpm6xDKorVELO+pXL9VUhazo+GDATZVceldFM=
=gTE0
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
