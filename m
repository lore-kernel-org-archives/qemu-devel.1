Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxPU-0002gb-Pu
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxPU-00037w-03
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:53:44 -0400
Date: Mon, 18 Jun 2018 18:53:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180618165334.GF4667@localhost.localdomain>
References: <1528759585-51780-1-git-send-email-wangjie88@huawei.com>
	<20180618155045.GB9785@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20180618155045.GB9785@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] util/async: avoid NULL
 pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jie Wang <wangjie88@huawei.com>, famz@redhat.com, qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wu.wubin@huawei.com


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.06.2018 um 17:50 hat Stefan Hajnoczi geschrieben:
> On Tue, Jun 12, 2018 at 07:26:25AM +0800, Jie Wang wrote:
> > if laio_init create linux_aio failed and return NULL, NULL pointer
> > dereference will occur when laio_attach_aio_context dereference
> > linux_aio in aio_get_linux_aio. Let's avoid it and report error.
> >=20
> > Signed-off-by: Jie Wang <wangjie88@huawei.com>
> > ---
> >  block/file-posix.c | 19 +++++++++++++++++--
> >  util/async.c       |  5 ++++-
> >  2 files changed, 21 insertions(+), 3 deletions(-)
>=20
> If someone wants to split aio_get_linux_aio() into an initialization
> function and a "get" function which doesn't return NULL if init
> succeeded, then we can make this a bit cleaner.  But it doesn't matter
> at the moment since there are few callers and duplicating the NULL check
> isn't too bad.
>=20
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block

Did you see this patch?

[RFC v2] aio: properly bubble up errors from initialization
Message-Id: <20180615174729.20544-1-naravamudan@digitalocean.com>

I didn't review it yet, but it seems to be for the same, or at least a
similar, problem.

Kevin

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbJ+ONAAoJEH8JsnLIjy/WIx4P/3u15+I50Qq/lcDCCVXHXow5
sI+LmGAGjvFl4UGFueWirTC4voWi9/acLYuzB4AQ3eImv38VZLmAX/4mpyiEBOUA
ogrzjDipots6cstUMq3hqOjk42OGxW3tMSHnIyWZ7rEi8/GK4kCk7LSi19qmH3Ru
dm/PqTDsLNOcQXHRUvO9KtcocTTOHfwtEKweFvGDdwm2t5alN+QeuDG0SSgDqsvk
0LVA0hw1tp6s0G2O0kAtV0qSzZ3B7NHVpCpnUEWjk1jEhuDkKu7BV+eyhxjFcuis
CTDDXhzc/mEA1UeKs/jyQ2ypawu4ISe5bkBnuwayTh8lg8drHp5wMEUeAeAgg36h
kC9WBn3DaxanOfk3J9GZ+aTO41Cvznfn8d5oz8zzFSh0jD52zN7PzdW9ezAMMyyA
p4cN1IQTYmHazIrUsTe1Xx2SSlyirgzM1mGQrjsh+1xg3UA+9wR1UW7SsiUNGhaO
D9OpyMbcy0kmOJ8zt9+cd60Itf8bxfxCHPckb/lNPpNe6FhCRcam/vJjoIrTu9sr
LGbpChftmDbjVOzw8iAiBHB7P86y4r7DZN4cmRSuitGSTDqNwfxWk+PaEEDgMi3v
BTkEYy8dh5jHR29eajniZHFU8MwnruC2YZDWYkVZxXJEDdtOhTgLROm5JwgH5qN9
wtfRWCsjyG3U1FhNhbXQ
=6flo
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
