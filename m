Received: from eggs.gnu.org ([2001:4830:134:3::10]:46157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWVn-0001xJ-Vl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWVn-0006XH-CR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:59:16 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-9-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <926ebefe-10f6-4c13-153e-0f2e118aea3a@redhat.com>
Date: Wed, 22 Feb 2017 13:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-9-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JUva2wtOKfjLpFdIMErsCh9WXqqd0Kqcc"
Subject: Re: [Qemu-devel] [PATCH 08/54] block: Factor out bdrv_open_driver()
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
--JUva2wtOKfjLpFdIMErsCh9WXqqd0Kqcc
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <926ebefe-10f6-4c13-153e-0f2e118aea3a@redhat.com>
Subject: Re: [PATCH 08/54] block: Factor out bdrv_open_driver()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-9-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This is a function that doesn't do any option parsing, but just does
> some basic BlockDriverState setup and calls the .bdrv_open() function o=
f
> the block driver.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 112 +++++++++++++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 65 insertions(+), 47 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--JUva2wtOKfjLpFdIMErsCh9WXqqd0Kqcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitixoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7t8H/16kj4xLGv06Um004mAi7f6xKunCMb+w
g4Y/rdHmUTwoGslyBg8oiqOoVLzuEb1IeDTJavWQ8xh2+UB6ucqj6BCv781/VriK
5XT1pJMqKDvxJvisAcNkAmDjFJpcKXzDfO1oQo1xIKakCyrUW6VlUC72f7SVy3Mj
oqWzvyukEF2TmWAygd/Abw5Ft9BQth85MgzRTZjWMv1+w2rFMhZyJN4h2iHKHJRo
v+saKkiENkldqCWiSrpDTGdxxGQ9BP2evGwS6Px74Rz8U3XxJs3T9CKQI6F6vV2a
+GTBReEV2a16NGGtT05KkAKyafDVZorC+9gnxsQrAhY1wPs/L0CF01g=
=Cf9o
-----END PGP SIGNATURE-----

--JUva2wtOKfjLpFdIMErsCh9WXqqd0Kqcc--
