Received: from eggs.gnu.org ([2001:4830:134:3::10]:59580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfm2m-0007hj-49
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfm2l-0005LP-7o
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:22:12 -0500
Date: Mon, 20 Feb 2017 12:22:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170220112201.GB4814@noname.redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-17-git-send-email-kwolf@redhat.com>
	<ef9df6e6-6029-29ba-caa6-93bdbe835bae@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <ef9df6e6-6029-29ba-caa6-93bdbe835bae@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 16/41] block: Add error parameter to
 blk_insert_bs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.02.2017 um 12:04 hat Max Reitz geschrieben:
> On 13.02.2017 18:22, Kevin Wolf wrote:
> > Mow that blk_insert_bs() requests the BlockBackend permissions for the
> > node it attaches to, it can fail. Instead of aborting, pass the errors
> > to the callers.
>=20
> So it does qualify as a FIXME, but just for a single patch. Good. :-)
>=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/backup.c                   |  5 ++++-
> >  block/block-backend.c            | 12 ++++++++----
> >  block/commit.c                   | 38 ++++++++++++++++++++++++++++++--=
------
> >  block/mirror.c                   | 15 ++++++++++++---
> >  blockdev.c                       |  6 +++++-
> >  blockjob.c                       |  7 ++++++-
> >  hmp.c                            |  6 +++++-
> >  hw/core/qdev-properties-system.c |  7 ++++++-
> >  include/sysemu/block-backend.h   |  2 +-
> >  migration/block.c                |  2 +-
> >  nbd/server.c                     |  6 +++++-
> >  tests/test-blockjob.c            |  2 +-
> >  12 files changed, 84 insertions(+), 24 deletions(-)
>=20
> [...]
>=20
> > diff --git a/migration/block.c b/migration/block.c
> > index 6b7ffd4..d259936 100644
> > --- a/migration/block.c
> > +++ b/migration/block.c
> > @@ -446,7 +446,7 @@ static void init_blk_migration(QEMUFile *f)
> >          BlockDriverState *bs =3D bmds_bs[i].bs;
> > =20
> >          if (bmds) {
> > -            blk_insert_bs(bmds->blk, bs);
> > +            blk_insert_bs(bmds->blk, bs, &error_abort);
>=20
> I don't think it's obvious why this is correct. I assume it is because
> this was a legal configuration on the source, so it must be a legal
> configuration on the destination.
>=20
> But I'd certainly appreciate a comment to make that explicitly clear,
> especially considering that it isn't obvious that blk_insert_bs() can
> fail only because of op blockers and thus will always work if the
> configuration is known to be legal.

Actually, it's just because the requested permissions for bmds->blk are
still 0, BLK_PERM_ALL here. Once the FIXME is addressed (patch 37) and
the real permissions are requested, we get some error handling here.

Kevin

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYqtFZAAoJEH8JsnLIjy/W5jYP/2iLgIxS+k2W9OT/Av5lN5VX
i2porAuLV8/Ub6CZEpdHw2985bYvK3IteiRRvrRxb/ocjbx3t5QdXCrmivPIWzfl
Z8jwO7Zf2zsqLfRgGzQ9tts7HaypvPhxvf8TXqnBs+nGlv6LCbmKTFLCYW/4JJXh
uAmGEDdzEz2rl5p6zp1Gpxgj8wyZ4aCxGogueViSBDdve6lI2HbJRxTnOTnp2sMS
YSkx6ivpioOHMAJYAytaRlG0Yyp2ny8mXnMjphIPupM2XohSuShFWicxQxcjnIMg
bEridHdNE50KXycCwpXAcAQFcaL9eFnhM5dpkf7U8va3Bw/A3iIRWE72Wx5/8CCc
RSvFmuicceFidUpUlu2rsSpRAfZYuP6enn7ev8lvZfrrBrtAY4VdRPdr46ZyFWIF
RRHt7yXxZW6q2fttoYfCqED6DToLHVSskdYcDNByiB1Q4vw65elib79864e3u1qs
A/ZdLSWBWxeysl8Mx3xgNYcLa7Vuci9/BuufAfMKbv/wsC/M+ZHaU8+QA1SNSbf/
dLtH//fbpt8VyzZqDsGEHOLEa41LjZqnF/VjNr7fOrn+JHBBSLrVQ6VU47BDa/xF
K7CQycNg5MrXhGWUdpdY3w1gd30WVTYOGtkfkLXjB6wtUQrc8sea2fmWYrTB3eKW
GlMln2LOc2kllad9/LWe
=6xtM
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
