Received: from eggs.gnu.org ([2001:4830:134:3::10]:36056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzKI-0003yC-Gf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cpzKF-0005wq-DG
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cpzKF-0005w1-6V
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:27 -0400
Date: Mon, 20 Mar 2017 15:34:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170320153421.GA7320@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-2-stefanha@redhat.com>
	<CAMRbyyt8DHj_-7MapWVC9G7+yOGtDra4gRiJDui68mqT9PanpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <CAMRbyyt8DHj_-7MapWVC9G7+yOGtDra4gRiJDui68mqT9PanpQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 01:28:04AM +0000, Nir Soffer wrote:
> On Wed, Mar 15, 2017 at 11:29 AM Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
> > diff --git a/include/block/block.h b/include/block/block.h
> > index 5149260..43c789f 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -298,6 +298,10 @@ int bdrv_truncate(BdrvChild *child, int64_t offset=
);
> >  int64_t bdrv_nb_sectors(BlockDriverState *bs);
> >  int64_t bdrv_getlength(BlockDriverState *bs);
> >  int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
> > +void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> > +                  BlockDriverState *in_bs,
> > +                  BlockMeasureInfo *info,
> >
>=20
> The struct declaration is missing in this patch, right?

BlockMeasureInfo is generated from qapi-schema.json during the build.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz/Z9AAoJEJykq7OBq3PIroYH/0MwLvvL70EldsWa9PG7Iwiq
eIr8BqUNw4SS/g7QTf1PN70ZiJ9iOjh6UjcdBODSFJm0qEB1F8Xw7q7itAd+6S7B
Z9Jg4upAW0wzn27ZT38xWhBgdPY/YaYX6wybsg6YgCmwm2zN/jIaiap1xgwZ7uVv
JCwLcTQhA562Bm8LlsNK7Z0MQVKVO7/fdoV8QI4Zh7H7IJkv+GLccIGgNL+HdtAY
prtZyY5Am5+3SQmY/Q9ZahMZn4ah3ICB6JN2yLUDBqQXYbBBHq/B7AVs3PrnJpIl
9EThk3vV35CZKlu9Om4KWqJ/TQSF327quPB7KVDowO1PCM5Z2Mx5Klb74C84ZKU=
=X64P
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
