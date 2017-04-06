Received: from eggs.gnu.org ([2001:4830:134:3::10]:37110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6YS-0008Rp-2b
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6YM-0006Vo-L5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:30:24 -0400
Date: Thu, 6 Apr 2017 13:30:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406123008.GG21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 04/16] qemu-img: Expose
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


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:24PM +0200, Max Reitz wrote:
> Add a --preallocation command line option to qemu-img resize which can
> be used to set the PreallocMode parameter of blk_truncate().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c    | 33 ++++++++++++++++++++++++++++++---
>  qemu-img.texi |  7 ++++++-
>  2 files changed, 36 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5jTQAAoJEJykq7OBq3PIOXoH/A2hHkNqP8XpCXEo8zpy3Ao5
yvVZUFVMZFqcGBbOcgntzHV/dt0MxdrzVxytBFWnouEVLV97RTVbQVE8nexNQwuz
CMxsmxFbUc7Tx83emkJUOF3wLsTkB/qv2zIA92/wwbcTSU/18p3Df0h2UtvsxMzR
2hIv1fXMcjaJr9JNaRcgdHxC/EZTTVlweRUA39lCjuw2tTBHq7Z03Fu+CHF1af8I
Qga5QbVdxy8Id9djtZJknPR9UmJJkJNhAmmMJcSnxSSIEQzkqJ/BvrVR3WPUBGPm
o3CMg3gfsgiz6BRgVFuTSNJdCm4T0Oi6a1Q7sU4hkTMBmxelrWaJ8wo8f2nM+Ms=
=HyLU
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
