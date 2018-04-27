Received: from eggs.gnu.org ([2001:4830:134:3::10]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC2Oq-0001Zb-UI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC2Op-0002ac-VH
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:52 -0400
Date: Fri, 27 Apr 2018 11:26:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427102651.GF6999@stefanha-x1.localdomain>
References: <20180424085240.5798-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <20180424085240.5798-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockjob: drop block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 09:52:40AM +0100, Stefan Hajnoczi wrote:
> Commit 8119334918e86f45877cfc139192d54f2449a239 ("block: Don't
> block_job_pause_all() in bdrv_drain_all()") removed the only callers of
> block_job_pause/resume_all().
>=20
> Pausing and resuming now happens in child_job_drained_begin/end() so
> it's no longer necessary to globally pause/resume jobs.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/blockjob_int.h | 14 --------------
>  blockjob.c                   | 27 ---------------------------
>  2 files changed, 41 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4vrrAAoJEJykq7OBq3PIzgsH/Rveu2KzgpQXzI+Y0NYHT4r/
SEB6lRYmoATQjSsQoaYHJtPEEH01+Ae0ySC+rKWOFq4V2h0ApU6UKPKgKyJ5TSxg
2txlPqlscd35LVPACeYFVpmfw5pTOiRhVrsMq4OVJkkhHcnclREsAzI4sugoDhgI
qiJ0qnkmdDR+p1TdUzEDBWM7als4QtT/HoWJp7s8D3ynwmebeDnzg18L1woF1XyQ
7vAdplAZlV+jSvWfsth5cYWt0/IY3jEmA8ga+ggyRuD9JL8M48yfxHRLC93eP6LT
hwWE+7Ys8JeWBAAoHgUiQlDiKJqM4e78dEA0csR52YgbIM2t4mmLWD8WIOu839k=
=/ToY
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
