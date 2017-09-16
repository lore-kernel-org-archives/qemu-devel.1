Received: from eggs.gnu.org ([2001:4830:134:3::10]:48104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFua-0003Ho-25
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFuZ-0006CH-BK
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:44 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-3-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <685c90b5-458b-bee5-b543-f748d114873c@redhat.com>
Date: Sat, 16 Sep 2017 18:25:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m1t5GjRdiBKdmUl8Q380SUW4FkvIII6wX"
Subject: Re: [Qemu-devel] [PATCH v3 2/7] crypto: expose encryption sector
 size in APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m1t5GjRdiBKdmUl8Q380SUW4FkvIII6wX
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <685c90b5-458b-bee5-b543-f748d114873c@redhat.com>
Subject: Re: [PATCH v3 2/7] crypto: expose encryption sector size in APIs
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-3-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> While current encryption schemes all have a fixed sector size of
> 512 bytes, this is not guaranteed to be the case in future. Expose
> the sector size in the APIs so the block layer can remove assumptions
> about fixed 512 byte sectors.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  crypto/block-luks.c    |  6 ++++--
>  crypto/block-qcow.c    |  1 +
>  crypto/block.c         |  6 ++++++
>  crypto/blockpriv.h     |  1 +
>  include/crypto/block.h | 15 +++++++++++++++
>  5 files changed, 27 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--m1t5GjRdiBKdmUl8Q380SUW4FkvIII6wX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9UHwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdhQH/2rFiHKD2Rsfp3G16dgNWGz5sVmUGFp5
2oTOzAV69teAVwXZlUQSvP31RvEqadx2SgRLdoE2tgZu8Hu1wmKdxanzHsax/4uG
2C+f7I5lOVDmz+JgjNOY+As+JzEFfNp8iDTUY0A0WstAmmmj2rV1CM4adU7fgLoC
3ISbdPPZII9yChmDJ9n/Kr3GXC6HLYlK61MlCsiVVM6wUJ1bkJFOILraH4A5CGh4
Af9p53gJGckAo7d/sy0zP039s19ibQZWtwuMI09Ghir+u6A/FoNxfHlk0wFGhL1e
G18h7UlT/m/9E+5ZF8IIN8tOQIlOn49E1xuzb1/QLDt6Ko97LIv6YvI=
=IWLS
-----END PGP SIGNATURE-----

--m1t5GjRdiBKdmUl8Q380SUW4FkvIII6wX--
