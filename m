Received: from eggs.gnu.org ([2001:4830:134:3::10]:53224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqIHw-0001cn-JG
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqIHv-0003X8-Ri
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:53:52 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-37-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <347830e9-9742-325d-3fd4-cdbe719ae46a@redhat.com>
Date: Mon, 26 Feb 2018 13:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-37-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KRdxqLRrFfd3EzN1LDrrxGsNPjfOwcTrj"
Subject: Re: [Qemu-devel] [PATCH v2 36/36] qemu-iotests: Test ssh image
 creation over QMP
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
--KRdxqLRrFfd3EzN1LDrrxGsNPjfOwcTrj
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <347830e9-9742-325d-3fd4-cdbe719ae46a@redhat.com>
Subject: Re: [PATCH v2 36/36] qemu-iotests: Test ssh image creation over QMP
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-37-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-37-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:54, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/207     | 261 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/207.out |  75 +++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 337 insertions(+)
>  create mode 100755 tests/qemu-iotests/207
>  create mode 100644 tests/qemu-iotests/207.out

Minor note: If this test tried to create a qcow2 image over ssh, it
would have seen "Image format driver does not support resize" without
the ssh truncation patches.

But I'm not sure whether such a test case should be added here, because
technically this test then becomes a qcow2+ssh test, and nobody is ever
going to run the iotests with the qcow2+ssh combination.

(We could cheat and still mark this test as raw and then just create a
qcow2 image nonetheless...)

Max


--KRdxqLRrFfd3EzN1LDrrxGsNPjfOwcTrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqUA1ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AK5MH/izl1ZcB+FWmwZTLGgjyTHbW0fbisYYG
VUhOSCPqwpycOAsRkwR7Ch8+gOluBv6mBb2QE+km1Gtc0mzHyHb9KZSChoIsexYR
+GCIcR6m2CfpWYZveILFACazwynEk+9O9WnOrTrJYAtInlT0Ai4DZdQ1H1GkwaYb
frKRigjdbQso21zLwVQ/JwguwNzYCPS4iCF88WpsI0B87gqJB0V+YuCX9sYLjlEE
Alt7JFyC1UBtW9mDv5S4y6qcuzr7dvrOTVC2oA18ZNW3mYZkz0nbM3ZksPhMHPSi
T3keb87YQiKkyGH9jOakUlAlmA+k1I1InSVK/e6s7zWM8qxigocAFbM=
=88ie
-----END PGP SIGNATURE-----

--KRdxqLRrFfd3EzN1LDrrxGsNPjfOwcTrj--
