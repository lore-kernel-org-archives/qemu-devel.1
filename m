Received: from eggs.gnu.org ([2001:4830:134:3::10]:39937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1U6-00013P-Ow
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1U3-0006l5-AB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:34 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df1U3-0006kc-31
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:31 -0400
Received: by mail-lf0-x243.google.com with SMTP id t128so2069104lff.3
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:11:31 -0700 (PDT)
Date: Tue, 8 Aug 2017 11:11:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808101127.GG16801@stefanha-x1.localdomain>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline
In-Reply-To: <20170804213625.3756-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] Remove scripts/qmp/qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:36:25PM -0300, Eduardo Habkost wrote:
> The only purpose of scripts/qmp/qmp was the ability to run QMP
> commands non-interactively.  Now it is possible to run qmp-shell
> non-interactively by providing a QMP command a command-line
> argument, making scripts/qmp/qmp obsolete.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp | 126 --------------------------------------------------=
------
>  1 file changed, 126 deletions(-)
>  delete mode 100755 scripts/qmp/qmp

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY5PAAoJEJykq7OBq3PIRloH/R7pAaBV0sWq30w9vS1eXbzS
R6AKiSqNpsUZWV9juL6SkRx6ff9KgBgKPor7vLO1HwDI8D/x6gX1cvXe/LfwQAzP
U5FxurVrHlkQjjQNTqg2oRvfuFNUHTzslNzDmRj6u7hog6yDK6izR4P7c84AwubK
ZR4lATRhl5885FRdOBvAtgCenQm5qb8sbIccXgERyapoNonbeGiEwgn6MLqoI4je
es9RpWjQvlFHgq4GJYy/mR06vuBiykiSdX2qKnv7StFNAZ7FvR/gm9siCKdZunPR
TnGavPch6l+NTeSXbOKUr2qCDPNr9rtNHlmxtQaJTkjLRZVtPTb6rr8yGlUgmuo=
=m9LH
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
