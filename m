Received: from eggs.gnu.org ([2001:4830:134:3::10]:50236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dSW1x-0005AB-3n
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dSW1t-0002kU-Un
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dSW1t-0002kL-Nl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:10:45 -0400
Date: Wed, 5 Jul 2017 01:10:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170705010950-mutt-send-email-mst@kernel.org>
References: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
	<CAJ+F1CKUnefwkRtSUXdabuM6Scvu3z1OUeVnug9PFzaqz=_eoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKUnefwkRtSUXdabuM6Scvu3z1OUeVnug9PFzaqz=_eoA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, QEMU <qemu-devel@nongnu.org>

On Tue, Jul 04, 2017 at 11:59:54PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jul 5, 2017 at 12:33 AM, Peng Hao <peng.hao2@zte.com.cn> wrote:
> > vhost exists a call for g_file_get_contents, but not call g_free.
> >
> > Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> mst: is this better?

That's fine, thanks!

> > ---
> >  hw/virtio/vhost-backend.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 4e31de1..2c481d6 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -52,11 +52,13 @@ static int vhost_kernel_memslots_limit(struct vho=
st_dev *dev)
> >                              &s, NULL, NULL)) {
> >          uint64_t val =3D g_ascii_strtoull(s, NULL, 10);
> >          if (!((val =3D=3D G_MAXUINT64 || !val) && errno)) {
> > +            g_free(s);
> >              return val;
> >          }
> >          error_report("ignoring invalid max_mem_regions value in vhos=
t module:"
> >                       " %s", s);
> >      }
> > +    g_free(s);
> >      return limit;
> >  }
> >
> > --
> > 1.8.3.1
> >
> >
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
