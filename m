Received: from eggs.gnu.org ([2001:4830:134:3::10]:57243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQ2N-0005Fj-7q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQ2M-0005PG-5A
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:18:35 -0400
Date: Fri, 7 Apr 2017 10:18:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407091822.GI13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<1eeddeba3dc5775183bd1e44ecae616c233b932d.1491416061.git.jcody@redhat.com>
	<4c0fc97d-ca5a-4952-570b-f7598f2aec9d@redhat.com>
	<20170406002312.GL1135@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20170406002312.GL1135@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/9] block: introduce
 bdrv_try_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 08:23:12PM -0400, Jeff Cody wrote:
> On Wed, Apr 05, 2017 at 04:28:44PM -0400, John Snow wrote:
> > On 04/05/2017 02:28 PM, Jeff Cody wrote:
> > > diff --git a/include/block/block.h b/include/block/block.h
> > > index beb563a..0049b57 100644
> > > --- a/include/block/block.h
> > > +++ b/include/block/block.h
> > > @@ -426,6 +426,7 @@ int bdrv_is_allocated_above(BlockDriverState *top=
, BlockDriverState *base,
> > >                              int64_t sector_num, int nb_sectors, int =
*pnum);
> > > =20
> > >  bool bdrv_is_read_only(BlockDriverState *bs);
> > > +int bdrv_try_set_read_only(BlockDriverState *bs, bool read_only, Err=
or **errp);
> > >  int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error *=
*errp);
> > >  bool bdrv_is_sg(BlockDriverState *bs);
> > >  bool bdrv_is_inserted(BlockDriverState *bs);
> > >=20
> >=20
> > Maybe I'm just green, but I find it weird that the function is named
> > try_x when we aren't actually trying to do anything, we're checking to
> > see if we can.
>=20
> Yeah, not a good name.  Maybe bdrv_set_read_only_test() or
> bdrv_test_set_read_only()?

This one reads nicely:

  if (bdrv_can_set_read_only(...)) {
      ...
  }

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51leAAoJEJykq7OBq3PIkFQIALjErNP9punH/yVfc32WbFJQ
AgweJdTZnR+u+6QcCIs5sjBVrB11PidCS5gPmHVsAInftZMU30/ZrgCvkHW3CB/F
J7Nq1Bw8JVCyMnLBHPPvz4dwCIWbnNoxU32WULDNb02lZzTSMwl8b1yLAu5ITn49
Kxzj3GmNGfZmi1qH+Ibsq+4wKjF/5yLzhi0wJ1yT8K++1NHx4MyvcNw2dDU+iKSy
p6LvMsOXQjhOnMsEM93VCUgx7sieVYUo8Yikm0E2Lw2NPVEhBEBqOR+b6CkCOY7M
yKneu5iLlYTttVlb6Jx8qQ2pf2hxsihIzGxdFd4RioydICGH4m9tNfYeFfxBL14=
=e4ox
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
