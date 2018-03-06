Received: from eggs.gnu.org ([2001:4830:134:3::10]:42755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1et9xD-0006yl-NS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1et9x7-0008Eh-LB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:36:19 -0500
Date: Tue, 6 Mar 2018 10:35:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180306103552.GA27489@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180118103143.11780-1-berrange@redhat.com>
	<20180216135312.GD3181@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216135312.GD3181@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Ping=20

On Fri, Feb 16, 2018 at 01:53:12PM +0000, Daniel P. Berrang=C3=A9 wrote:
> Ping, can this be queued in the block tree, since it appears the no-op =
impl
> is ok ?
>=20
> On Thu, Jan 18, 2018 at 10:31:43AM +0000, Daniel P. Berrange wrote:
> > If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
> > command fails to re-open the base layer after committing changes into
> > it. Provide a no-op implementation for the LUKS driver, since there
> > is not any custom work that needs doing to re-open it.
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/crypto.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 60ddf8623e..bb9a8f5376 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -382,6 +382,12 @@ static void block_crypto_close(BlockDriverState =
*bs)
> >      qcrypto_block_free(crypto->block);
> >  }
> > =20
> > +static int block_crypto_reopen_prepare(BDRVReopenState *state,
> > +                                       BlockReopenQueue *queue, Erro=
r **errp)
> > +{
> > +    /* nothing needs checking */
> > +    return 0;
> > +}
> > =20
> >  /*
> >   * 1 MB bounce buffer gives good performance / memory tradeoff
> > @@ -620,6 +626,7 @@ BlockDriver bdrv_crypto_luks =3D {
> >      .bdrv_truncate      =3D block_crypto_truncate,
> >      .create_opts        =3D &block_crypto_create_opts_luks,
> > =20
> > +    .bdrv_reopen_prepare =3D block_crypto_reopen_prepare,
> >      .bdrv_refresh_limits =3D block_crypto_refresh_limits,
> >      .bdrv_co_preadv     =3D block_crypto_co_preadv,
> >      .bdrv_co_pwritev    =3D block_crypto_co_pwritev,
> > --=20
> > 2.14.3
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
