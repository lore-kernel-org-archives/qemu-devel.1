Received: from eggs.gnu.org ([2001:4830:134:3::10]:42931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cbSnh-00044D-Ju
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cbSnc-00059X-5J
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:00:49 -0500
Date: Wed, 8 Feb 2017 09:00:37 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1904417137.1617199.1486562437768.JavaMail.zimbra@redhat.com>
In-Reply-To: <58a6feee-8828-d159-daf9-b460a6c0c7c4@redhat.com>
References: <20170208080900.4092-1-marcandre.lureau@redhat.com>
	<58a6feee-8828-d159-daf9-b460a6c0c7c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-trivial@nongnu.org

Hi

----- Original Message -----
> On 08.02.2017 09:09, Marc-Andr=C3=A9 Lureau wrote:
> > g_strdup() already handles the case where the argument is NULL.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  block/qcow2.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 96fb8a8f16..9114218030 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2016,8 +2016,8 @@ static int qcow2_change_backing_file(BlockDriverS=
tate
> > *bs,
> >      g_free(s->image_backing_file);
> >      g_free(s->image_backing_format);
> > =20
> > -    s->image_backing_file =3D backing_file ? g_strdup(bs->backing_file=
) :
> > NULL;
> > -    s->image_backing_format =3D backing_fmt ? g_strdup(bs->backing_for=
mat) :
> > NULL;
> > +    s->image_backing_file =3D g_strdup(bs->backing_file);
> > +    s->image_backing_format =3D g_strdup(bs->backing_format);
>=20
> bs->backing_file and bs->backing_format are arrays. They will never be NU=
LL.
>=20
> The ternary operator tests backing_file and backing_fmt which instead
> are pointers. So this is not an equivalent conversion.

oops my bad, ignore ;P a bit uncommon code though, could deserve a comment.


>=20
> Max
>=20
> > =20
> >      return qcow2_update_header(bs);
> >  }
> >=20
>=20
>=20
>=20
