Received: from eggs.gnu.org ([2001:4830:134:3::10]:33662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cjcqd-0002Ti-Jh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cjcqc-0007xG-Ie
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:21:35 -0500
Date: Fri, 3 Mar 2017 10:21:29 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170303022129.GC11833@stefanha-x1.localdomain>
References: <20170301115026.22621-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20170301115026.22621-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] throttle: improve
 command-line parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 11:50:23AM +0000, Stefan Hajnoczi wrote:
> v3:
>  * Added Patch 2 to fix invalid test parameters
>  * Switched to nicer max < avg check [Berto]
> v2:
>  * Fixed s/bps/iops/ copy-paste error in Patch 1 [Berto]
>  * Rephrased warning about guest hangs and errors [Berto]
>  * Added Patch 2 to hide the internal .max value from the monitor
>=20
> Patch 1 fleshes out the documentation for I/O throttling command-line
> parameters.
>=20
> Patch 2 hides an internal value that was being exposed to users via the
> monitor and caused confusion.
>=20
> I ended up not adding QMP-style throttling.* names to the command-line
> documentation because the names are very long and unlikely to be used.  I
> couldn't see a nice way of adding them while still keeping the documentat=
ion
> readable.
>=20
> Stefan Hajnoczi (3):
>   qemu-options: explain disk I/O throttling options
>   throttle: do not use invalid config in test
>   throttle: make throttle_config(throttle_get_config()) symmetric
>=20
>  tests/test-throttle.c |  8 ++++----
>  util/throttle.c       | 14 ++++++++++++++
>  qemu-options.hx       | 24 ++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYuNMpAAoJEJykq7OBq3PISeIIAIK/9hZ+ZXhiugX0rgedrLDj
dtbjbNH4DhZ1XPNLE0OCNQxQ1Klg9dvB4QF5WJekdYeU25adrW8AZRwgw2QdIB0K
4i6KAFOnL9jR+gKSH1KXMkMpM6/ftRqLgmJ7arzMnaGjKF7adgMk8hGuwhmLF/GX
Z9Q0yMCIwLlEaSBM80ATcYfpYWUGSEK8XMsI43CycFJnivhjcuKJg4Md7EIWRNxd
TuMMvOHxSWKpFxvrvpdKO2dBjJiGoteUAK52oGUOvJ36vqqdIObr9MUkOZrsYOB3
LTpiZKDOQ+uGk512o+B17bvFE4Tl6bw0L8AhcehIA5ftqc4uruERiz1/TC+CeOY=
=9RSY
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
