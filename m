Received: from eggs.gnu.org ([2001:4830:134:3::10]:42845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOLFU-0005XU-RW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOLFQ-0002s8-V6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:56:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOLFQ-0002rq-Ps
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:56:00 -0400
Date: Thu, 31 May 2018 11:55:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531105558.GE27838@stefanha-x1.localdomain>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-5-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
In-Reply-To: <20180530184156.15634-5-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] scripts/qemu.py: introduce
 set_console() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 02:41:55PM -0400, Cleber Rosa wrote:
> The set_console() method is intended to ease higher level use cases
> that require a console device.
>=20
> The amount of intelligence is limited on purpose, requiring either the
> device type explicitly, or the existence of a machine (pattern)
> definition.
>=20
> Because of the console device type selection criteria (by machine
> type), users should also be able to define that.  It'll then be used
> for both '-machine' and for the console device type selection.
>=20
> Users of the set_console() method will certainly be interested in
> accessing the console device, and for that a console_socket property
> has been added.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qemu.py | 97 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD9S+AAoJEJykq7OBq3PIQ/MH/R0v4Da46LTcgbUWQeeXt57o
9kU8rAFTazaPP5zTiPHA1P4RUhwuEmqCzhBdB3U6KH2yejoMdqcPJWHTmPsC66DL
o3Aa44ncbtuItK9MbxJD+Tw6tPalP3BgbZeDjx0Er7jl8VROAGzi3RIwd2makAuG
nB1aMVtNGVKiHrBKonwYEX6h1SoDueyn4AJ+WkwO7W83Ga5+uPqDjDDJOgTekxJx
TAGXobQlpWDLwqXl4lL3fH6BWMZ6cPptcyul4fUfHWtIaMT1+FU8FW/f/sb+OjNj
SPt/+QGzgQ+iGwLbnz0BAh5oqsWgekNyNrKD9+y/kBlKmYlEXcQ/hVR9XsHgSXc=
=Nvx9
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
