Received: from eggs.gnu.org ([2001:4830:134:3::10]:37063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1estZT-0005M7-3k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1estZS-0000uR-6w
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:06:43 -0500
References: <20180301011413.11531-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3cb74455-3dc2-1f29-7162-019d5a9f86e2@redhat.com>
Date: Mon, 5 Mar 2018 18:06:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180301011413.11531-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XXrTCxFINAaXKZcmWNMR5fFW6d58MZLBZ"
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip test for ENOMEM error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XXrTCxFINAaXKZcmWNMR5fFW6d58MZLBZ
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com
Message-ID: <3cb74455-3dc2-1f29-7162-019d5a9f86e2@redhat.com>
Subject: Re: [PATCH] iotests: Skip test for ENOMEM error
References: <20180301011413.11531-1-famz@redhat.com>
In-Reply-To: <20180301011413.11531-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-01 02:14, Fam Zheng wrote:
> The AFL image is to exercise the code validating image size, which
> doesn't work on 32 bit or when out of memory (there is a large
> allocation before the interesting point). So check that and skip the
> test, instead of faking the result.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/059 | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks!  Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--XXrTCxFINAaXKZcmWNMR5fFW6d58MZLBZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqdeRASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMSoH/2p9YINHUS+t7oK5EQQ7lDnXlPTHIqMS
t/yJxOzch63wBs40fPmBetybRD1aX0nbZfG444F2LVPkwT1aW/IYc0UCKNxrSMhZ
pyRFcTDGB/r9gqJhTlEN5jjrhBY6pUdYwtx2LiEPVe/qM9ZxwudtXCSt3yDNBW8K
xhkW+nFDK4z8e6OIr1Kk0znFkzJEnGur5e4jD6epSi96YQkxmSssSdLEqb2Oozjb
vRTmHhyqz2sAEvAEYQ6b2JH4fWClJPUo3aczGDnuVLlH4l+Bu5G5uFOMNkqCC8R+
PFIcist7tNGG2dfDltyT0XeSQx7vz1pdDLq/AU5LNVU+Wv747Lmx7f4=
=t7A2
-----END PGP SIGNATURE-----

--XXrTCxFINAaXKZcmWNMR5fFW6d58MZLBZ--
