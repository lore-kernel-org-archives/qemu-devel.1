Received: from eggs.gnu.org ([2001:4830:134:3::10]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkHi-0005MR-Df
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkHe-0002xx-De
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:42:10 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:55409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eCkHe-0002xc-6M
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:42:06 -0500
Received: by mail-wr0-x242.google.com with SMTP id l8so5128594wre.12
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 02:42:06 -0800 (PST)
Date: Thu, 9 Nov 2017 10:42:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109104202.GA17101@stefanha-x1.localdomain>
References: <20171107153136.19426-1-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20171107153136.19426-1-namhyung@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] trace: Simplify find_debugfs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Namhyung Kim <namhyung@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 12:31:34AM +0900, Namhyung Kim wrote:
> The return vale of find_debugfs() is 1 if it could find a mount point of
> debugfs.  It can be saved in the while loop instead of checking it again.
>=20
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---
>  trace/ftrace.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks, applied all to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Please send multi-patch series with a cover letter in the future (git
format-patch --cover-letter).  Continuous integration tools may ignore
multi-patch series without a cover letter.

qemu.git/master is currently frozen for the QEMU 2.11 release so you
won't see your patches in master until QEMU 2.11 has been released.
Once the development window opens again your patches will be merged into
qemu.git/master.

Stefan

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBDD6AAoJEJykq7OBq3PIEwMIAIdSD01qIaznLd6WkRXJYKPM
163Cg5vzU6JXH2fDDx6i9Fl00w8j/SoJyp7mxArCMlRZrQaF6M3YgX/fflOAidh8
/DVOlyCu0EGPdO3+zK6b9y+d66UN9f5D0mq5UouzGlO0R34YYYIivOHDajcaiJv/
MnUswKvo3/5audMkSj4zROvP8SOsDf/pSfOIom8SUq1sB89HRzQqpEbL3VNZVE19
Qaa4Yq2TgWk5himNeMah2ah9fNyQ3zJh/j67rztK6qoEiSBwFOfShx+IkIxfwUrf
nsxkedGCK29lmb/Uc87ABscQCwYWx2k7IjFT0Kkei0hmlCF//fFzdp1lY/uA1aI=
=uI0r
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
