Received: from eggs.gnu.org ([2001:4830:134:3::10]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elHvX-0007iI-LW
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elHvW-0001J0-TA
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:30:03 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-22-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <afb79e4f-8f41-61f9-5182-94ec5e4e738a@redhat.com>
Date: Mon, 12 Feb 2018 18:29:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-22-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mHPwzJPc63y6I8Rq1JvMqM0ba4UikaLLK"
Subject: Re: [Qemu-devel] [PATCH 21/27] ssh: QAPIfy host-key-check option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mHPwzJPc63y6I8Rq1JvMqM0ba4UikaLLK
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <afb79e4f-8f41-61f9-5182-94ec5e4e738a@redhat.com>
Subject: Re: [PATCH 21/27] ssh: QAPIfy host-key-check option
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-22-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-22-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This makes the host-key-check option available in blockdev-add.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 63 +++++++++++++++++++++++++++++++++++--
>  block/ssh.c          | 88 +++++++++++++++++++++++++++++++++-----------=
--------
>  2 files changed, 117 insertions(+), 34 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(And it looks like even with the libssh patch only md5 and sha1 are
available.)


--mHPwzJPc63y6I8Rq1JvMqM0ba4UikaLLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBzxESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A000H/1aZhNH5vtS4dr/jvRiaKK3OVKSkFB7c
mo0LEdca8oPoXcZtb5Za6szDKq8ktzAA9VDSRKkkrEqSeX/asmDa47Y92j2jXsv+
dnyjz0VQU7Jgx2gaq/wzjwkXMQogVbPM32s0EeK4XCsm7lTjVaMBTpuLOhAQApLV
OyUfMlmlJM14vjKAHcKfKTaaNryEbZasGuwmd47Zuv7C4BrkUSEQKg53ZYicXpCc
oL2BvDZV+61OSOEuRBWj9gwZa18DC5jt0WkiHdxJI7jtjPu/2pjy8SP5ipeyiCOP
7upDWBhYwKejKPVMHCeg8FQvrb9B4aKmRVv4C8pq7JyRhf1oKbbb42M=
=j9oE
-----END PGP SIGNATURE-----

--mHPwzJPc63y6I8Rq1JvMqM0ba4UikaLLK--
