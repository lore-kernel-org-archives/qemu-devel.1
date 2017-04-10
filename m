Received: from eggs.gnu.org ([2001:4830:134:3::10]:34425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVbD-0007GT-O7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVbA-0006Ay-Lp
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVbA-0006Ag-Ff
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:00 -0400
Received: by mail-wm0-x241.google.com with SMTP id o81so8537008wmb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:27:00 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:26:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410092657.GE2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] blockjob: introduce
 block_job_pause/resume_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:22PM +0100, Paolo Bonzini wrote:
> Remove use of block_job_pause/resume from outside blockjob.c, thus
> making them static.  Again, one reason to do this is that
> block_job_pause/resume will have different locking rules compared
> to everything else that block.c and block/io.c use.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c               |  18 +-------
>  blockjob.c               | 114 ++++++++++++++++++++++++++++-------------=
------
>  include/block/blockjob.h |  14 +++---
>  3 files changed, 77 insertions(+), 69 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY60/hAAoJEJykq7OBq3PIKvgIAK6niUKuoRjbbNQ89kZk1Toy
vm7z+t3YRGpXd5dVkVazOdaXI8yPmA9gFCMbGPB9yJW4gKYxXUpTcAfatdzqor8X
oGG4/+wtiGpMe3vOAaVneFoyr2NFkPt+ya1BbJqAWgdbMYAQxHKdoWA2w3IlqeYK
wr+2VgOZ1poNL6Duouce2lhqw9S58akNweae+xax3q1c+oSUpGeupd41xTYrKjve
I+SEXINJ6jWmm7JTa6E7c3UCyOaHsl3spSNSPGhq41FiqLHBnALoIBXLCmSQsEiJ
k4lu21aDRe1+sCC3bBTX0LOhASVOAcy+dG7BoMk/9jMFuHmtsce1j4DW9HoNVYc=
=X7Nu
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
