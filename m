Received: from eggs.gnu.org ([2001:4830:134:3::10]:39309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCqAZ-0002b0-IL
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCqAZ-0000TH-0O
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:11 -0500
Date: Thu, 9 Nov 2017 16:59:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109165901.GC25162@stefanha-x1.localdomain>
References: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: all I/O should be
 completed before removing throttle timers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhengui Li <lizhengui@huawei.com>
Cc: kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lina.lulina@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com, sochin.jiang@huawei.com


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2017 at 01:34:00PM +0800, Zhengui Li wrote:
> From: Zhengui <lizhengui@huawei.com>
>=20
> In blk_remove_bs, all I/O should be completed before removing throttle
> timers. If there has inflight I/O, removing throttle timers here will
> cause the inflight I/O never return.
> This patch add bdrv_drained_begin before throttle_timers_detach_aio_conte=
xt
> to let all I/O completed before removing throttle timers.
>=20
> Signed-off-by: Zhengui <lizhengui@huawei.com>
> ---
>  block/block-backend.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBIlVAAoJEJykq7OBq3PIRsoH/jCVcXX6yBPBNZ3/Az9odEjB
gz5D693h0GYg4dK2LCOv5PYffdwi4bzwjzCJLLVPjs82Hn/e8QyNyuy5Y1JWvGm9
r6omGTDbDKaxpS+QYZSAfSw9cwRsZ3q+0F+1N2P6qQofYc3HVjs4w85DDPQBopZX
n3VUJ+/u433N0HofO9VbCsPbSVebDni0auD/hbiqI9IPub8lvb4jlWJ6Rg+N/nBS
488vfWF/pW7FvwQ8uzeTdRVaboQu4uT7HDKj/6HFmBrqIg3E1XNV/0O40cz45C9h
e3bwz4DXf6sA7fmyCIcGnK1qYToP+EOmeuvjFenNvLGReWdh7Ifm6ug/4vogsLQ=
=PjR3
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
