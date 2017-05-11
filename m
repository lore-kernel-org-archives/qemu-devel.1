Received: from eggs.gnu.org ([2001:4830:134:3::10]:37248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8taG-00015E-F5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8taD-0006BZ-9U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:17:08 -0400
Date: Thu, 11 May 2017 15:17:01 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511191701.GC24584@stefanha-x1.localdomain>
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/6] COLO block replication
 supports shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, qemu-block@nongnu.org, zhangchen.fnst@cn.fujitsu.com, eddie.dong@intel.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 10:05:15PM +0800, zhanghailiang wrote:
> COLO block replication doesn't support the shared disk case,
> Here we try to implement it and this is the 4th version.
>=20
> Please review and any commits are welcomed.
>=20
> Cc: Dr. David Alan Gilbert (git) <dgilbert@redhat.com>
> Cc: eddie.dong@intel.com

Sorry for the delay.  Feel free to ping me if I don't review within a
few days when you post a patch.

> v4:
> - Add proper comment for primary_disk in patch 2 (Stefan)
> - Call bdrv_invalidate_cache() while do checkpoint for shared disk in pat=
ch 5
>=20
> v3:
> - Fix some comments from Stefan and Eric
>=20
> v2:
> - Drop the patch which add a blk_root() helper
> - Fix some comments from Changlong
>=20
> zhanghailiang (6):
>   docs/block-replication: Add description for shared-disk case
>   replication: add shared-disk and shared-disk-id options
>   replication: Split out backup_do_checkpoint() from
>     secondary_do_checkpoint()
>   replication: fix code logic with the new shared_disk option
>   replication: Implement block replication for shared disk case
>   nbd/replication: implement .bdrv_get_info() for nbd and replication
>     driver
>=20
>  block/nbd.c                |  12 +++
>  block/replication.c        | 198 ++++++++++++++++++++++++++++++++++-----=
------
>  docs/block-replication.txt | 139 ++++++++++++++++++++++++++++++-
>  qapi/block-core.json       |  10 ++-
>  4 files changed, 306 insertions(+), 53 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20
>=20
>=20

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLitAAoJEJykq7OBq3PI4KEH+wRIfUv3Ok/KCpmudQQVjtFE
YO6KXnZneeXUIZUXGZKK8Ygie4REG72xteC+KzKq9Eo9rWj7QgkLCLQM6x+L0Q6k
x9/Kx5aD5x08tZRGopqNNVu4eCu3kZGwT1L1f6h6F7o7J8saVRipYe6jONVG6J7C
KS6fumCOT7EAbfokoOYITgJ6JHLvFovMbDE+7a7gzwDWj2uYHOFNi9pvFYIoWqA/
d4RVMfAVumDkr5nrbkmZqffNL7ntA6qv0mRNOn+4A1pioKzGJbETLer4ggCnKVvV
TtqZg7QMuDT9DPFfH1XToZd2Tjq7Y0qxqhdOeIExXpeYMMwJh3hTnh4OX1ViYJo=
=fVof
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
