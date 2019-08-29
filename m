Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE450C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843EE2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843EE2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nts-0003Jz-7x
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3Ni1-0006x2-Bb
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3Nhy-0001oE-36
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:55:40 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:34981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3Nhx-0001nC-NO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:55:37 -0400
Received: from player688.ha.ovh.net (unknown [10.108.57.50])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 90B1367F42
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:55:35 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id B262892AC92F;
 Thu, 29 Aug 2019 16:55:29 +0000 (UTC)
Date: Thu, 29 Aug 2019 18:55:28 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190829185528.1db6607e@bahia.lan>
In-Reply-To: <50fc6fbbfd80c25d2ad1752fb945cdfc7d847f20.1566503584.git.qemu_oss@crudebyte.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <50fc6fbbfd80c25d2ad1752fb945cdfc7d847f20.1566503584.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 254171905459525952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeivddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.42.102
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 21:33:37 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> 'warn' (default): Only log an error message (once) on host if more than one
> device is shared by same export, except of that just ignore this config
> error though. This is the default behaviour for not breaking existing
> installations implying that they really know what they are doing.
> 
> 'forbid': Like 'warn', but except of just logging an error this
> also denies access of guest to additional devices.
> 
> 'remap': Allows to share more than one device per export by remapping
> inodes from host to guest appropriately. To support multiple devices on the
> 9p share, and avoid qid path collisions we take the device id as input to
> generate a unique QID path. The lowest 48 bits of the path will be set
> equal to the file inode, and the top bits will be uniquely assigned based
> on the top 16 bits of the inode and the device id.
> 
> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> [CS: - Rebased to https://github.com/gkurz/qemu/commits/9p-next
>        (SHA1 177fd3b6a8).
>      - Updated hash calls to new xxhash API.
>      - Added virtfs option 'multidevs', original patch simply did the inode
>        remapping without being asked.
>      - Updated docs for new option 'multidevs'.
>      - Capture root_ino in v9fs_device_realize_common() as well, not just
>        the device id.
>      - Fixed v9fs_do_readdir() not having remapped inodes.
>      - Log error message when running out of prefixes in
>        qid_path_prefixmap().
>      - Fixed definition of QPATH_INO_MASK.
>      - Dropped unnecessary parantheses in qpp_lookup_func().
>      - Dropped unnecessary g_malloc0() result checks. ]
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Looks good but needs some more polishing. See below.

>  fsdev/file-op-9p.h      |   5 ++
>  fsdev/qemu-fsdev-opts.c |   7 +-
>  fsdev/qemu-fsdev.c      |  11 +++
>  hw/9pfs/9p.c            | 182 ++++++++++++++++++++++++++++++++++++++++++------
>  hw/9pfs/9p.h            |  13 ++++
>  qemu-options.hx         |  33 +++++++--
>  vl.c                    |   6 +-
>  7 files changed, 229 insertions(+), 28 deletions(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index c757c8099f..f2f7772c86 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -59,6 +59,11 @@ typedef struct ExtendedOps {
>  #define V9FS_RDONLY                 0x00000040
>  #define V9FS_PROXY_SOCK_FD          0x00000080
>  #define V9FS_PROXY_SOCK_NAME        0x00000100
> +/*
> + * multidevs option (either one of the two applies exclusively)
> + */
> +#define V9FS_REMAP_INODES           0x00000200
> +#define V9FS_FORBID_MULTIDEVS       0x00000400
>  
>  #define V9FS_SEC_MASK               0x0000003C
>  
> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> index 7c31ffffaf..07a18c6e48 100644
> --- a/fsdev/qemu-fsdev-opts.c
> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -31,7 +31,9 @@ static QemuOptsList qemu_fsdev_opts = {
>          }, {
>              .name = "readonly",
>              .type = QEMU_OPT_BOOL,
> -
> +        }, {
> +            .name = "multidevs",
> +            .type = QEMU_OPT_STRING,
>          }, {
>              .name = "socket",
>              .type = QEMU_OPT_STRING,
> @@ -76,6 +78,9 @@ static QemuOptsList qemu_virtfs_opts = {
>              .name = "readonly",
>              .type = QEMU_OPT_BOOL,
>          }, {
> +            .name = "multidevs",
> +            .type = QEMU_OPT_STRING,
> +        }, {
>              .name = "socket",
>              .type = QEMU_OPT_STRING,
>          }, {
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 077a8c4e2b..ed03d559a9 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -58,6 +58,7 @@ static FsDriverTable FsDrivers[] = {
>              "writeout",
>              "fmode",
>              "dmode",
> +            "multidevs",

So we only allow this for the "local" backend. Any reason not to
add this to "proxy" as well ?

I didn't do it for the "throttling" options because it is a
feature I didn't care to support much, but "multidevs" is more
a fix than a fancy feature.

>              "throttling.bps-total",
>              "throttling.bps-read",
>              "throttling.bps-write",
> @@ -121,6 +122,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
>      const char *fsdev_id = qemu_opts_id(opts);
>      const char *fsdriver = qemu_opt_get(opts, "fsdriver");
>      const char *writeout = qemu_opt_get(opts, "writeout");
> +    const char *multidevs = qemu_opt_get(opts, "multidevs");
>      bool ro = qemu_opt_get_bool(opts, "readonly", 0);
>  
>      if (!fsdev_id) {
> @@ -161,6 +163,15 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
>      } else {
>          fsle->fse.export_flags &= ~V9FS_RDONLY;
>      }
> +    if (multidevs) {
> +        if (!strcmp(multidevs, "remap")) {
> +            fsle->fse.export_flags &= ~V9FS_FORBID_MULTIDEVS;
> +            fsle->fse.export_flags |= V9FS_REMAP_INODES;
> +        } else if (!strcmp(multidevs, "forbid")) {
> +            fsle->fse.export_flags &= ~V9FS_REMAP_INODES;
> +            fsle->fse.export_flags |= V9FS_FORBID_MULTIDEVS;
> +        }

And...

        } else if (!strcmp(multidevs, "warn")) {
            fsle->fse.export_flags &= ~V9FS_FORBID_MULTIDEVS;
            fsle->fse.export_flags &= ~V9FS_REMAP_INODES;
        } else {
            error_setg(errp, "invalid multidevs property '%s'", multidevs);
            return -1;
        }

... because we're a bit pedantic for command line options :)

> +    }
>  
>      if (fsle->fse.ops->parse_opts) {
>          if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 8cc65c2c67..c96ea51116 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -25,6 +25,7 @@
>  #include "trace.h"
>  #include "migration/blocker.h"
>  #include "sysemu/qtest.h"
> +#include "qemu/xxhash.h"
>  
>  int open_fd_hw;
>  int total_open_fd;
> @@ -571,22 +572,109 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
>                                  P9_STAT_MODE_NAMED_PIPE |   \
>                                  P9_STAT_MODE_SOCKET)
>  
> -/* This is the algorithm from ufs in spfs */
> +
> +/* creative abuse of tb_hash_func7, which is based on xxhash */
> +static uint32_t qpp_hash(QppEntry e)
> +{
> +    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
> +}
> +
> +static bool qpp_lookup_func(const void *obj, const void *userp)
> +{
> +    const QppEntry *e1 = obj, *e2 = userp;
> +    return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
> +}
> +
> +static void qpp_table_remove(void *p, uint32_t h, void *up)
> +{
> +    g_free(p);
> +}
> +
> +static void qpp_table_destroy(struct qht *ht)
> +{
> +    qht_iter(ht, qpp_table_remove, NULL);
> +    qht_destroy(ht);
> +}

Ok to have a function for this instead of open-coding but I'd
like to see qpp_table_init() for consistency.

> +
> +/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
> + * to a unique QID path (64 bits). To avoid having to map and keep track
> + * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
> + * the device id to the 16 highest bits of the QID path. The 48 lowest bits
> + * of the QID path equal to the lowest bits of the inode number.
> + *
> + * This takes advantage of the fact that inode number are usually not
> + * random but allocated sequentially, so we have fewer items to keep
> + * track of.
> + */
> +static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
> +                                uint64_t *path)
> +{
> +    QppEntry lookup = {
> +        .dev = stbuf->st_dev,
> +        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
> +    }, *val;
> +    uint32_t hash = qpp_hash(lookup);
> +
> +    val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
> +
> +    if (!val) {
> +        if (pdu->s->qp_prefix_next == 0) {
> +            /* we ran out of prefixes */
> +            error_report_once(
> +                "9p: No more prefixes available for remapping inodes from "
> +                "host to guest."
> +            );
> +            return -ENFILE;
> +        }
> +
> +        val = g_malloc0(sizeof(QppEntry));
> +        *val = lookup;
> +
> +        /* new unique inode prefix and device combo */
> +        val->qp_prefix = pdu->s->qp_prefix_next++;
> +        qht_insert(&pdu->s->qpp_table, val, hash, NULL);
> +    }
> +
> +    *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
> +    return 0;
> +}
> +
>  static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
>  {
> +    int err;
>      size_t size;
>  
> -    if (pdu->s->dev_id != stbuf->st_dev) {
> -        error_report_once(
> -            "9p: Multiple devices detected in same VirtFS export. "
> -            "You must use a separate export for each device."
> -        );
> -        return -ENODEV;
> +    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> +        /* map inode+device to qid path (fast path) */
> +        err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
> +        if (err) {
> +            return err;
> +        }
> +    } else {
> +        if (pdu->s->dev_id != stbuf->st_dev) {
> +            if (pdu->s->ctx.export_flags & V9FS_FORBID_MULTIDEVS) {
> +                error_report_once(
> +                    "9p: Multiple devices detected in same VirtFS export. "
> +                    "Access of guest to additional devices is (partly) "
> +                    "denied due to virtfs option 'multidevs=forbid' being "
> +                    "effective."
> +                );
> +                return -ENODEV;
> +            } else {
> +                error_report_once(

Please use warn_report_once().

> +                    "9p: Multiple devices detected in same VirtFS export, "
> +                    "which might lead to file ID collisions and severe "
> +                    "misbehaviours on guest! You should either use a "
> +                    "separate export for each device shared from host or "
> +                    "use virtfs option 'multidevs=remap'!"
> +                );
> +            }
> +        }
> +        memset(&qidp->path, 0, sizeof(qidp->path));
> +        size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
> +        memcpy(&qidp->path, &stbuf->st_ino, size);
>      }
>  
> -    memset(&qidp->path, 0, sizeof(qidp->path));
> -    size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
> -    memcpy(&qidp->path, &stbuf->st_ino, size);
>      qidp->version = stbuf->st_mtime ^ (stbuf->st_size << 8);
>      qidp->type = 0;
>      if (S_ISDIR(stbuf->st_mode)) {
> @@ -616,6 +704,30 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
>      return 0;
>  }
>  
> +static int coroutine_fn dirent_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
> +                                      struct dirent *dent, V9fsQID *qidp)
> +{
> +    struct stat stbuf;
> +    V9fsPath path;
> +    int err;
> +
> +    v9fs_path_init(&path);
> +
> +    err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
> +    if (err < 0) {
> +        goto out;
> +    }
> +    err = v9fs_co_lstat(pdu, &path, &stbuf);
> +    if (err < 0) {
> +        goto out;
> +    }
> +    err = stat_to_qid(pdu, &stbuf, qidp);
> +
> +out:
> +    v9fs_path_free(&path);
> +    return err;
> +}
> +
>  V9fsPDU *pdu_alloc(V9fsState *s)
>  {
>      V9fsPDU *pdu = NULL;
> @@ -1964,16 +2076,39 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>              v9fs_string_free(&name);
>              return count;
>          }
> -        /*
> -         * Fill up just the path field of qid because the client uses
> -         * only that. To fill the entire qid structure we will have
> -         * to stat each dirent found, which is expensive
> -         */
> -        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
> -        memcpy(&qid.path, &dent->d_ino, size);
> -        /* Fill the other fields with dummy values */
> -        qid.type = 0;
> -        qid.version = 0;
> +
> +        if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> +            /*
> +             * dirent_to_qid() implies expensive stat call for each entry,
> +             * we must do that here though since inode remapping requires
> +             * the device id, which in turn might be different for
> +             * different entries; we cannot make any assumption to avoid
> +             * that here.
> +             */
> +            err = dirent_to_qid(pdu, fidp, dent, &qid);
> +            if (err < 0) {
> +                v9fs_readdir_unlock(&fidp->fs.dir);
> +                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> +                v9fs_string_free(&name);
> +                return err;
> +            }
> +        } else {
> +            /*
> +             * Fill up just the path field of qid because the client uses
> +             * only that. To fill the entire qid structure we will have
> +             * to stat each dirent found, which is expensive. For the
> +             * latter reason we don't call dirent_to_qid() here. Only drawback
> +             * is that no multi-device export detection of stat_to_qid()
> +             * would be done and provided as error to the user here. But
> +             * user would get that error anyway when accessing those
> +             * files/dirs through other ways.
> +             */
> +            size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
> +            memcpy(&qid.path, &dent->d_ino, size);
> +            /* Fill the other fields with dummy values */
> +            qid.type = 0;
> +            qid.version = 0;
> +        }
>  
>          /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>          len = pdu_marshal(pdu, 11 + count, "Qqbs",
> @@ -3672,8 +3807,13 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>          goto out;
>      }
>  
> +    s->root_ino = stat.st_ino;
>      s->dev_id = stat.st_dev;
>  
> +    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
> +    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
> +    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
> +
>      s->ctx.fst = &fse->fst;
>      fsdev_throttle_init(s->ctx.fst);
>  
> @@ -3687,6 +3827,7 @@ out:
>          }
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
> +        qpp_table_destroy(&s->qpp_table);

This causes QEMU to crash if we get there before qht_init() was called.
This should be guarded by a s->qpp_table.map != NULL check.

I've just posted a patch that simplifies error handling in this
function, you in Cc. The patch is also in 9p-next. Please rebase
on top of it.

>          v9fs_path_free(&path);
>      }
>      return rc;
> @@ -3699,6 +3840,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
>      }
>      fsdev_throttle_cleanup(s->ctx.fst);
>      g_free(s->tag);
> +    qpp_table_destroy(&s->qpp_table);
>      g_free(s->ctx.fs_root);
>  }
>  
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 5e316178d5..a283b0193e 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -8,6 +8,7 @@
>  #include "fsdev/9p-iov-marshal.h"
>  #include "qemu/thread.h"
>  #include "qemu/coroutine.h"
> +#include "qemu/qht.h"
>  
>  enum {
>      P9_TLERROR = 6,
> @@ -235,6 +236,15 @@ struct V9fsFidState
>      V9fsFidState *rclm_lst;
>  };
>  
> +#define QPATH_INO_MASK        ((1ULL << 48) - 1)
> +
> +/* QID path prefix entry, see stat_to_qid */
> +typedef struct {
> +    dev_t dev;
> +    uint16_t ino_prefix;
> +    uint16_t qp_prefix;
> +} QppEntry;
> +
>  struct V9fsState
>  {
>      QLIST_HEAD(, V9fsPDU) free_list;
> @@ -256,7 +266,10 @@ struct V9fsState
>      Error *migration_blocker;
>      V9fsConf fsconf;
>      V9fsQID root_qid;
> +    ino_t root_ino;
>      dev_t dev_id;
> +    struct qht qpp_table;
> +    uint16_t qp_prefix_next;
>  };
>  
>  /* 9p2000.L open flags */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..603e5e8e15 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1335,17 +1335,17 @@ ETEXI
>  
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>      "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
> -    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
> -    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
> -    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
> +    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode][,multidevs=remap|forbid|warn]\n"
> +    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly][,multidevs=remap|forbid|warn]\n"
> +    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly][,multidevs=remap|forbid|warn]\n"

Either enable support in "proxy" or don't update the "proxy" documentation :)

>      "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
>      QEMU_ARCH_ALL)
>  
>  STEXI
>  
> -@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}]
> -@itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
> -@itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
> +@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}][,multidevs=@var{multidevs}]
> +@itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly][,multidevs=@var{multidevs}]
> +@itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly][,multidevs=@var{multidevs}]

Ditto.

>  @itemx -virtfs synth,mount_tag=@var{mount_tag}
>  @findex -virtfs
>  
> @@ -1399,6 +1399,27 @@ Specifies the default mode for newly created directories on the host. Works
>  only with security models "mapped-xattr" and "mapped-file".
>  @item mount_tag=@var{mount_tag}
>  Specifies the tag name to be used by the guest to mount this export point.
> +@item multidevs=@var{multidevs}
> +Specifies how to deal with multiple devices being shared with a 9p export.
> +Supported behaviours are either "remap", "forbid" or "warn". The latter is
> +the default behaviour on which virtfs 9p expects only one device to be
> +shared with the same export, and if more than one device is shared and
> +accessed via the same 9p export then only a warning message is logged
> +(once) by qemu on host side. In order to avoid file ID collisions on guest
> +you should either create a separate virtfs export for each device to be
> +shared with guests (recommended way) or you might use "remap" instead which
> +allows you to share multiple devices with only one export instead, which is
> +achieved by remapping the original inode numbers from host to guest in a
> +way that would prevent such collisions. Remapping inodes in such use cases
> +is required because the original device IDs from host are never passed and
> +exposed on guest. Instead all files of an export shared with virtfs always
> +share the same device id on guest. So two files with identical inode
> +numbers but from actually different devices on host would otherwise cause a
> +file ID collision and hence potential misbehaviours on guest. "forbid" on
> +the other hand assumes like "warn" that only one device is shared by the
> +same export, however it will not only log a warning message but also
> +deny access to additional devices on guest. Note though that "forbid" does
> +currently not block all possible file access operations.

Maybe provide a list of such operations that won't be blocked ?

>  @end table
>  ETEXI
>  
> diff --git a/vl.c b/vl.c
> index b426b32134..9cb29b483d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3320,7 +3320,7 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_virtfs: {
>                  QemuOpts *fsdev;
>                  QemuOpts *device;
> -                const char *writeout, *sock_fd, *socket, *path, *security_model;
> +                const char *writeout, *sock_fd, *socket, *path, *security_model, *multidevs;
>  
>                  olist = qemu_find_opts("virtfs");
>                  if (!olist) {
> @@ -3380,6 +3380,10 @@ int main(int argc, char **argv, char **envp)
>                  qemu_opt_set_bool(fsdev, "readonly",
>                                    qemu_opt_get_bool(opts, "readonly", 0),
>                                    &error_abort);
> +                multidevs = qemu_opt_get(opts, "multidevs");
> +                if (multidevs) {
> +                    qemu_opt_set(fsdev, "multidevs", multidevs, &error_abort);
> +                }
>                  device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
>                                            &error_abort);
>                  qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);


