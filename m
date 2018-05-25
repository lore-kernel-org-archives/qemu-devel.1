Received: from eggs.gnu.org ([2001:4830:134:3::10]:57469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEYA-0003X7-7p
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEY9-0000iC-Cw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:22:38 -0400
Date: Fri, 25 May 2018 16:22:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525152233.GD21895@stefanha-x1.localdomain>
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <20180425183223.580566-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] parallels: Switch to byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:parallels" <qemu-block@nongnu.org>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 01:32:16PM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based calls
> into the block layer from the parallels driver.
>=20
> Ideally, the parallels driver should switch to doing everything
> byte-based, but that's a more invasive change that requires a
> bit more auditing.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/parallels.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbCCo5AAoJEJykq7OBq3PI4fwH/jnh0meaqf2zc3GxM6i5L5IY
Hcbep9IxYFU7wihbGFp/oTGRv3yoDJV2e9efou5tkBeOhIRBeecnol+S3zlX+RyQ
VPazOMAnMFS+gZtTooWw5Idml5AeyGF97e2p0lPAhZGWOlgbExYIl9ATNmUDBEvb
4HuB0xOm8vbAjHhzLIyaFF+gmQL2dhr05Y2BiKK+gaAhPKvRGQNgHloAagy6j5PJ
9AbfARGJi9TdIsdLAFqWY81g+JjUm8XKCDkJEGNwj41ZLKowOFe5hWDkLaAAghbe
huuYf9Ku0WU6bBxhk09FNNliqDI4uyDF0qT3rSCsxeKEp0pgiSGhN2iJ/m8ZQg4=
=FqDQ
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
