Received: from eggs.gnu.org ([2001:4830:134:3::10]:52246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDBJe-0001bT-VN
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDBJZ-0000Vc-Eu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:33:58 -0500
Date: Fri, 10 Nov 2017 15:33:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171110153345.GB17290@stefanha-x1.localdomain>
References: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
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


--VrqPEDrXMn8OVzN4
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

Hi Zhengui,
Sorry it took so long to get thism merged!

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

I moved the declaration of bs as suggested by Berto when I merged the
patch.

Stefan

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBcbZAAoJEJykq7OBq3PIMZ4H/29sKiaVBgqrTs+QxIMKH3bg
iJjErL666LwnZNlK+iVJhzy0QcO57RHIWwhqfmQMqmam6giaXGgfzQ84gMUg9Y1R
ipAT5ZUwkY98pnIHJEJqtMIiqbBhS8a4IgAiVPU5N0fMRNdbv4pwaDgM5t2dK7u2
SVWLJBdWI8rsGVSGQeR8wdr1TrOpQ8HNo2ZF6yRPxHDMZXxAuuBAn/nGAb7qWKMm
dh1jxj7prllGSwwpKhmfqedYewt/0Q1cUzuT8245wIh7HZO4Zgwfp5JL99b2/wGZ
9Mm8o52WVvGB1H1d7L2FPTfW0FqU44Wy16+2GpjxDDu5VWTho0soxAPRIujK+PA=
=YTme
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
