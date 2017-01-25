Received: from eggs.gnu.org ([2001:4830:134:3::10]:58879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNrS-0002K4-8w
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNrO-0005Xd-8Z
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNrO-0005XE-21
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:38 -0500
Date: Wed, 25 Jan 2017 13:43:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125134334.GJ10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Hr//EUsa8//ouuB"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/8] trace: move hw/block/dataplane
 events to correct subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>


--+Hr//EUsa8//ouuB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:45AM +0000, Daniel P. Berrange wrote:
> The trace-events for a given source file should generally
> always live in the same directory as the source file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.objs                   | 1 +
>  hw/block/dataplane/trace-events | 6 ++++++
>  hw/block/trace-events           | 5 -----
>  3 files changed, 7 insertions(+), 5 deletions(-)
>  create mode 100644 hw/block/dataplane/trace-events

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+Hr//EUsa8//ouuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKuFAAoJEJykq7OBq3PI58MH/1l2sjPi+d8DMaNQyQW4mL2W
IwH5ZInzbPZvsP8D40snFZuU8E6bCJ9nI77YNiEDz058mkV7eK7RpLRxf+I8+ZQJ
CsVsc8D/LalWiEFHPsAN1MTLoBUicvhl/GSliMO41n64bLnhQ4HHfZLaJM913B30
UjbIlaEm0I9+OnhDxudk+cXzR5+FK0ggGLiFsgqlgvYDzaFa08VINSCVC+62cRTp
EzukQ7pO9x4i5AGk7qiENmP1y+y755y5l+kvlV0b/lqW42tHa2ZWvs9W5V5m0Eww
j8U2HCMCtdw4s0O6Dvfeo1I3UWTIqpcaAn98fFVZLckvuVU3hs/O6iBXRdWMoMc=
=3ojP
-----END PGP SIGNATURE-----

--+Hr//EUsa8//ouuB--
