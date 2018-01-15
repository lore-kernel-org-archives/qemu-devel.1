Received: from eggs.gnu.org ([2001:4830:134:3::10]:36337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5UE-0006Jx-Lv
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5UB-0007GH-Bx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:11:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eb5UB-0007Fv-2R
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:11:39 -0500
Date: Mon, 15 Jan 2018 14:11:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180115141134.GJ13238@stefanha-x1.localdomain>
References: <20180110202553.31889-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Content-Disposition: inline
In-Reply-To: <20180110202553.31889-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] tracetool: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 08:25:50PM +0000, Stefan Hajnoczi wrote:
> This series improves the tracetool error messages to make them more
> user-friendly.
>=20
> Stefan Hajnoczi (3):
>   tracetool: prefix parse errors with line numbers
>   tracetool: clarify that "formats" means "format strings"
>   tracetool: report error on foo() instead of foo(void)
>=20
>  scripts/tracetool/__init__.py | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Thanks, applied (with Eric Blake's improvement) to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaXLaWAAoJEJykq7OBq3PIJWgH/R+c3Wfvs8n7VzOtVLUARPBs
UhCzIrbCSH5KihJtXxYIL53COFNydEsfAfuFKeSBR70wmepswCgmr2Y8ouaHvR3p
aG9D9vgCcsIsyyrr0id1abRSxYdSfeQ4fGMbDmsSy/skyMIngGla5yyPVgFI+u5b
8ZOnYx7s49c4e8VdNHEdaYDYjJzv2ddECPiHjYOGXUOEbNaKyIjr5GmBWzSdl0I0
e/ZcPr1oIeElKg2eogtyaWIsoyhbp+yP+rmKoN/LIEVckw1OfY2l0x6TCkMGVaiq
UzXSPVTohfeK6sE4Ssgs4xcOFlVUERAk7qTsZ75aRXPcjEgh7nVsd47eNPBno1o=
=rphm
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
