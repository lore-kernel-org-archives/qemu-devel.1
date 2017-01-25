Received: from eggs.gnu.org ([2001:4830:134:3::10]:35008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOAq-0001Dy-I1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOAn-0002it-EH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:03:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWOAn-0002ij-8M
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:03:41 -0500
Date: Wed, 25 Jan 2017 14:03:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125140338.GM10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-6-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/8] trace: move setting of group name
 into Makefiles
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


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:48AM +0000, Daniel P. Berrange wrote:
> Having tracetool.py figure out the right group name from just
> the input filename is not practical when considering the
> different build vs src path combinations. Instead simply take
> the group name as a command line arg from the Makefile, which
> can trivially provide the right name.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.target      |  3 +++
>  scripts/tracetool.py | 23 +++++++++--------------
>  trace/Makefile.objs  |  9 +++++++++
>  3 files changed, 21 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pP0ycGQONqsnqIMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiLA5AAoJEJykq7OBq3PI2e8H/0gFXZcSraHzXIhJrjLW2Tlj
dsLxL5Z62jgBsPqfOL0V77fh1HnFOSqKc2+vZ4vO2h+/9xHW3fcGazpb9HT3BUQm
52pPun/BO3bm9qqPtp81t23CL4NHvIuR0mm/BhLV0dfXnKQ345pAq8FJsL73Fi8u
RwS25WWl29+ZAaKhjcCrvR9nRfpmKus1X/C1oErxsNegg/wZ+9VJt7E+8MsSqKEx
cH60HloltDCf3tMiF/9ZvK40X0Dq+jqb29NIYqJ74hw/k5T6WAhLSnRD9l34hof2
3FFEzSm1JY229JzzFYP2rHxMT7Cz8PmjVaY0EuwHM67WONcpLxaJetZ6VvW1/XQ=
=d5tW
-----END PGP SIGNATURE-----

--pP0ycGQONqsnqIMP--
