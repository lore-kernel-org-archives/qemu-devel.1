Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dKkj4-0007rX-Mx
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dKkiy-0005el-RC
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:15:14 -0400
Date: Tue, 13 Jun 2017 14:14:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170613121455.GF4383@noname.redhat.com>
References: <20170522135704.842-1-stefanha@redhat.com>
	<20170612134733.GA17075@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20170612134733.GA17075@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/4] block: fix 'savevm'
 hang with -object iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.06.2017 um 15:47 hat Stefan Hajnoczi geschrieben:
> On Mon, May 22, 2017 at 02:57:00PM +0100, Stefan Hajnoczi wrote:
> > v3:
> >  * Add missing bdrv_drain_all_end() in error code paths [Kevin]
> > v2:
> >  * New patch to use bdrv_drain_all_begin/end() in savevm/loadvm [Kevin]
> >    (All other patches unchanged)
> >=20
> > The 'savevm' command hangs when -object iothread is used.  See patches =
for
> > details, but basically the vmstate read/write code didn't conform to th=
e latest
> > block layer locking rules.
> >=20
> > Stefan Hajnoczi (4):
> >   block: count bdrv_co_rw_vmstate() requests
> >   block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
> >   migration: avoid recursive AioContext locking in save_vmstate()
> >   migration: use bdrv_drain_all_begin/end() instead bdrv_drain_all()
> >=20
> >  block/io.c         | 21 +++++++++++++--------
> >  migration/savevm.c | 30 ++++++++++++++++++++++++++----
> >  2 files changed, 39 insertions(+), 12 deletions(-)
>=20
> Ping ^ 2

Thanks, applied to the block branch.

Kevin

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZP9c/AAoJEH8JsnLIjy/W3vwP/RhlorsZvMMWMEwp910+Thhw
EU2JJ5EnDENcSLHILY/Lxok22qfi6SiVdlLqbINUiD4H+X+IZ0/EsU1J5n//nukm
QdxDa7KOXKGCScmdU+ll/JLi7VT4GkzHK/BUYRY72PBcYiqwxzeeK4ewekKRUgrP
R8NLEOWaQ7m5W/h0BgqiGivfuq/GTG+E+xuFytYhsi7mbzIqNeYBsO3njUCw4HcN
3OtTbhheJwnDOrm6AtBRy8IR8DtGAdntox7EoBIp0AQwezj8NxhOGhQrpHwqaKm/
I3gBIrm/adZSWdzoSga1dgQ0ebA2RiVvX6Ia2X/fma3SGr10uoB+If7+gxKP7KfB
Cz4jUHtt1Sd6mgM4vzPc91NZaJydNE9+aTyvCmAm2e9y7efoyv+3ywZOVk1RTBmg
JE6RqvF4U4FbtIH/69ddTJxb+ix0FHj1WPl/pKwoIYi0VQox6mj8JrsIoHqGM1uY
NrNvzzv08l6fkA1Hi51B5R6BVdi/4AxdH6WC1tpps/PYi34tqtfxslU4F+Grbgi4
Kj647sNH7RGWcl85ruXixmS2uSUVNHRrzvP1sZP5iapHEAI0s+bXTBkbGYWxpruc
/yNUxQoRIaMXx0Zj0mdxEwOAH0W3P88+4JZWvyD+8a/y+aavTg0iVC++6e4hsm2E
9R/waQyAqRhuZM9NQOt1
=pW57
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
