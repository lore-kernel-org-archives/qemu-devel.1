Received: from eggs.gnu.org ([2001:4830:134:3::10]:51273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhyL-0004N3-7N
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhyH-0001RJ-Og
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:55:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKhyH-0001Ju-96
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:55:33 -0500
Date: Thu, 8 Nov 2018 10:55:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181108105508.GH17083@stefanha-x1.localdomain>
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-3-stefanha@redhat.com>
	<510dfe45-427f-6ae1-d546-a035776a4c2e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <510dfe45-427f-6ae1-d546-a035776a4c2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/8] get_maintainer: use 'https://'
 instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, cohuck@redhat.com, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 11:37:21PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 4/11/18 12:24, Stefan Hajnoczi wrote:
> > When you clone the repository without previous commit history, 'git://'
> > doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> > since the client verifies the server certificate.
> >=20
> > Reported-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   scripts/get_maintainer.pl | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > index 43fb5f512f..fc7275b9e2 100755
> > --- a/scripts/get_maintainer.pl
> > +++ b/scripts/get_maintainer.pl
> > @@ -1376,7 +1376,7 @@ sub vcs_exists {
> >   	warn("$P: No supported VCS found.  Add --nogit to options?\n");
> >   	warn("Using a git repository produces better results.\n");
> >   	warn("Try latest git repository using:\n");
> > -	warn("git clone git://git.qemu.org/qemu.git\n");
> > +	warn("git clone https//git.qemu.org/git/qemu.git\n");
>=20
> You missed the ':' in the scheme. Once fixed:

Gah!  Thank you!

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> >   	$printed_novcs =3D 1;
> >       }
> >       return 0;
> >=20

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5BYMAAoJEJykq7OBq3PIl9kH/1FCWXG+mXDS2geU0Q1k9Nxw
V13M0eu/QRkHw45Y+7iZtzo0pq7zrQH96npW0smaZdZMQY6rTUT4gu6+1VFfprM1
8SEbf2x2w2K2WzdOrmYxaAK5FBvaWkFuHR0DoP6NSc6BnLpOnHCoxq4aRN3OnEfA
Y9cG6vQNWHD3B0qdPQ02OZScH5zge7fUoa/SnWgBAHSvBTuRt5i6U8hsm+gFjFgJ
U8tfgnDfKHHghZxJbbNjbwcxm/UtoLXpQ0VpwwVMbm6XAS2GDA4J+bZQ6KYmzMZy
kYVUHWYPq/lcNAGxkQ0RjFtOeUr9DmEllEd/orZyiywQsTTV2INimveWfBrBYbU=
=McRO
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
