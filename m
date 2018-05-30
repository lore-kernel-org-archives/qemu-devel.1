Received: from eggs.gnu.org ([2001:4830:134:3::10]:56412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO6zc-0000oq-Be
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO6zZ-0007Xc-9w
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:42:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO6zZ-0007X6-53
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:42:41 -0400
Date: Wed, 30 May 2018 20:17:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530191741.GN14623@stefanha-x1.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-5-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Content-Disposition: inline
In-Reply-To: <20180529193730.9204-5-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] scripts/qemu.py: introduce
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


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:37:29PM -0400, Cleber Rosa wrote:
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

--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDvjVAAoJEJykq7OBq3PImvMH/17wYouOAxQkEEYj5mJGiYRj
7mWLzbDUsZB5QWx4b4VX2b7r9qYK2QXNrugw47eejZ6Hjnkux6nGMSc3RxxC9WaD
Q8gzVB4AYKOcxIonBjNqqoXF4Ux87T59qxklIyIk71179AUCVwreAcL8YVcXeNfO
tcYDWEds/6OWcfbXxaIPbSictE/HMLyLTaOUA7okHIi3CSI9kw+iSkAbtzzru/1p
7EsaCqL10aZ7bD/qA7NmJwICExFIm10KGkboybMyMXItC7Xn3/ycXupGDJIjD7oz
SihwJ3fqgziBJieE0FC2Cg6IqYEuP4Y/uHRW8F48qqpIu5yLAvdpUv78KCgAvpo=
=9BYk
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--
