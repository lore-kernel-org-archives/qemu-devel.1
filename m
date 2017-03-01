Received: from eggs.gnu.org ([2001:4830:134:3::10]:56711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj3EN-0008LP-C4
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cj3EJ-0007Uy-Dj
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:19:43 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cj3EJ-0007Ug-7n
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:19:39 -0500
Received: by mail-wm0-x243.google.com with SMTP id v190so1009981wme.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 04:19:37 -0800 (PST)
Date: Wed, 1 Mar 2017 12:19:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170301121934.GD29473@stefanha-x1.localdomain>
References: <20170228122901.24520-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <20170228122901.24520-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix stale 'trace-events-all' file in
 build dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 12:28:59PM +0000, Daniel P. Berrange wrote:
> If systemtap support was disabled, the trace-events-all file was
> only getting regenerated at time of 'make instal'. This is bad
> because it leaves stale files in the build dir for developers.
>=20
> Daniel P. Berrange (2):
>   makefile: merge GENERATED_HEADERS & GENERATED_SOURCES variables
>   makefile: generate trace-events-all upfront
>=20
>  Makefile                   | 39 +++++++++++++++++++--------------------
>  Makefile.target            |  6 +++---
>  target/s390x/Makefile.objs |  2 +-
>  tests/Makefile.include     |  2 +-
>  4 files changed, 24 insertions(+), 25 deletions(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtrxWAAoJEJykq7OBq3PIKBoH/Rws2Ni0fCst9gfU1QjmFhyz
ws42D8W9jaCntTMeYupQkKUDueGQS2i4Cbcf+HK9E3xnjlNlwm5y+7ru/Qq21nO4
mZN6DZDYtwmZS9EpHeE/MGO+00TTs6oqf9qd4P2P3ECitxo4wLuyHhA5FytIP6sd
WHrA3YkfUcGQfpVjGw3CUfFPp80cBWaL5WwO1ovcKTKjBesqjyDPj2I1IzojLI2a
Y5Q42Tf1nHiJ28DBv6v9LhBvrcOJY8mnxKMT6YGMCklmyFcmM8yFuhW9hbiVtnNs
WQLMbZpdN8GAPml7C/mbOQ/LV7HDWOPOxnPm1ZHOoDKMlNvjq1Or1DfPbs+ddo0=
=/sXH
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
