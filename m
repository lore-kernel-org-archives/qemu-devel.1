Received: from eggs.gnu.org ([2001:4830:134:3::10]:48157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFul-0003Rt-DZ
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtFuk-0006G8-Jo
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:25:55 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bfe16d45-a399-d7c3-a995-7c6d1203ab88@redhat.com>
Date: Sat, 16 Sep 2017 18:25:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hb7FVAnKIpPdKGH0XJQUCplslx6o4fD9B"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block: fix data type casting for
 crypto payload offset
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
--hb7FVAnKIpPdKGH0XJQUCplslx6o4fD9B
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <bfe16d45-a399-d7c3-a995-7c6d1203ab88@redhat.com>
Subject: Re: [PATCH v3 3/7] block: fix data type casting for crypto payload
 offset
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-4-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> The crypto APIs report the offset of the data payload as an uint64_t
> type, but the block driver is casting to size_t or ssize_t which will
> potentially truncate.
>=20
> Most of the block APIs use int64_t for offsets meanwhile, so even if
> using uint64_t in the crypto block driver we are still at risk of
> truncation.
>=20
> Change the block crypto driver to use uint64_t, but add asserts that
> the value is less than INT64_MAX.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hb7FVAnKIpPdKGH0XJQUCplslx6o4fD9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9UIkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoroIAL/p0IG6t25nL74E/nQti5SuoOUY1PS4
/DmPlPYfqAqDTPu//XTLz42lINjzOKbeVXop/sp6f7KnH8vGyxeswj9nITkawsWe
OL1laGEGxki+t+byNvVsW1hrri8Gqw4h1N4uPV2rfGb77ntju4vILpNjhaHZOsCt
bK4pAqqSzuLnaFEJMpwIfuH4qNgs81qpUIVo5+8BHSjO4zmu4z4jzJa/zxG4ia8J
pRUuhY9CzszLsZmxcVMQTnGuXrgK7GWk4DydFnruGIxkf/QQFzJ7k6NQs0dPWJua
PQvnXYOQQ4PcfbAeTHBMvm64bZR7Gk4p0MXCLnRls4qo2HCs4zmv84c=
=FVhH
-----END PGP SIGNATURE-----

--hb7FVAnKIpPdKGH0XJQUCplslx6o4fD9B--
