Received: from eggs.gnu.org ([2001:4830:134:3::10]:55635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRgpF-0006c8-Uc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRgpD-0000Ak-5J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRgpC-0000AS-V3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:02:31 -0500
Date: Wed, 20 Dec 2017 16:02:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220160228.GD12566@stefanha-x1.localdomain>
References: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com, zhaoshenglong@huawei.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 09:16:46PM +0800, Yang Zhong wrote:
> Since there are some issues in memory alloc/free machenism
> in glibc for little chunk memory, if Qemu frequently
> alloc/free little chunk memory, the glibc doesn't alloc
> little chunk memory from free list of glibc and still
> allocate from OS, which make the heap size bigger and bigger.
>=20
> This patch introduce malloc_trim(), which will free heap
> memory when there is no rcu call during rcu thread loop.
> malloc_trim() can be enabled/disabled by --enable-malloc-trim/
> --disable-malloc-trim in the Qemu configure command. The
> default malloc_trim() is enabled for libc.
>=20
> Below are test results from smaps file.
> (1)without patch
> 55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
> Size:              21796 kB
> Rss:               14260 kB
> Pss:               14260 kB
>=20
> (2)with patch
> 55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
> Size:              21668 kB
> Rss:                6940 kB
> Pss:                6940 kB
>=20
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  configure  | 35 +++++++++++++++++++++++++++++++++++
>  util/rcu.c |  6 ++++++
>  2 files changed, 41 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOomUAAoJEJykq7OBq3PI3+kH/jn9UBjqagso5hSUEXs41akm
yN7XeTgfR1Z5D5T+XWlZwM37ZR4+sjkpGGhF+gVes4H5RRB15eG8hWRgiAp/Il4E
slxXGYrFViMQheJeoJDH2qSVFBxq+/mKbeg1KL9Ueh+loUxD7PVhU1EvuVt9Rwba
zK0/SZSihkKLHep3mdfrHl99wRXSokYoGfW0tTBP3pvvO7hRUT5w2IEt1Y1LyhY3
gtHVvTc65hSjh1nNNPLFrBOy+/uGTQaZiqhsVFfQG0gSVRPx77MgtOBup9+2T7C4
WKY3Vs0s1j+wvvmQkk9nhJE525W22+lEdSL6FGho9zz8LBPujn4iaotpDCyrZ20=
=2gTv
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
