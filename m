Received: from eggs.gnu.org ([2001:4830:134:3::10]:36066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tRf-00074g-S3
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tRc-0007xM-MV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:08:15 -0400
Date: Thu, 11 May 2017 15:08:08 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511190808.GA24584@stefanha-x1.localdomain>
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 2/6] replication: add
 shared-disk and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 10:05:17PM +0800, zhanghailiang wrote:
> We use these two options to identify which disk is
> shared
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
> v4:
> - Add proper comment for primary_disk (Stefan)
> v2:
> - Move g_free(s->shared_disk_id) to the common fail process place (Stefan)
> - Fix comments for these two options
> ---
>  block/replication.c  | 43 +++++++++++++++++++++++++++++++++++++++++--
>  qapi/block-core.json | 10 +++++++++-
>  2 files changed, 50 insertions(+), 3 deletions(-)

Aside from the ongoing discussion about this patch...

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLaYAAoJEJykq7OBq3PISXwIAJ019b/65mBV0Vqj5hkBF5yE
P4FKOXGsDQhJzhXvtJ489lJ8x5jgTdHouuqpTQ/GgpWVgJ8WIw+/aAjOR3SJMaBS
IXO4hnOypGGYECs7vDSrKscUrUBiWzfiofx9F8BqNfw0i2yiGbeWRyHo45/Snpho
AtPcCUBXIuXCaifXsmKpr69NiJWuyZmDLatgMiPVUueqXyXURT64n4qGUO9cOeBt
2PMFfZ5RnJBNxRQStvQepp4t5rali9ahzuEDh5LOpM2uZBhKiy/9b9OuXff7BTdB
+c6g1d5rsLDXcmh2l+X2vM2psKke/EhlTfbWKWsI5uLCZOnCWKaNWvuk+Wadxek=
=eEu8
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
