Received: from eggs.gnu.org ([2001:4830:134:3::10]:43423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gIYwX-0005NH-As
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gIYhN-0004hg-6A
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gIYhJ-0004dL-0H
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:37:10 -0400
Date: Fri, 2 Nov 2018 12:36:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181102123637.GB6551@stefanha-x1.localdomain>
References: <20181031084309.9227-1-stefanha@redhat.com>
	<20181031084309.9227-4-stefanha@redhat.com>
	<6142c381-af70-e0d6-88e6-a2f82943e4ea@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <6142c381-af70-e0d6-88e6-a2f82943e4ea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: use 'https://' instead of
 'git://' for GitHub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 08:31:09AM -0500, Eric Blake wrote:
> On 10/31/18 3:43 AM, Stefan Hajnoczi wrote:
> > When you clone the repository without previous commit history, 'git://'
> > doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> > since the client verifies the server certificate.
> >=20
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
> >   1 file changed, 37 insertions(+), 37 deletions(-)
>=20
> We should also do the same for maintainers using git://repo.or.cz:

Your wish is my command.  Fixed in v2.

Stefan

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb3ETVAAoJEJykq7OBq3PIOQQH/jF502jlC7DEqis2xDfg8Wbd
LDA/vYAv/OpwYZ8i9NNA7Pg181d3S84aKrpog0NcH1LPrnrSs7TIeuzYnRuXGxyX
1j7GX61XIBJM70GxBTEggb5QO4/kSGI9AM4lavDTOh05zMdg2lRS6fcfdsZ6LZy8
5S058ZtioRLUSA2zf1LFfEC59q58Tt8s0Gk93K6xkZtdsG9/TRmpBXLtTutVSuuj
kbh2IidxWNp9cMVS5Ux69JX7GC+Yz7Hdo0eFeFdxSwJCJdBz41V2J/QaHLz58fws
2q7wEK0zLbMg2VQPdNuhG1O768Vix6GZMS+qJ6ZIC4pVv1+/Rg1hMLK0BcpxN4w=
=1fcH
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
