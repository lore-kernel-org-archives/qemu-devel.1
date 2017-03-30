Received: from eggs.gnu.org ([2001:4830:134:3::10]:54979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctiTb-0004SD-HD
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctiTa-0006CS-NS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 18:23:31 -0400
References: <20170330221243.17333-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5aa386fe-c949-239a-946b-77b39e6129d6@redhat.com>
Date: Thu, 30 Mar 2017 17:23:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170330221243.17333-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UtHGStiRcPw2WUI9NJ0gRSP3fSkgDIhUd"
Subject: Re: [Qemu-devel] [PATCH for-2.9] iotests: Fix test 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UtHGStiRcPw2WUI9NJ0gRSP3fSkgDIhUd
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5aa386fe-c949-239a-946b-77b39e6129d6@redhat.com>
Subject: Re: [PATCH for-2.9] iotests: Fix test 147
References: <20170330221243.17333-1-mreitz@redhat.com>
In-Reply-To: <20170330221243.17333-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 05:12 PM, Max Reitz wrote:
> This test has been broken by changing NBD's blockdev-add interface (fro=
m
> taking a SocketAddress to taking a SocketAddressFlat). This patch makes=

> it work again.
>=20
> Unfortunately, we cannot just flatten all of the addresses because
> nbd-server-start still takes a plain SocketAddress. Therefore, we need
> both and this is most easily achieved by writing the SocketAddress into=

> the code and flattening it where necessary.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I can be convinced to squash this into Markus' patch "nbd: Tidy up
> blockdev-add interface" which is the reason this test broke. I
> personally don't have a strong opinion on the matter other than "We
> won't get Markus to send a v4".
> ---
>  tests/qemu-iotests/147 | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Squashing is fine by me.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UtHGStiRcPw2WUI9NJ0gRSP3fSkgDIhUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3YVaAAoJEKeha0olJ0NqwQ4H/3c1AU81sSoftGyC6e084YhL
SvcrbuRFJhykirYoOd8Ycs9gd1qh0qTx8wvuEPWLQXY3ILnPILAVyzVNQGvWkb1B
/qiPRoqyIvtlzImkJF3xWAmpDyAPIYx3bo9OGw6XkEt2octEKbY1QKS6a5D4WwTT
mYSPOJYwiXyhCGB5DvBBdLi1r8tm9dH8aXwQW8kQyOZZT5OASKA5ggaf7sX8jDFr
V4DKVEqHn99DPB8a1o5Ye8/7PxBdeja9+A5tFlqUi66U3q+wigLVqFijZdr7LF/D
OeP11+mMCvhH/+MMd4kSK8I6Ni8yop4M89hTp7BJl/nezkuI0PCx5TPG7TTUY/w=
=Hi7R
-----END PGP SIGNATURE-----

--UtHGStiRcPw2WUI9NJ0gRSP3fSkgDIhUd--
