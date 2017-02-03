Received: from eggs.gnu.org ([2001:4830:134:3::10]:40714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZm0p-0002bJ-6e
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZm0o-0008TF-CV
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:07:23 -0500
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a022512c-83c6-2059-bee9-dd7dc368d6f6@redhat.com>
Date: Fri, 3 Feb 2017 23:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170203120254.15062-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oHkVdcGj0PIPwgxdjWRn8a0AfrhdD9b5I"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] qemu-img: add support for -o arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oHkVdcGj0PIPwgxdjWRn8a0AfrhdD9b5I
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <a022512c-83c6-2059-bee9-dd7dc368d6f6@redhat.com>
Subject: Re: [PATCH v2 4/6] qemu-img: add support for -o arg to dd command
References: <20170203120254.15062-1-berrange@redhat.com>
 <20170203120254.15062-5-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-5-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 13:02, Daniel P. Berrange wrote:
> The -o arg to the convert command allows specification of format/protoc=
ol
> options for the newly created image. This adds a -o arg to the dd comma=
nd
> to get feature parity.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |  2 +-
>  qemu-img.c       | 32 +++++++++++++++++++++++++++++++-
>  qemu-img.texi    |  6 ++++--
>  3 files changed, 36 insertions(+), 4 deletions(-)

I don't like this patch for the same reasons as for patch 3, but I like
it a bit better. The code introduced here is exactly the same as for
img_convert(), so merging the two would (or "is going to", I hope) be
trivial.

So a pretty weak

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oHkVdcGj0PIPwgxdjWRn8a0AfrhdD9b5I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU/xESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwE4IAKG8s909l/KRtAyUaFdjAiimHFRftJl8
+o1dPsVWpyY5TKVNiEF930q93TWJSwZvPfNgHA09K3jW56ogoGpU+HdRfhWXRfsU
BkHyhMWLt3Pr789CkBolQK4iamqTdMy0ehkmaezl3o8rxnXwx2RkYmPAB0X2lojf
P2YcD3g4QJImkf5urvT79nu+PH95DYJ6j24JuG07Bm1qYmWyi1Zyah+dsC1MLWna
cJztfxjztaZvvC6QN9nZYFKtqLvDrYd23Gv9faC73A2ndCUotF2vqQ9YIgTn1G85
FqEnN/oa0ad2HQcNxKcsdZirgQLpx3WJ6bafCT4yaN3ml+kCy3I1Qz0=
=ObQh
-----END PGP SIGNATURE-----

--oHkVdcGj0PIPwgxdjWRn8a0AfrhdD9b5I--
