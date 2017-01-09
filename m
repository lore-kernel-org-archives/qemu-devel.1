Received: from eggs.gnu.org ([2001:4830:134:3::10]:33685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cQYFO-0005WM-I8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cQYFJ-00069e-6h
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:36:18 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cQYFI-00067c-Vl
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:36:13 -0500
Received: by mail-oi0-x243.google.com with SMTP id 3so64196705oih.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 03:36:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109090906.68302195@bahia.lan>
References: <1483533149-12807-1-git-send-email-ashijeetacharya@gmail.com>
	<1483533149-12807-5-git-send-email-ashijeetacharya@gmail.com>
	<20170106174039.62523cdd@bahia.lan>
	<CAC2QTZbdu9k6pDa7RoJyFjW4_oeeQEZxsyqw44oqw7VYS6PZig@mail.gmail.com>
	<20170109090906.68302195@bahia.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 9 Jan 2017 17:06:09 +0530
Message-ID: <CAC2QTZaPQGg5XFpnLr7Zo2Vvi0Sn5xYpzH_CVBYJ1Qxkc_esJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Monday, 9 January 2017, Greg Kurz <groug@kaod.org> wrote:

> Again v3 turned into v2... what happened ?


I am suspecting that my email client is at fault for this :(

>
> On Sun, 8 Jan 2017 12:55:51 +0530
> Ashijeet Acharya <ashijeetacharya@gmail.com <javascript:;>> wrote:
>
> > On Friday, January 6, 2017, Greg Kurz <groug@kaod.org <javascript:;>
> > <javascript:_e(%7B%7D,'cvml','groug@kaod.org <javascript:;>');>> wrote:
> >
> > > On Wed,  4 Jan 2017 18:02:29 +0530
> > > Ashijeet Acharya <ashijeetacharya@gmail.com <javascript:;>> wrote:
> > >
> > > > migrate_add_blocker should rightly fail if the '--only-migratable'
> > > > option was specified and the device in use should not be able to
> > > > perform the action which results in an unmigratable VM.
> > > >
> > > > Make migrate_add_blocker return -EACCES in this case.
> > > >
> > > > Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com
> <javascript:;>>
> > > > ---
> > > >  block/qcow.c                |  5 ++++-
> > > >  block/vdi.c                 |  5 ++++-
> > > >  block/vhdx.c                |  6 ++++--
> > > >  block/vmdk.c                |  5 ++++-
> > > >  block/vpc.c                 |  5 ++++-
> > > >  block/vvfat.c               |  6 ++++--
> > > >  hw/9pfs/9p.c                |  8 +++++++-
> > > >  hw/display/virtio-gpu.c     |  9 +++++++--
> > > >  hw/intc/arm_gic_kvm.c       |  5 ++++-
> > > >  hw/intc/arm_gicv3_its_kvm.c |  5 ++++-
> > > >  hw/intc/arm_gicv3_kvm.c     |  5 ++++-
> > > >  hw/misc/ivshmem.c           | 10 ++++++++--
> > > >  hw/scsi/vhost-scsi.c        |  8 +++++---
> > > >  hw/virtio/vhost.c           |  6 ++++--
> > > >  migration/migration.c       |  7 +++++++
> > > >  target-i386/kvm.c           |  5 ++++-
> > > >  16 files changed, 78 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/block/qcow.c b/block/qcow.c
> > > > index 11526a1..bdc6446 100644
> > > > --- a/block/qcow.c
> > > > +++ b/block/qcow.c
> > > > @@ -254,7 +254,10 @@ static int qcow_open(BlockDriverState *bs, QDict
> > > *options, int flags,
> > > >                 bdrv_get_device_or_node_name(bs));
> > > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >      if (ret < 0) {
> > > > -        error_free(s->migration_blocker);
> > > > +        if (ret == -EACCES) {
> > > > +            error_append_hint(errp, "Cannot use a node with qcow
> format
> > > as "
> > > > +                              "it does not support live migration");
> > > > +        }
> > > >          goto fail;
> > > >      }
> > > >
> > > > diff --git a/block/vdi.c b/block/vdi.c
> > > > index 2b56f52..0b011ea 100644
> > > > --- a/block/vdi.c
> > > > +++ b/block/vdi.c
> > > > @@ -473,7 +473,10 @@ static int vdi_open(BlockDriverState *bs, QDict
> > > *options, int flags,
> > > >                 bdrv_get_device_or_node_name(bs));
> > > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >      if (ret < 0) {
> > > > -        error_free(s->migration_blocker);
> > > > +        if (ret == -EACCES) {
> > > > +            error_append_hint(errp, "Cannot use a node with vdi
> format
> > > as "
> > > > +                              "it does not support live migration");
> > > > +        }
> > > >          goto fail_free_bmap;
> > > >      }
> > > >
> > > > diff --git a/block/vhdx.c b/block/vhdx.c
> > > > index d81941b..b8d53ec 100644
> > > > --- a/block/vhdx.c
> > > > +++ b/block/vhdx.c
> > > > @@ -997,10 +997,12 @@ static int vhdx_open(BlockDriverState *bs,
> QDict
> > > *options, int flags,
> > > >                 bdrv_get_device_or_node_name(bs));
> > > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >      if (ret < 0) {
> > > > -        error_free(s->migration_blocker);
> > > > +        if (ret == -EACCES) {
> > > > +            error_append_hint(errp, "Cannot use a node with vhdx
> format
> > > as "
> > > > +                              "it does not support live migration");
> > > > +        }
> > > >          goto fail;
> > > >      }
> > > > -
> > > >      if (flags & BDRV_O_RDWR) {
> > > >          ret = vhdx_update_headers(bs, s, false, NULL);
> > > >          if (ret < 0) {
> > > > diff --git a/block/vmdk.c b/block/vmdk.c
> > > > index 4a45a83..defe400 100644
> > > > --- a/block/vmdk.c
> > > > +++ b/block/vmdk.c
> > > > @@ -978,7 +978,10 @@ static int vmdk_open(BlockDriverState *bs, QDict
> > > *options, int flags,
> > > >                 bdrv_get_device_or_node_name(bs));
> > > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >      if (ret < 0) {
> > > > -        error_free(s->migration_blocker);
> > > > +        if (ret == -EACCES) {
> > > > +            error_append_hint(errp, "Cannot use a node with vmdk
> format
> > > as "
> > > > +                              "it does not support live migration");
> > > > +        }
> > > >          goto fail;
> > > >      }
> > > >
> > > > diff --git a/block/vpc.c b/block/vpc.c
> > > > index 299a8c8..5e58d77 100644
> > > > --- a/block/vpc.c
> > > > +++ b/block/vpc.c
> > > > @@ -428,7 +428,10 @@ static int vpc_open(BlockDriverState *bs, QDict
> > > *options, int flags,
> > > >                 bdrv_get_device_or_node_name(bs));
> > > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >      if (ret < 0) {
> > > > -        error_free(s->migration_blocker);
> > > > +        if (ret == -EACCES) {
> > > > +            error_append_hint(errp, "Cannot use a node with vpc
> format
> > > as "
> > > > +                              "it does not support live migration");
> > > > +        }
> > > >          goto fail;
> > > >      }
> > > >
> > > > diff --git a/block/vvfat.c b/block/vvfat.c
> > > > index 3de3320..5a6e038 100644
> > > > --- a/block/vvfat.c
> > > > +++ b/block/vvfat.c
> > > > @@ -1193,7 +1193,10 @@ static int vvfat_open(BlockDriverState *bs,
> QDict
> > > *options, int flags,
> > > >                     bdrv_get_device_or_node_name(bs));
> > > >          ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >          if (ret < 0) {
> > > > -            error_free(s->migration_blocker);
> > > > +            if (ret == -EACCES) {
> > > > +                error_append_hint(errp, "Cannot use a node with
> vvfat
> > > format "
> > > > +                                  "as it does not support live
> > > migration");
> > > > +            }
> > > >              goto fail;
> > > >          }
> > > >      }
> > > > @@ -1202,7 +1205,6 @@ static int vvfat_open(BlockDriverState *bs,
> QDict
> > > *options, int flags,
> > > >          init_mbr(s, cyls, heads, secs);
> > > >      }
> > > >
> > > > -    //    assert(is_consistent(s));
> > > >      qemu_co_mutex_init(&s->lock);
> > > >
> > > >      ret = 0;
> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index 43cb065..3b4fd24 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -1020,17 +1020,23 @@ static void coroutine_fn v9fs_attach(void
> > > *opaque)
> > > >       */
> > > >      if (!s->migration_blocker) {
> > > >          int ret;
> > > > +        Error *local_err;
> > > >          error_setg(&s->migration_blocker,
> > > >                     "Migration is disabled when VirtFS export path
> '%s'
> > > is mounted in the guest using mount_tag '%s'",
> > > >                     s->ctx.fs_root ? s->ctx.fs_root : "NULL",
> s->tag);
> > > > -        ret = migrate_add_blocker(s->migration_blocker, NULL);
> > > > +        ret = migrate_add_blocker(s->migration_blocker,
> &local_err);
> > > >          if (ret < 0) {
> > > > +            if (ret == -EACCES) {
> > > > +                error_append_hint(&local_err, "Failed to mount
> VirtFS
> > > as it "
> > > > +                                  "does not support live
> migration");
> > > > +            }
> > > >              err = ret;
> > > >              clunk_fid(s, fid);
> > > >              error_free(s->migration_blocker);
> > > >              s->migration_blocker = NULL;
> > > >              goto out;
> > > >          }
> > > > +        error_free(local_err);
> > >
> > > Thinking again, I suggest you simply drop these changes: v9fs_attach()
> is
> > > triggered by the guest and doesn't cause QEMU to fail, so we don't
> really
> > > care.
> > >
> > > This might be naive but I didn't quite understand which changes you are
> > implying here.  V2 to V3 or the entire diff in 9pfs?
> >
>
> The entire diff of 4/4 in 9pfs, which has no effect actually since
> local_err
> is not even passed to error_report_err() :) and anyway, this would allow
> a guest to fill the QEMU log with error messages if it deviced to call
> mount(2) repeatedly.


Alright, I will drop these changes. Thanks for clearing that up.

Ashijeet
