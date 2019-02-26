Received: from eggs.gnu.org ([209.51.188.92]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyi5M-0002RR-Mf
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyi5L-0003cP-6c
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:08:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gyi5K-0003SN-A3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:08:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id g20so2601723wmh.5
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190221110754-mutt-send-email-mst@kernel.org>
	<CAJ+F1CL5fyMyUX6=OEqsAoEKA8QeeybUvL3C6Q3to1DdBqOBTA@mail.gmail.com>
	<20190226135226-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190226135226-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Feb 2019 20:07:35 +0100
Message-ID: <CAJ+F1CJe-CqLaBmRBSL0qK=pnVcsS-rndM3TVhZpTPdf=ejbkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/13] vhost-user-backend &
 vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Tue, Feb 26, 2019 at 7:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 26, 2019 at 05:38:32PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Feb 21, 2019 at 5:09 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Fri, Feb 08, 2019 at 12:23:44PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi,
> > > >
> > > > This series is based on previously discussed "[PATCH v4 00/29]
> > > > vhost-user for input & GPU" and "vhost-user: define conventions for
> > > > vhost-user backends" work. The GPU part is left off for now.
> > > >
> > > > This series introduces a "vhost-user-backend": an helper object to =
be
> > > > used by vhost-user devices to ease with backend initialization and
> > > > handling. As a simple showcase, a "vhost-user-input-pci" device is
> > > > introduced, which can be used with the "contrib: add vhost-user-inp=
ut"
> > > > example. vhost-user-input isn't meant to be installed, discovered o=
r
> > > > used by libvirt: no installation is done (no vhost-user JSON file i=
s
> > > > provided either).
> > > >
> > > > thanks
> > >
> > > Gerd could you please review this?
> > > Thanks!
> >
> > Except the last patch that (to drop?), are you queuing this series or
> > expecting me to do something else?
> >
> > thanks
>
> Besides acks I also see unaddressed comments by Daniel and others.

>From v3? Yes, there is one field in a struct that should be removed, I
forgot. Gerd can do that on commit, or I can resend the whole thing.

https://patchew.org/QEMU/20190208112357.31615-1-marcandre.lureau@redhat.com=
/20190208112357.31615-7-marcandre.lureau@redhat.com/

Anything else I missed from earlier versions?

thanks

>
> > >
> > > > v3:
> > > > - add previously sent patch "libvhost-user: fix clang enum-conversi=
on
> > > >   warning" to fix clang build
> > > > - "define conventions for vhost-user backends" updates after Eric r=
eview
> > > > - Drop user-creatable from vhost-user-backend
> > > > - Make vhost-user-input-pci take a chardev=3D (instead of vhost-use=
r=3D)
> > > >
> > > > v2:
> > > > - rebased (VhostUserInputPCI got most of the changes, due to split)
> > > > - added "RFC: add explicit can_migrate to
> > > >   vhost_user_backend_dev_init()" to attempt to address Michael
> > > >   concerns about migration.
> > > >
> > > > Marc-Andr=C3=A9 Lureau (13):
> > > >   libvhost-user: fix clang enum-conversion warning
> > > >   vhost-user: define conventions for vhost-user backends
> > > >   vhost-user: simplify vhost_user_init/vhost_user_cleanup
> > > >   libvhost-user: exit by default on VHOST_USER_NONE
> > > >   vhost-user: wrap some read/write with retry handling
> > > >   Add vhost-user-backend
> > > >   vhost-user: split vhost_user_read()
> > > >   vhost-user: add vhost_user_input_get_config()
> > > >   libvhost-user-glib: export vug_source_new()
> > > >   libvhost-user: add vu_queue_unpop()
> > > >   Add vhost-user-input-pci
> > > >   contrib: add vhost-user-input
> > > >   RFC: add explicit can_migrate to vhost_user_backend_dev_init()
> > > >
> > > >  contrib/libvhost-user/libvhost-user-glib.h |   3 +
> > > >  contrib/libvhost-user/libvhost-user.h      |  17 +-
> > > >  include/hw/virtio/vhost-backend.h          |   4 +
> > > >  include/hw/virtio/vhost-user-blk.h         |   2 +-
> > > >  include/hw/virtio/vhost-user-scsi.h        |   2 +-
> > > >  include/hw/virtio/vhost-user.h             |   2 +-
> > > >  include/hw/virtio/virtio-input.h           |  14 +
> > > >  include/sysemu/vhost-user-backend.h        |  60 ++++
> > > >  backends/cryptodev-vhost-user.c            |  18 +-
> > > >  backends/vhost-user.c                      | 218 +++++++++++
> > > >  contrib/libvhost-user/libvhost-user-glib.c |  11 +-
> > > >  contrib/libvhost-user/libvhost-user.c      |  19 +-
> > > >  contrib/vhost-user-input/main.c            | 398 +++++++++++++++++=
++++
> > > >  hw/block/vhost-user-blk.c                  |  22 +-
> > > >  hw/input/vhost-user-input.c                | 104 ++++++
> > > >  hw/scsi/vhost-user-scsi.c                  |  20 +-
> > > >  hw/virtio/vhost-stub.c                     |   4 +-
> > > >  hw/virtio/vhost-user-input-pci.c           |  53 +++
> > > >  hw/virtio/vhost-user.c                     | 118 +++++-
> > > >  net/vhost-user.c                           |  13 +-
> > > >  MAINTAINERS                                |   5 +
> > > >  Makefile                                   |   3 +
> > > >  Makefile.objs                              |   1 +
> > > >  backends/Makefile.objs                     |   3 +-
> > > >  configure                                  |   3 +
> > > >  contrib/vhost-user-input/Makefile.objs     |   1 +
> > > >  default-configs/virtio.mak                 |   1 +
> > > >  docs/interop/vhost-user.json               | 232 ++++++++++++
> > > >  docs/interop/vhost-user.txt                | 109 +++++-
> > > >  hw/input/Makefile.objs                     |   1 +
> > > >  hw/virtio/Makefile.objs                    |   1 +
> > > >  31 files changed, 1375 insertions(+), 87 deletions(-)
> > > >  create mode 100644 include/sysemu/vhost-user-backend.h
> > > >  create mode 100644 backends/vhost-user.c
> > > >  create mode 100644 contrib/vhost-user-input/main.c
> > > >  create mode 100644 hw/input/vhost-user-input.c
> > > >  create mode 100644 hw/virtio/vhost-user-input-pci.c
> > > >  create mode 100644 contrib/vhost-user-input/Makefile.objs
> > > >  create mode 100644 docs/interop/vhost-user.json
> > > >
> > > > --
> > > > 2.20.1.519.g8feddda32c
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
