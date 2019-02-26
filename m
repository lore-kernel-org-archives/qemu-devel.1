Received: from eggs.gnu.org ([209.51.188.92]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gyi1Y-0007JJ-EN
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gyhpk-0008Hh-5L
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:52:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gyhpi-0008FL-8I
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:52:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so16113416qti.13
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:52:01 -0800 (PST)
Date: Tue, 26 Feb 2019 13:51:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190226135044-mutt-send-email-mst@kernel.org>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190221110754-mutt-send-email-mst@kernel.org>
	<CAJ+F1CL5fyMyUX6=OEqsAoEKA8QeeybUvL3C6Q3to1DdBqOBTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL5fyMyUX6=OEqsAoEKA8QeeybUvL3C6Q3to1DdBqOBTA@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Feb 26, 2019 at 05:38:32PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Feb 21, 2019 at 5:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 08, 2019 at 12:23:44PM +0100, Marc-André Lureau wrote:
> > > Hi,
> > >
> > > This series is based on previously discussed "[PATCH v4 00/29]
> > > vhost-user for input & GPU" and "vhost-user: define conventions for
> > > vhost-user backends" work. The GPU part is left off for now.
> > >
> > > This series introduces a "vhost-user-backend": an helper object to be
> > > used by vhost-user devices to ease with backend initialization and
> > > handling. As a simple showcase, a "vhost-user-input-pci" device is
> > > introduced, which can be used with the "contrib: add vhost-user-input"
> > > example. vhost-user-input isn't meant to be installed, discovered or
> > > used by libvirt: no installation is done (no vhost-user JSON file is
> > > provided either).
> > >
> > > thanks
> >
> > Gerd could you please review this?
> > Thanks!
> 
> Except the last patch that (to drop?), are you queuing this series or
> expecting me to do something else?
> 
> thanks

I think that preferably we'd need Gerd to ack these.
He's the most qualified to look at virtio input.

> >
> > > v3:
> > > - add previously sent patch "libvhost-user: fix clang enum-conversion
> > >   warning" to fix clang build
> > > - "define conventions for vhost-user backends" updates after Eric review
> > > - Drop user-creatable from vhost-user-backend
> > > - Make vhost-user-input-pci take a chardev= (instead of vhost-user=)
> > >
> > > v2:
> > > - rebased (VhostUserInputPCI got most of the changes, due to split)
> > > - added "RFC: add explicit can_migrate to
> > >   vhost_user_backend_dev_init()" to attempt to address Michael
> > >   concerns about migration.
> > >
> > > Marc-André Lureau (13):
> > >   libvhost-user: fix clang enum-conversion warning
> > >   vhost-user: define conventions for vhost-user backends
> > >   vhost-user: simplify vhost_user_init/vhost_user_cleanup
> > >   libvhost-user: exit by default on VHOST_USER_NONE
> > >   vhost-user: wrap some read/write with retry handling
> > >   Add vhost-user-backend
> > >   vhost-user: split vhost_user_read()
> > >   vhost-user: add vhost_user_input_get_config()
> > >   libvhost-user-glib: export vug_source_new()
> > >   libvhost-user: add vu_queue_unpop()
> > >   Add vhost-user-input-pci
> > >   contrib: add vhost-user-input
> > >   RFC: add explicit can_migrate to vhost_user_backend_dev_init()
> > >
> > >  contrib/libvhost-user/libvhost-user-glib.h |   3 +
> > >  contrib/libvhost-user/libvhost-user.h      |  17 +-
> > >  include/hw/virtio/vhost-backend.h          |   4 +
> > >  include/hw/virtio/vhost-user-blk.h         |   2 +-
> > >  include/hw/virtio/vhost-user-scsi.h        |   2 +-
> > >  include/hw/virtio/vhost-user.h             |   2 +-
> > >  include/hw/virtio/virtio-input.h           |  14 +
> > >  include/sysemu/vhost-user-backend.h        |  60 ++++
> > >  backends/cryptodev-vhost-user.c            |  18 +-
> > >  backends/vhost-user.c                      | 218 +++++++++++
> > >  contrib/libvhost-user/libvhost-user-glib.c |  11 +-
> > >  contrib/libvhost-user/libvhost-user.c      |  19 +-
> > >  contrib/vhost-user-input/main.c            | 398 +++++++++++++++++++++
> > >  hw/block/vhost-user-blk.c                  |  22 +-
> > >  hw/input/vhost-user-input.c                | 104 ++++++
> > >  hw/scsi/vhost-user-scsi.c                  |  20 +-
> > >  hw/virtio/vhost-stub.c                     |   4 +-
> > >  hw/virtio/vhost-user-input-pci.c           |  53 +++
> > >  hw/virtio/vhost-user.c                     | 118 +++++-
> > >  net/vhost-user.c                           |  13 +-
> > >  MAINTAINERS                                |   5 +
> > >  Makefile                                   |   3 +
> > >  Makefile.objs                              |   1 +
> > >  backends/Makefile.objs                     |   3 +-
> > >  configure                                  |   3 +
> > >  contrib/vhost-user-input/Makefile.objs     |   1 +
> > >  default-configs/virtio.mak                 |   1 +
> > >  docs/interop/vhost-user.json               | 232 ++++++++++++
> > >  docs/interop/vhost-user.txt                | 109 +++++-
> > >  hw/input/Makefile.objs                     |   1 +
> > >  hw/virtio/Makefile.objs                    |   1 +
> > >  31 files changed, 1375 insertions(+), 87 deletions(-)
> > >  create mode 100644 include/sysemu/vhost-user-backend.h
> > >  create mode 100644 backends/vhost-user.c
> > >  create mode 100644 contrib/vhost-user-input/main.c
> > >  create mode 100644 hw/input/vhost-user-input.c
> > >  create mode 100644 hw/virtio/vhost-user-input-pci.c
> > >  create mode 100644 contrib/vhost-user-input/Makefile.objs
> > >  create mode 100644 docs/interop/vhost-user.json
> > >
> > > --
> > > 2.20.1.519.g8feddda32c
> >
> 
> 
> -- 
> Marc-André Lureau
