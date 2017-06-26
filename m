Received: from eggs.gnu.org ([2001:4830:134:3::10]:46384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPTd0-00035G-O2
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPTcx-0002m5-K2
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:00:30 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dPTcx-0002ls-DF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:00:27 -0400
Received: by mail-wm0-x244.google.com with SMTP id y5so106343wmh.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 06:00:27 -0700 (PDT)
Date: Mon, 26 Jun 2017 14:00:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626130023.GB7776@stefanha-x1.localdomain>
References: <149838891852.10366.11525912227070211356.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <149838891852.10366.11525912227070211356.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH] trace: Fix early setting of events with
 the "vcpu" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2017 at 02:08:38PM +0300, Llu=EDs Vilanova wrote:
> Events with the "vcpu" property need to be set globally (i.e., as if they=
 didn't
> have that property) while we have not yet created any vCPU.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> ---
>  trace/control-target.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUQVnAAoJEJykq7OBq3PIP00H/0ETKhp9Al+cZoT9ZPaJqXB8
qg6s3PhTNj6Xjapk9hpENQYXbf7/ZvMq4LySO+20zEAcHepba01VtJiOp0efLEsp
UE9VK/Rohna7WQ9AC921joid2nXnSZciZf8jkaZf2jUNXf1RjB+q4zWZaEr/SQZa
BygBqxGEaFfahIb5V3kHVIAE/OTmOdDbHJ2wuRQDEssGcQ0NbXEFljQ67CHpRGl2
JVj9QqQS5oOfJw/UGLvlJKs9NmSGr/nIT5ji1k/Kj/9ZjOQZFw+tnEk8ypG6Kuci
Pb3PrW5WO5TnyYXKHKOEcnb4Zd7Uz91dBzEdO8dPTUTz9UljqSuzyXetD3sm6xg=
=ZpzY
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
