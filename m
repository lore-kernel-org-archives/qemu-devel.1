Received: from eggs.gnu.org ([2001:4830:134:3::10]:56766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAa5h-0006ey-AF
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAa5e-00074n-5p
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:24:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAa5d-000748-V7
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:24:46 -0400
Received: by mail-wm0-x243.google.com with SMTP id s66so780556wmf.5
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 04:24:45 -0700 (PDT)
Date: Fri, 3 Nov 2017 11:24:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103112442.GN5078@stefanha-x1.localdomain>
References: <1509020054-25434-1-git-send-email-nanjekyejoannah@gmail.com>
	<e4b4b545-919f-f043-6a6e-70e563fa75ff@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7fwXp2o0gOrkU5lS"
Content-Disposition: inline
In-Reply-To: <e4b4b545-919f-f043-6a6e-70e563fa75ff@amsat.org>
Subject: Re: [Qemu-devel] [PATCH WIP] replace numpy with struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--7fwXp2o0gOrkU5lS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2017 at 10:50:26AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Joannah,
>=20
> The common subject to use is [RFC PATCH] instead of [PATCH WIP]
>=20
> On 10/26/2017 09:14 AM, Joannah Nanjekye wrote:
> > This patch replaces the use of numpy with the standard Library struct m=
odule where possible.
>=20
> This seems a good idea but why?

I suggest adding this to the commit description:

Users tend to hit an ImportError when running analyze-migration.py due
to the numpy dependency.  numpy functionality isn't actually used, just
binary serialization that the standard library 'struct' module already
provides.  Removing the dependency allows the script to run
out-of-the-box.

> Do you have any performance improvements results to share?
>
> > Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
> > ---
> > =20
> >  scripts/analyze-migration.py | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)

I don't see a removal of "import numpy as np" so this script still
depends on numpy.  Did you forget to sent further patches that you have
to remove the numpy dependency?

--7fwXp2o0gOrkU5lS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/FH6AAoJEJykq7OBq3PIbtwH/0AzMyWfMeRet4kwv6FMdC/G
iy0jChwkaV1wcL6PNWtG0dMLNxUU/lNXDsfRB4rF1t+SCNlOaYzBolC5V2/FfBCK
4CoZOFngeiUJHSid/fhuty/1DZ5dc/3lHKG87C824me9gWzeVf29GdsG5HtO2Mmn
ISqvv8WHxsk/9QGKt6ttjPQMnw/q0LDVaSrx2Ku0ufN9q/pyc+Kn3vy7GTPrfbqE
BhjrJKYwf4Udcd0JDxYnt0lP+w74sMy6ZXsDlZMP1epUWu21YjIn9kJnF6zG2lWV
gog8Fv74BXEdOkZ9OR31D1ixNwtSetE1ZTZFqg/I8xN1kpZ5S8iZ8xpBONnyTk8=
=uzzu
-----END PGP SIGNATURE-----

--7fwXp2o0gOrkU5lS--
