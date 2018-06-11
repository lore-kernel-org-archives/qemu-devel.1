Received: from eggs.gnu.org ([2001:4830:134:3::10]:40410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSMxY-0005YE-7D
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSMxX-0003NY-Gp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:34:12 -0400
Date: Mon, 11 Jun 2018 14:33:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180611133356.GB17756@stefanha-x1.localdomain>
References: <20180608122952.2009-1-ehabkost@redhat.com>
	<20180608122952.2009-2-ehabkost@redhat.com>
	<20180608133745.GH7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20180608133745.GH7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] fixup! python: futurize -f
 libfuturize.fixes.fix_print_with_import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 10:37:45AM -0300, Eduardo Habkost wrote:
> On Fri, Jun 08, 2018 at 09:29:43AM -0300, Eduardo Habkost wrote:
> > Change all Python code to use print as a function.
> >=20
> > This is necessary for Python 3 compatibility.
> >=20
> > Done using:
> >=20
> >   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n=
';) | \
> >     sort -u | grep -v README.sh4)
> >   $ futurize -w -f libfuturize.fixes.fix_print_with_import $py
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Acked-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> [...]
> >  tests/docker/docker.py                   | 11 +--
> [...]
>=20
> This patch needs an update:
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/docker/docker.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbHnpEAAoJEJykq7OBq3PIU3UH/iNf3pJfwCPv2BMjraGkLEdh
4YvklxVltoVU/8W/ZlSzYxvzWyu3lb7JjRxU6dd7a+EsYF7o33GIp4fDqrNZLX1I
4BFJt0xrfZCjfuLr8HlnQpK22ySja4zdjI/LF99oOng64o6pmj1tE5Z70DqTLcDv
tWkVE8DIa1vSMIdVge+VesRdsn44qt5dKO/9Q4xuScwmpzZ417h1JOYE/JG3KPzG
sv8OOazov1sQrEJN1wZ/o3AOUabmD2SYn4b5Q82POnaf526XPCisWnYQjxmgQhuf
otAYlxFCMoEFH60r1QrzKsfOndwFrO7Tjhiqd4xV8sC6V7DYfN/n8p2Wa+Q7P/s=
=2Ve4
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
