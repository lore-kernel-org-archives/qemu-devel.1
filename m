Received: from eggs.gnu.org ([2001:4830:134:3::10]:36944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDWG-0000cI-FF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDWF-0002ws-Lv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:04:44 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-8-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3f1e931-cecf-71b2-db82-f43c51361599@redhat.com>
Date: Mon, 16 Jan 2017 21:04:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FCU90s5XdWTTp006GdTkBRTvHmHicRdLx"
Subject: Re: [Qemu-devel] [PATCH v1 07/15] iotests: fix 097 when run with
 qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FCU90s5XdWTTp006GdTkBRTvHmHicRdLx
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <d3f1e931-cecf-71b2-db82-f43c51361599@redhat.com>
Subject: Re: [PATCH v1 07/15] iotests: fix 097 when run with qcow
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-8-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-8-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> The previous commit:
>=20
>   commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
>   Author: Eric Blake <eblake@redhat.com>
>   Date:   Mon Dec 5 09:49:34 2016 -0600
>=20
>     qcow2: Don't strand clusters near 2G intervals during commit
>=20
> extended the 097 test case so that it did two passes, once
> with an internal snapshot, once without.
>=20
> qcow (v1) does not support internal snapshots, so this change
> broke test 097 when run against qcow.
>=20
> This splits 097 in two, creating a new 173 that tests the
> internal snapshot codepath, effectively putting 097 back
> to its content before the above commit.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/097     |  10 +---
>  tests/qemu-iotests/097.out | 125 ++-----------------------------------=
-------
>  tests/qemu-iotests/173     | 126 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/173.out | 119 +++++++++++++++++++++++++++++++++++++=
+++++
>  tests/qemu-iotests/group   |   1 +
>  5 files changed, 251 insertions(+), 130 deletions(-)
>  create mode 100755 tests/qemu-iotests/173
>  create mode 100644 tests/qemu-iotests/173.out

I don't think the effort is worth it, considering that probably
literally nobody is still using qcow -- or so I hope, at least.

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--FCU90s5XdWTTp006GdTkBRTvHmHicRdLx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9J1ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdMIIAI1lnD3EPTaO9pysKMlG+T8S4vXJHjG0
aWgLmiaVv/LztRwM/gAjt5co0Yz8WdAKhlstmd9xy87d2CQKfuf/siUBtDgIBXKv
g4SWc8+mcDMXfHkzZKulmREV6XrGzQIHnSwKRyPHSFCbDPQwig3DJVQ9OSCjO0lo
7n5Wi58WUBNCLmvtad70ULVViNe/wlfVaTlbNGCsHFMiKRy7L6LkskV16WITzDC+
QTmacQurENKBm4M6qKQzf8MRJ4gAVLHeFhyZiR2KDC+KDBphugtmnRTaqKbjiwAe
4mYvLUZKwWeQlGs9ocFWbTtREKnIzawVJDEnHuDhWx5xi4YDot1/0dU=
=nRNo
-----END PGP SIGNATURE-----

--FCU90s5XdWTTp006GdTkBRTvHmHicRdLx--
