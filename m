Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59EC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62451215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62451215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jP4-0003XZ-FE
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i4jOD-0002qs-IG
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i4jO8-0001dN-QP
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:16:47 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:46366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i4jO8-0001Y5-GE
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:16:44 -0400
Received: from player728.ha.ovh.net (unknown [10.108.54.13])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9B74D140DB7
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 12:16:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 82BB29418DE7;
 Mon,  2 Sep 2019 10:16:28 +0000 (UTC)
Date: Mon, 2 Sep 2019 12:16:26 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190902121626.4973d0a0@bahia.lan>
In-Reply-To: <2018575.EFrLczUYWK@silver>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <50fc6fbbfd80c25d2ad1752fb945cdfc7d847f20.1566503584.git.qemu_oss@crudebyte.com>
 <20190829185528.1db6607e@bahia.lan> <2018575.EFrLczUYWK@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17006155146117617984
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.140
Subject: Re: [Qemu-devel] [PATCH v6 2/4] 9p: Added virtfs option
 'multidevs=remap|forbid|warn'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 01 Sep 2019 20:40:34 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Donnerstag, 29. August 2019 18:55:28 CEST Greg Kurz wrote:
> > > diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> > > index 7c31ffffaf..07a18c6e48 100644
> > > --- a/fsdev/qemu-fsdev-opts.c
> > > +++ b/fsdev/qemu-fsdev-opts.c
> > > @@ -31,7 +31,9 @@ static QemuOptsList qemu_fsdev_opts =3D {
> > >=20
> > >          }, {
> > >         =20
> > >              .name =3D "readonly",
> > >              .type =3D QEMU_OPT_BOOL,
> > >=20
> > > -
> > > +        }, {
> > > +            .name =3D "multidevs",
> > > +            .type =3D QEMU_OPT_STRING,
> > >=20
> > >          }, {
> > >         =20
> > >              .name =3D "socket",
> > >              .type =3D QEMU_OPT_STRING,
> > >=20
> > > @@ -76,6 +78,9 @@ static QemuOptsList qemu_virtfs_opts =3D {
> > >=20
> > >              .name =3D "readonly",
> > >              .type =3D QEMU_OPT_BOOL,
> > >         =20
> > >          }, {
> > >=20
> > > +            .name =3D "multidevs",
> > > +            .type =3D QEMU_OPT_STRING,
> > > +        }, {
> > >=20
> > >              .name =3D "socket",
> > >              .type =3D QEMU_OPT_STRING,
> > >         =20
> > >          }, {
> > >=20
> > > diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> > > index 077a8c4e2b..ed03d559a9 100644
> > > --- a/fsdev/qemu-fsdev.c
> > > +++ b/fsdev/qemu-fsdev.c
> > > @@ -58,6 +58,7 @@ static FsDriverTable FsDrivers[] =3D {
> > >=20
> > >              "writeout",
> > >              "fmode",
> > >              "dmode",
> > >=20
> > > +            "multidevs",
> >=20
> > So we only allow this for the "local" backend. Any reason not to
> > add this to "proxy" as well ?
> >=20
> > I didn't do it for the "throttling" options because it is a
> > feature I didn't care to support much, but "multidevs" is more
> > a fix than a fancy feature.
>=20
> Well, to be honest I haven't cared about the proxy backend at all. Like I=
=20
> mentioned before, I am a bit sceptical that the proxy feature is actually=
 used=20
> by people in real life at all (at least in its current implementation). S=
o=20
> personally I don't see much sense in investing time for adding & testing =
new=20
> things on this backend ATM.
>=20

It's fine by me, as my ultimate plan is to deprecate proxy at some point
after virtio-fs gets merged :)

So in this case, you just need to not document the option as being
available for proxy.

> > > +    if (multidevs) {
> > > +        if (!strcmp(multidevs, "remap")) {
> > > +            fsle->fse.export_flags &=3D ~V9FS_FORBID_MULTIDEVS;
> > > +            fsle->fse.export_flags |=3D V9FS_REMAP_INODES;
> > > +        } else if (!strcmp(multidevs, "forbid")) {
> > > +            fsle->fse.export_flags &=3D ~V9FS_REMAP_INODES;
> > > +            fsle->fse.export_flags |=3D V9FS_FORBID_MULTIDEVS;
> > > +        }
> >=20
> > And...
> >=20
> >         } else if (!strcmp(multidevs, "warn")) {
> >             fsle->fse.export_flags &=3D ~V9FS_FORBID_MULTIDEVS;
> >             fsle->fse.export_flags &=3D ~V9FS_REMAP_INODES;
> >         } else {
> >             error_setg(errp, "invalid multidevs property '%s'", multide=
vs);
> >             return -1;
> >         }
> >=20
> > ... because we're a bit pedantic for command line options :)
>=20
> And I thought I adapted to relaxed handling of CLI arguments. See existin=
g=20
> option "writeout".  :)
>=20

Yeah... it's a mess. I don't think people really cared at the time, but
I personally prefer to have stricter checking. Feel free to send fixes :)

> >=20
> > > +    }
> > >=20
> > >      if (fsle->fse.ops->parse_opts) {
> > >     =20
> > >          if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
> > >=20
> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index 8cc65c2c67..c96ea51116 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > > @@ -25,6 +25,7 @@
> > >=20
> > >  #include "trace.h"
> > >  #include "migration/blocker.h"
> > >  #include "sysemu/qtest.h"
> > >=20
> > > +#include "qemu/xxhash.h"
> > >=20
> > >  int open_fd_hw;
> > >  int total_open_fd;
> > >=20
> > > @@ -571,22 +572,109 @@ static void coroutine_fn virtfs_reset(V9fsPDU =
*pdu)
> > >=20
> > >                                  P9_STAT_MODE_NAMED_PIPE |   \
> > >                                  P9_STAT_MODE_SOCKET)
> > >=20
> > > -/* This is the algorithm from ufs in spfs */
> > > +
> > > +/* creative abuse of tb_hash_func7, which is based on xxhash */
> > > +static uint32_t qpp_hash(QppEntry e)
> > > +{
> > > +    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
> > > +}
> > > +
> > > +static bool qpp_lookup_func(const void *obj, const void *userp)
> > > +{
> > > +    const QppEntry *e1 =3D obj, *e2 =3D userp;
> > > +    return e1->dev =3D=3D e2->dev && e1->ino_prefix =3D=3D e2->ino_p=
refix;
> > > +}
> > > +
> > > +static void qpp_table_remove(void *p, uint32_t h, void *up)
> > > +{
> > > +    g_free(p);
> > > +}
> > > +
> > > +static void qpp_table_destroy(struct qht *ht)
> > > +{
> > > +    qht_iter(ht, qpp_table_remove, NULL);
> > > +    qht_destroy(ht);
> > > +}
> >=20
> > Ok to have a function for this instead of open-coding but I'd
> > like to see qpp_table_init() for consistency.
>=20
> Well, these are just qht_init() one-liners, but if you really want to hav=
e=20
> dedicated, local init functions for them, okay.
>=20

Yeah, even if it's a one-liner, I prefer consistency. Alternatively, with
an idempotent v9fs_device_unrealize_common() like in [1], you'd have
only one user for qpp_table_destroy() and you can open-code it. This
would address my consistency concern even better :)

[1] https://github.com/gkurz/qemu/commit/7fc4c49e910df2e155b36bf0a05de9209b=
d92da9

> > >  static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQ=
ID
> > >  *qidp) {
> > >=20
> > > +    int err;
> > >=20
> > >      size_t size;
> > >=20
> > > -    if (pdu->s->dev_id !=3D stbuf->st_dev) {
> > > -        error_report_once(
> > > -            "9p: Multiple devices detected in same VirtFS export. "
> > > -            "You must use a separate export for each device."
> > > -        );
> > > -        return -ENODEV;
> > > +    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> > > +        /* map inode+device to qid path (fast path) */
> > > +        err =3D qid_path_prefixmap(pdu, stbuf, &qidp->path);
> > > +        if (err) {
> > > +            return err;
> > > +        }
> > > +    } else {
> > > +        if (pdu->s->dev_id !=3D stbuf->st_dev) {
> > > +            if (pdu->s->ctx.export_flags & V9FS_FORBID_MULTIDEVS) {
> > > +                error_report_once(
> > > +                    "9p: Multiple devices detected in same VirtFS ex=
port.
> > > " +                    "Access of guest to additional devices is (par=
tly)
> > > " +                    "denied due to virtfs option 'multidevs=3Dforb=
id'
> > > being " +                    "effective."
> > > +                );
> > > +                return -ENODEV;
> > > +            } else {
> > > +                error_report_once(
> >=20
> > Please use warn_report_once().
>=20
> Sure!
>=20
> > > +                    "9p: Multiple devices detected in same VirtFS ex=
port,
> > > " +                    "which might lead to file ID collisions and se=
vere
> > > " +                    "misbehaviours on guest! You should either use=
 a "
> > > +                    "separate export for each device shared from hos=
t or
> > > " +                    "use virtfs option 'multidevs=3Dremap'!"
> > > +                );
> > > +            }
> > > +        }
> > > +        memset(&qidp->path, 0, sizeof(qidp->path));
> > > +        size =3D MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
> > > +        memcpy(&qidp->path, &stbuf->st_ino, size);
> > >=20
> > >      }
> > >=20
> > > -    memset(&qidp->path, 0, sizeof(qidp->path));
> > > -    size =3D MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
> > > -    memcpy(&qidp->path, &stbuf->st_ino, size);
> > >=20
> > >      qidp->version =3D stbuf->st_mtime ^ (stbuf->st_size << 8);
> > >      qidp->type =3D 0;
> > >      if (S_ISDIR(stbuf->st_mode)) {
> > >=20
> > > @@ -616,6 +704,30 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu,
> > > V9fsFidState *fidp,>=20
> > >      return 0;
> > > =20
> > >  }
> > >=20
> > > +static int coroutine_fn dirent_to_qid(V9fsPDU *pdu, V9fsFidState *fi=
dp,
> > > +                                      struct dirent *dent, V9fsQID *=
qidp)
> > > +{
> > > +    struct stat stbuf;
> > > +    V9fsPath path;
> > > +    int err;
> > > +
> > > +    v9fs_path_init(&path);
> > > +
> > > +    err =3D v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &pa=
th);
> > > +    if (err < 0) {
> > > +        goto out;
> > > +    }
> > > +    err =3D v9fs_co_lstat(pdu, &path, &stbuf);
> > > +    if (err < 0) {
> > > +        goto out;
> > > +    }
> > > +    err =3D stat_to_qid(pdu, &stbuf, qidp);
> > > +
> > > +out:
> > > +    v9fs_path_free(&path);
> > > +    return err;
> > > +}
> > > +
> > >=20
> > >  V9fsPDU *pdu_alloc(V9fsState *s)
> > >  {
> > > =20
> > >      V9fsPDU *pdu =3D NULL;
> > >=20
> > > @@ -1964,16 +2076,39 @@ static int coroutine_fn v9fs_do_readdir(V9fsP=
DU
> > > *pdu, V9fsFidState *fidp,>=20
> > >              v9fs_string_free(&name);
> > >              return count;
> > >         =20
> > >          }
> > >=20
> > > -        /*
> > > -         * Fill up just the path field of qid because the client uses
> > > -         * only that. To fill the entire qid structure we will have
> > > -         * to stat each dirent found, which is expensive
> > > -         */
> > > -        size =3D MIN(sizeof(dent->d_ino), sizeof(qid.path));
> > > -        memcpy(&qid.path, &dent->d_ino, size);
> > > -        /* Fill the other fields with dummy values */
> > > -        qid.type =3D 0;
> > > -        qid.version =3D 0;
> > > +
> > > +        if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> > > +            /*
> > > +             * dirent_to_qid() implies expensive stat call for each
> > > entry,
> > > +             * we must do that here though since inode remapping req=
uires
> > > +             * the device id, which in turn might be different for
> > > +             * different entries; we cannot make any assumption to a=
void
> > > +             * that here.
> > > +             */
> > > +            err =3D dirent_to_qid(pdu, fidp, dent, &qid);
> > > +            if (err < 0) {
> > > +                v9fs_readdir_unlock(&fidp->fs.dir);
> > > +                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> > > +                v9fs_string_free(&name);
> > > +                return err;
> > > +            }
> > > +        } else {
> > > +            /*
> > > +             * Fill up just the path field of qid because the client=
 uses
> > > +             * only that. To fill the entire qid structure we will h=
ave
> > > +             * to stat each dirent found, which is expensive. For the
> > > +             * latter reason we don't call dirent_to_qid() here. Only
> > > drawback +             * is that no multi-device export detection of
> > > stat_to_qid() +             * would be done and provided as error to =
the
> > > user here. But +             * user would get that error anyway when
> > > accessing those +             * files/dirs through other ways.
> > > +             */
> > > +            size =3D MIN(sizeof(dent->d_ino), sizeof(qid.path));
> > > +            memcpy(&qid.path, &dent->d_ino, size);
> > > +            /* Fill the other fields with dummy values */
> > > +            qid.type =3D 0;
> > > +            qid.version =3D 0;
> > > +        }
> > >=20
> > >          /* 11 =3D 7 + 4 (7 =3D start offset, 4 =3D space for storing=
 count) */
> > >          len =3D pdu_marshal(pdu, 11 + count, "Qqbs",
> > >=20
> > > @@ -3672,8 +3807,13 @@ int v9fs_device_realize_common(V9fsState *s, c=
onst
> > > V9fsTransport *t,>=20
> > >          goto out;
> > >     =20
> > >      }
> > >=20
> > > +    s->root_ino =3D stat.st_ino;
> > >=20
> > >      s->dev_id =3D stat.st_dev;
> > >=20
> > > +    /* QID path hash table. 1 entry ought to be enough for anybody ;=
) */
> > > +    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE=
);
> > > +    s->qp_prefix_next =3D 1; /* reserve 0 to detect overflow */
> > > +
> > >=20
> > >      s->ctx.fst =3D &fse->fst;
> > >      fsdev_throttle_init(s->ctx.fst);
> > >=20
> > > @@ -3687,6 +3827,7 @@ out:
> > >          }
> > >          g_free(s->tag);
> > >          g_free(s->ctx.fs_root);
> > >=20
> > > +        qpp_table_destroy(&s->qpp_table);
> >=20
> > This causes QEMU to crash if we get there before qht_init() was called.
> > This should be guarded by a s->qpp_table.map !=3D NULL check.
>=20
> Touch=C3=A9.
>=20
> I'll add that to qp_table_destroy() for simplicity.
>=20
> > I've just posted a patch that simplifies error handling in this
> > function, you in Cc. The patch is also in 9p-next. Please rebase
> > on top of it.
>=20
> Ok.
> =20
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 9621e934c0..603e5e8e15 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -1335,17 +1335,17 @@ ETEXI
> > >=20
> > >  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
> > > =20
> > >      "-virtfs
> > >      local,path=3Dpath,mount_tag=3Dtag,security_model=3Dmapped-xattr|=
mapped-fil
> > >      e|passthrough|none\n">=20
> > > -    "      =20
> > > [,id=3Did][,writeout=3Dimmediate][,readonly][,fmode=3Dfmode][,dmode=
=3Ddmode]\n" -
> > >    "-virtfs
> > > proxy,mount_tag=3Dtag,socket=3Dsocket[,id=3Did][,writeout=3Dimmediate=
][,readonly]
> > > \n" -    "-virtfs
> > > proxy,mount_tag=3Dtag,sock_fd=3Dsock_fd[,id=3Did][,writeout=3Dimmedia=
te][,readonl
> > > y]\n" +    "      =20
> > > [,id=3Did][,writeout=3Dimmediate][,readonly][,fmode=3Dfmode][,dmode=
=3Ddmode][,mul
> > > tidevs=3Dremap|forbid|warn]\n" +    "-virtfs
> > > proxy,mount_tag=3Dtag,socket=3Dsocket[,id=3Did][,writeout=3Dimmediate=
][,readonly]
> > > [,multidevs=3Dremap|forbid|warn]\n" +    "-virtfs
> > > proxy,mount_tag=3Dtag,sock_fd=3Dsock_fd[,id=3Did][,writeout=3Dimmedia=
te][,readonl
> > > y][,multidevs=3Dremap|forbid|warn]\n"
> > Either enable support in "proxy" or don't update the "proxy" documentat=
ion
> > :)
>=20
> Then, if you don't mind, I'll just drop it from the proxy documentation, =
for=20
> the reasons I described above.
>=20

Agreed.

> > >      "-virtfs synth,mount_tag=3Dtag[,id=3Did][,readonly]\n",
> > >      QEMU_ARCH_ALL)
> > > =20
> > >  STEXI
> > >=20
> > > -@item -virtfs local,path=3D@var{path},mount_tag=3D@var{mount_tag}
> > > ,security_model=3D@var{security_model}[,writeout=3D@var{writeout}][,r=
eadonly]
> > > [,fmode=3D@var{fmode}][,dmode=3D@var{dmode}] -@itemx -virtfs
> > > proxy,socket=3D@var{socket},mount_tag=3D@var{mount_tag}
> > > [,writeout=3D@var{writeout}][,readonly] -@itemx -virtfs
> > > proxy,sock_fd=3D@var{sock_fd},mount_tag=3D@var{mount_tag}
> > > [,writeout=3D@var{writeout}][,readonly] +@item -virtfs
> > > local,path=3D@var{path},mount_tag=3D@var{mount_tag}
> > > ,security_model=3D@var{security_model}[,writeout=3D@var{writeout}][,r=
eadonly]
> > > [,fmode=3D@var{fmode}][,dmode=3D@var{dmode}][,multidevs=3D@var{multid=
evs}]
> > > +@itemx -virtfs proxy,socket=3D@var{socket},mount_tag=3D@var{mount_ta=
g}
> > > [,writeout=3D@var{writeout}][,readonly][,multidevs=3D@var{multidevs}]=
 +@itemx
> > > -virtfs proxy,sock_fd=3D@var{sock_fd},mount_tag=3D@var{mount_tag}
> > > [,writeout=3D@var{writeout}][,readonly][,multidevs=3D@var{multidevs}]
> > Ditto.
>=20
> Ack.
>=20
> > >  @itemx -virtfs synth,mount_tag=3D@var{mount_tag}
> > >  @findex -virtfs
> > >=20
> > > @@ -1399,6 +1399,27 @@ Specifies the default mode for newly created
> > > directories on the host. Works>=20
> > >  only with security models "mapped-xattr" and "mapped-file".
> > >  @item mount_tag=3D@var{mount_tag}
> > >  Specifies the tag name to be used by the guest to mount this export
> > >  point.
> > >=20
> > > +@item multidevs=3D@var{multidevs}
> > > +Specifies how to deal with multiple devices being shared with a 9p
> > > export.
> > > +Supported behaviours are either "remap", "forbid" or "warn". The lat=
ter
> > > is
> > > +the default behaviour on which virtfs 9p expects only one device to =
be
> > > +shared with the same export, and if more than one device is shared a=
nd
> > > +accessed via the same 9p export then only a warning message is logged
> > > +(once) by qemu on host side. In order to avoid file ID collisions on
> > > guest
> > > +you should either create a separate virtfs export for each device to=
 be
> > > +shared with guests (recommended way) or you might use "remap" instead
> > > which +allows you to share multiple devices with only one export inst=
ead,
> > > which is +achieved by remapping the original inode numbers from host =
to
> > > guest in a +way that would prevent such collisions. Remapping inodes =
in
> > > such use cases +is required because the original device IDs from host=
 are
> > > never passed and +exposed on guest. Instead all files of an export sh=
ared
> > > with virtfs always +share the same device id on guest. So two files w=
ith
> > > identical inode +numbers but from actually different devices on host
> > > would otherwise cause a +file ID collision and hence potential
> > > misbehaviours on guest. "forbid" on +the other hand assumes like "war=
n"
> > > that only one device is shared by the +same export, however it will n=
ot
> > > only log a warning message but also +deny access to additional device=
s on
> > > guest. Note though that "forbid" does +currently not block all possib=
le
> > > file access operations.
> >=20
> > Maybe provide a list of such operations that won't be blocked ?
>=20
> I feel punished for being so verbose. Okaaay. :)
>=20

:)

> >=20
> > >  @end table
> > >  ETEXI
> > >=20
> > > diff --git a/vl.c b/vl.c
> > > index b426b32134..9cb29b483d 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -3320,7 +3320,7 @@ int main(int argc, char **argv, char **envp)
> > >=20
> > >              case QEMU_OPTION_virtfs: {
> > >             =20
> > >                  QemuOpts *fsdev;
> > >                  QemuOpts *device;
> > >=20
> > > -                const char *writeout, *sock_fd, *socket, *path,
> > > *security_model; +                const char *writeout, *sock_fd,
> > > *socket, *path, *security_model, *multidevs;>=20
> > >                  olist =3D qemu_find_opts("virtfs");
> > >                  if (!olist) {
> > >=20
> > > @@ -3380,6 +3380,10 @@ int main(int argc, char **argv, char **envp)
> > >=20
> > >                  qemu_opt_set_bool(fsdev, "readonly",
> > >                 =20
> > >                                    qemu_opt_get_bool(opts, "readonly"=
, 0),
> > >                                    &error_abort);
> > >=20
> > > +                multidevs =3D qemu_opt_get(opts, "multidevs");
> > > +                if (multidevs) {
> > > +                    qemu_opt_set(fsdev, "multidevs", multidevs,
> > > &error_abort); +                }
> > >=20
> > >                  device =3D qemu_opts_create(qemu_find_opts("device")=
, NULL,
> > >                  0,
> > >                 =20
> > >                                            &error_abort);
> > >                 =20
> > >                  qemu_opt_set(device, "driver", "virtio-9p-pci",
> > >                  &error_abort);
>=20


