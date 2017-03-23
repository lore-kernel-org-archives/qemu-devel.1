Received: from eggs.gnu.org ([2001:4830:134:3::10]:43596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyZs-0003Lv-2U
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyZn-00064n-Q6
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:58:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cqyZn-00064G-JW
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:58:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id u132so15075081wmg.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 01:58:33 -0700 (PDT)
Date: Thu, 23 Mar 2017 08:56:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323085559.GL16717@stefanha-x1.localdomain>
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
	<1490092792-30957-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
Content-Disposition: inline
In-Reply-To: <1490092792-30957-4-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2017 at 11:39:52AM +0100, Thomas Huth wrote:
> HMP commands do not get any automatic testing yet, so on certain
> QEMU machines, some HMP commands were causing crashes in the past.
> Thus we should test HMP commands in our test suite, too, to avoid
> that such problems creep in again in the future.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |   2 +
>  tests/test-hmp.c       | 160 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 tests/test-hmp.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY042fAAoJEJykq7OBq3PIW14IAMEPRXezStSeJ04QHAls7Cku
U3FE0y6slwtrTgHsRtBFh0q4X/I2jvnpoiOp2WOiBZLP3IrtcotfHEasn6IHbl7/
C3JOOXhvTLMQYpcVgu+GC6AG6RvCUPRrIsgfnofgJYY/t6bT3kYJRKwXRBIhwF9W
jBnm3n1mXBfHdyYBwTRBAw0XwPy3WACZueCEiMO3YB6HfIxWsqr4dHQLKQNUdXcz
dL7jT045oLiiakDQ85jxV2TLGiN4KnEr4SbjVPOIRieRbfRzsL1vTatMWuVOuOSY
LqtzQin5/eotrQgW5Va0a/G2TDk6h319zZgklb0iO1JmPCAOFuN+9X24kYs9TvA=
=R8Cv
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--
