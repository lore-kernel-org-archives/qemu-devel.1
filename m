Received: from eggs.gnu.org ([2001:4830:134:3::10]:50255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqI7o-0007qq-1c
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqI7n-0006se-6C
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:43:24 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-33-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be641b1f-a44b-aa15-fa9e-fd032bf1d802@redhat.com>
Date: Mon, 26 Feb 2018 13:43:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-33-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l9hjRRrEW4DaJEowdLuahlD7XX8vcRfKc"
Subject: Re: [Qemu-devel] [PATCH v3 32/36] ssh: Support .bdrv_co_create
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
--l9hjRRrEW4DaJEowdLuahlD7XX8vcRfKc
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <be641b1f-a44b-aa15-fa9e-fd032bf1d802@redhat.com>
Subject: Re: [PATCH v3 32/36] ssh: Support .bdrv_co_create
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-33-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-33-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to ssh, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 16 ++++++++-
>  block/ssh.c          | 92 +++++++++++++++++++++++++++++---------------=
--------
>  2 files changed, 67 insertions(+), 41 deletions(-)

As written just now in my reply to v2 (clever me), this conflicts with
my patches to add truncation support to ssh -- and since your series
requires protocols to have feature parity when comparing truncation on
creation and truncation on-the-fly, I insolently claim that you should
rebase. O:-)

Max


--l9hjRRrEW4DaJEowdLuahlD7XX8vcRfKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqUAOISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ah4wIAMJT73LL+QTm47ZE27KsZoro1Tb99ME9
7pv0TKlQDcXFjSQDMX6jMXdudTIx4IqS7ozt/4JpXA6lk/rjVZ097RVMVvK00PxB
vHy46Li7Q6hmuJ9+KC7bH4oL3hmufGd298Hs/F586ABwWve05e7mlYiieKPDPNl5
TQLZ28mMVJPcRlW3xLuBODzlNZSMIwoUZvua43DAbtJRFx5wYAruh3XIuUUwERKG
xac40NcH6oSo4m/iBkABSerdL9QTJ7nZhxBatEMpVu8oDA44a6PWPicSd79xQX6p
D/kJMkfbsNGTEtA0n5qo3GKZEXoyX5qfjEjrBh1hGjAjeesi+88o6ts=
=IzHs
-----END PGP SIGNATURE-----

--l9hjRRrEW4DaJEowdLuahlD7XX8vcRfKc--
