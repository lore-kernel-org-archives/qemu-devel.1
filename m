Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eFKpX-0000Ue-Ao
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eFKpN-0007iI-G7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:07:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eFKpN-0007hO-9r
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:07:37 -0500
Received: by mail-wm0-f68.google.com with SMTP id 70so253466wmf.1
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 06:07:37 -0800 (PST)
Date: Thu, 16 Nov 2017 15:07:33 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171116150733.2dccc760@fiorina>
In-Reply-To: <181C9C1B-9119-4B1D-8327-0C5EFD42A5F5@redhat.com>
References: <cover.1505923516.git.tgolembi@redhat.com>
	<13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
	<181C9C1B-9119-4B1D-8327-0C5EFD42A5F5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH 1/1] virtio-balloon: include
 buffers and chached memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 16 Nov 2017 15:38:21 +0200
Yan Vugenfirer <yvugenfi@redhat.com> wrote:

> Hello All,
>=20
> Michael asked me to comment regarding the possibility to get this statist=
ics on Windows.
> By using Win32_OperatingSystem WMI class we can calculate the amount of c=
ached memory (https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).=
aspx <https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).aspx> ht=
tp://brandonlive.com/2010/02/21/measuring-memory-usage-in-windows-7/ <http:=
//brandonlive.com/2010/02/21/measuring-memory-usage-in-windows-7/>), but Wi=
ndows doesn=E2=80=99t let to distinguish between =E2=80=9Ccached and buffer=
s=E2=80=9D as far as I see.=20

Thanks for the input, Yan. That's definitely good to know.

    Tomas

>=20
> Best regards,
> Yan.
>=20
> > On 20 Sep 2017, at 19:05, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@r=
edhat.com> wrote:
> >=20
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> > hw/virtio/virtio-balloon.c                      | 2 ++
> > include/standard-headers/linux/virtio_balloon.h | 4 +++-
> > 2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index a705e0ec55..0434784c14 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -49,6 +49,8 @@ static const char *balloon_stat_names[] =3D {
> >    [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
> >    [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
> >    [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> > +   [VIRTIO_BALLOON_S_BUFFERS] =3D "stat-linux-buffers",
> > +   [VIRTIO_BALLOON_S_CACHED] =3D "stat-linux-cached",
> >    [VIRTIO_BALLOON_S_NR] =3D NULL
> > };
> >=20
> > diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/=
standard-headers/linux/virtio_balloon.h
> > index 9d06ccd066..d61efbfcee 100644
> > --- a/include/standard-headers/linux/virtio_balloon.h
> > +++ b/include/standard-headers/linux/virtio_balloon.h
> > @@ -52,7 +52,9 @@ struct virtio_balloon_config {
> > #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
> > #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> > #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
> > -#define VIRTIO_BALLOON_S_NR       7
> > +#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /proc */
> > +#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
> > +#define VIRTIO_BALLOON_S_NR       9
> >=20
> > /*
> >  * Memory statistics structure.
> > --=20
> > 2.14.1
> >=20
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >  =20
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
