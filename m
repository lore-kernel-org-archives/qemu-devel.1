Received: from eggs.gnu.org ([2001:4830:134:3::10]:56504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1drObf-0004tS-BE
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1drObd-0001Dd-J7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:18:31 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:34619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1drObd-0001CG-BN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:18:29 -0400
Received: by mail-io0-x229.google.com with SMTP id v36so12883435ioi.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B5AEDAE@SHSMSX152.ccr.corp.intel.com>
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B5AEDAE@SHSMSX152.ccr.corp.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Sep 2017 13:18:16 +0000
Message-ID: <CAJ+F1CJ2q7-YX0Sww+sV9Sx0s0sViN++G-Q81P2hupwaZfztRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/27] vhost-user-scsi: code clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "felipe@nutanix.com" <felipe@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi

On Thu, Aug 24, 2017 at 2:41 AM Liu, Changpeng <changpeng.liu@intel.com>
wrote:

> Thanks for helping the example code clean-up. I can rebase the
> vhost-user-blk patch
> set after your commits. For the issue you mentioned below, I think the
> vhost-user-scsi example
> can only support 1 LUN, so LUN0 is exist, LUN1 reported error should be
> okay.
>

I think this series should go first before your vhost-user-blk, to avoid
code churn. Please help review.

Patches missing review: 1, 2, 3, 5, 8, 9, 10, 11, 13, 17, 20, 22, 24, 25, 2=
6

Thanks


> > -----Original Message-----
> > From: Marc-Andr=C3=A9 Lureau [mailto:marcandre.lureau@redhat.com]
> > Sent: Thursday, August 24, 2017 12:20 AM
> > To: qemu-devel@nongnu.org
> > Cc: Liu, Changpeng <changpeng.liu@intel.com>; felipe@nutanix.com;
> Marc-Andr=C3=A9
> > Lureau <marcandre.lureau@redhat.com>
> > Subject: [PATCH 00/27] vhost-user-scsi: code clean-up
> >
> > Hi,
> >
> > While reviewing vhost-user-blk, I realized a lot of code was based on
> > vhost-user-scsi, and I found a number of improvements could be
> > made. As a result in this series, I tried to move common glib code in
> > libvhost-user-glib. (I originally made libvhost-user glib-free, so if
> > external projects want to play with it, they don't have to depend on
> > glib, for ex vhost-user-bridge doesn't use glib).
> >
> > I haven't done extensive testing, I tried to setup a LUN with help
> > from https://fedoraproject.org/wiki/Scsi-target-utils_Quickstart_Guide,
> but
> > the guest says "Unexpected response from lun 1 while scanning, scan
> > aborted" (before or after the series). Help welcome!
> >
> > Thanks
> >
> > Marc-Andr=C3=A9 Lureau (27):
> >   glib-compat: move G_SOURCE_CONTINUE/REMOVE there
> >   libvhost-user: drop dependency on glib
> >   libvhost-user: improve vu_queue_pop() doc
> >   vhost-user-scsi: use g_strdup()
> >   vhost-user-scsi: connect unix socket before allocating
> >   vhost-user-scsi: code style fixes
> >   vhost-user-scsi: use glib allocation
> >   vhost-user-scsi: glib calls that allocate don't return NULL
> >   vhost-user-scsi: also free the gtree
> >   vhost-user-scsi: remove vdev_scsi_find_by_vu()
> >   vhost-user-scsi: simplify unix path cleanup
> >   vhost-user-scsi: use NULL pointer
> >   vhost-user-scsi: use glib watch directly
> >   vhost-user-scsi: assert() in iscsi_add_lun()
> >   vhost-user-scsi: remove vdev_scsi_add_iscsi_lun()
> >   vhost-user-scsi: remove VUS_MAX_LUNS
> >   vhost-user-scsi: remove unimplemented functions
> >   vhost-user-scsi: rename VUS types
> >   vhost-user-scsi: avoid use of iscsi_ namespace
> >   vhost-user-scsi: don't copy iscsi/scsi-lowlevel.h
> >   vhost-user-scsi: drop extra callback pointer
> >   vhost-user-scsi: simplify source handling
> >   vhost-user-scsi: use glib logging
> >   libvhost-user: add glib source helper
> >   build-sys: fix libvhost-user.a build
> >   vhost-user-scsi: use libvhost-user glib helper
> >   vhost-user-scsi: remove server_sock from VusDev
> >
> >  contrib/libvhost-user/libvhost-user-glib.h |  32 ++
> >  contrib/libvhost-user/libvhost-user.h      |   3 +-
> >  include/glib-compat.h                      |   7 +
> >  contrib/libvhost-user/libvhost-user-glib.c | 145 +++++++
> >  contrib/libvhost-user/libvhost-user.c      |  25 +-
> >  contrib/vhost-user-scsi/vhost-user-scsi.c  | 619
> +++++------------------------
> >  Makefile                                   |   3 +-
> >  Makefile.objs                              |   3 +-
> >  contrib/libvhost-user/Makefile.objs        |   2 +-
> >  tests/Makefile.include                     |   2 +-
> >  10 files changed, 320 insertions(+), 521 deletions(-)
> >  create mode 100644 contrib/libvhost-user/libvhost-user-glib.h
> >  create mode 100644 contrib/libvhost-user/libvhost-user-glib.c
> >
> > --
> > 2.14.1.146.gd35faa819
>
> --
Marc-Andr=C3=A9 Lureau
