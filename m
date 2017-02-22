Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWlI-0004WL-DM
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWlH-0002aW-2L
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:15:16 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-10-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5965da82-a702-41d8-10c0-5e7bdff49b85@redhat.com>
Date: Wed, 22 Feb 2017 14:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-10-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hHbUV48S6N0SoWguSuTsEmb584sohx8JR"
Subject: Re: [Qemu-devel] [PATCH 09/54] block: Add bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hHbUV48S6N0SoWguSuTsEmb584sohx8JR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <5965da82-a702-41d8-10c0-5e7bdff49b85@redhat.com>
Subject: Re: [PATCH 09/54] block: Add bdrv_new_open_driver()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-10-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This function allows to create more or less normal BlockDriverStates
> even for BlockDrivers that aren't globally registered (e.g. helper
> filters for block jobs).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 30 +++++++++++++++++++++++++++++-
>  include/block/block.h |  2 ++
>  2 files changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hHbUV48S6N0SoWguSuTsEmb584sohx8JR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitjtkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbWkH/1IkVqy8DJd2xKHHzYisoFiPQ4eKaTFz
E50Go+Mi1A/vXcol9nspp0kgHDZNQD3pMItXrfphb06ePuxXEuv3ge7rqxNWJFjb
AsdgSXPA1ocDT1cK6uGDqG6YdR8QzhUeZB7Ts1u8yUGHSEOa52iEL3BbjDNxwrO5
/DabbOiTFJsOYky0Imi8J/egGeJGh1HtuMeTgIPBJ3zkGpSJguUYr9kOoGoFGRa3
0We6Ps5P+2fvn1IZnIRYFenIrymBz/BoFjDmvTfh6u9iu7TEbVwRw2SrCZy45ac7
dsZd/f1PKpt6cmmYbJQCWeTuMPUJAFB+08OhFg+U3xzc1xlOHtYpMqI=
=WrGF
-----END PGP SIGNATURE-----

--hHbUV48S6N0SoWguSuTsEmb584sohx8JR--
