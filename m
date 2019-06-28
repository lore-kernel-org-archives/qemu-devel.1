Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58990C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F22620665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F22620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnqP-0007ds-1R
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgnp8-00070r-PF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgnp6-0004dt-I9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:09:42 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:40841)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgnp6-0004Zt-83
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:09:40 -0400
Received: from player714.ha.ovh.net (unknown [10.109.160.217])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5B0D11D423A
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 12:09:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 409DB7497C59;
 Fri, 28 Jun 2019 10:09:33 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:09:31 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190628120931.2d31f741@bahia.lan>
In-Reply-To: <91b9f8920735847e6c0e84ab6dc2c689aed13cc7.1561575449.git.qemu_oss@crudebyte.com>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <91b9f8920735847e6c0e84ab6dc2c689aed13cc7.1561575449.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16672325824112335168
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.38.119
Subject: Re: [Qemu-devel] [PATCH v4 3/5] 9p: Added virtfs option
 "remap_inodes"
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 20:42:13 +0200
Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:

> To support multiple devices on the 9p share, and avoid
> qid path collisions we take the device id as input
> to generate a unique QID path. The lowest 48 bits of
> the path will be set equal to the file inode, and the
> top bits will be uniquely assigned based on the top
> 16 bits of the inode and the device id.
>=20
> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>

Same remark about changes to the original patch.

BTW, I had a concern with the way v9fs_do_readdir() open-codes QID
generation without calling stat_to_qid().

See discussion here:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02724.html

I guess you should ensure in a preliminary patch that QIDs only
come out of stat_to_qid().

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  fsdev/file-op-9p.h      |   1 +
>  fsdev/qemu-fsdev-opts.c |   7 +++-
>  fsdev/qemu-fsdev.c      |   6 +++
>  hw/9pfs/9p.c            | 105 ++++++++++++++++++++++++++++++++++++++++++=
------
>  hw/9pfs/9p.h            |  12 ++++++
>  qemu-options.hx         |  17 +++++++-
>  vl.c                    |   3 ++
>  7 files changed, 135 insertions(+), 16 deletions(-)
>=20
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index c757c8099f..6c1663c252 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -59,6 +59,7 @@ typedef struct ExtendedOps {
>  #define V9FS_RDONLY                 0x00000040
>  #define V9FS_PROXY_SOCK_FD          0x00000080
>  #define V9FS_PROXY_SOCK_NAME        0x00000100
> +#define V9FS_REMAP_INODES           0x00000200
> =20
>  #define V9FS_SEC_MASK               0x0000003C
> =20
> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> index 7c31ffffaf..64a8052266 100644
> --- a/fsdev/qemu-fsdev-opts.c
> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -31,7 +31,9 @@ static QemuOptsList qemu_fsdev_opts =3D {
>          }, {
>              .name =3D "readonly",
>              .type =3D QEMU_OPT_BOOL,
> -
> +        }, {
> +            .name =3D "remap_inodes",
> +            .type =3D QEMU_OPT_BOOL,
>          }, {
>              .name =3D "socket",
>              .type =3D QEMU_OPT_STRING,
> @@ -76,6 +78,9 @@ static QemuOptsList qemu_virtfs_opts =3D {
>              .name =3D "readonly",
>              .type =3D QEMU_OPT_BOOL,
>          }, {
> +            .name =3D "remap_inodes",
> +            .type =3D QEMU_OPT_BOOL,
> +        }, {
>              .name =3D "socket",
>              .type =3D QEMU_OPT_STRING,
>          }, {
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 077a8c4e2b..b6fa9799be 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -121,6 +121,7 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
>      const char *fsdev_id =3D qemu_opts_id(opts);
>      const char *fsdriver =3D qemu_opt_get(opts, "fsdriver");
>      const char *writeout =3D qemu_opt_get(opts, "writeout");
> +    bool remap_inodes =3D qemu_opt_get_bool(opts, "remap_inodes", 0);
>      bool ro =3D qemu_opt_get_bool(opts, "readonly", 0);
> =20
>      if (!fsdev_id) {
> @@ -161,6 +162,11 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
>      } else {
>          fsle->fse.export_flags &=3D ~V9FS_RDONLY;
>      }
> +    if (remap_inodes) {
> +        fsle->fse.export_flags |=3D V9FS_REMAP_INODES;
> +    } else {
> +        fsle->fse.export_flags &=3D ~V9FS_REMAP_INODES;
> +    }
> =20
>      if (fsle->fse.ops->parse_opts) {
>          if (fsle->fse.ops->parse_opts(opts, &fsle->fse, errp)) {
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index cbaa212625..7ccc68a829 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -25,6 +25,7 @@
>  #include "trace.h"
>  #include "migration/blocker.h"
>  #include "sysemu/qtest.h"
> +#include "qemu/xxhash.h"
> =20
>  int open_fd_hw;
>  int total_open_fd;
> @@ -571,24 +572,96 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
>                                  P9_STAT_MODE_NAMED_PIPE |   \
>                                  P9_STAT_MODE_SOCKET)
> =20
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
> +    const QppEntry *e1 =3D obj, *e2 =3D userp;
> +    return e1->dev =3D=3D e2->dev && e1->ino_prefix =3D=3D e2->ino_prefi=
x;
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
> +
> +/* stat_to_qid needs to map inode number (64 bits) and device id (32 bit=
s)
> + * to a unique QID path (64 bits). To avoid having to map and keep track
> + * of up to 2^64 objects, we map only the 16 highest bits of the inode p=
lus
> + * the device id to the 16 highest bits of the QID path. The 48 lowest b=
its
> + * of the QID path equal to the lowest bits of the inode number.
> + *
> + * This takes advantage of the fact that inode number are usually not
> + * random but allocated sequentially, so we have fewer items to keep
> + * track of.
> + */
> +static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
> +                                uint64_t *path)
> +{
> +    QppEntry lookup =3D {
> +        .dev =3D stbuf->st_dev,
> +        .ino_prefix =3D (uint16_t) (stbuf->st_ino >> 48)
> +    }, *val;
> +    uint32_t hash =3D qpp_hash(lookup);
> +
> +    val =3D qht_lookup(&pdu->s->qpp_table, &lookup, hash);
> +
> +    if (!val) {
> +        if (pdu->s->qp_prefix_next =3D=3D 0) {
> +            /* we ran out of prefixes */

And we won't ever be able to allocate a new one. Maybe worth
adding an error_report_once() to inform the user ?

> +            return -ENFILE;
> +        }
> +
> +        val =3D g_malloc0(sizeof(QppEntry));
> +        *val =3D lookup;
> +
> +        /* new unique inode prefix and device combo */
> +        val->qp_prefix =3D pdu->s->qp_prefix_next++;
> +        qht_insert(&pdu->s->qpp_table, val, hash, NULL);
> +    }
> +
> +    *path =3D ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_=
INO_MASK);
> +    return 0;
> +}
> +
>  static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *=
qidp)
>  {
> -    size_t size;
> +    int err;
> =20
> -    if (pdu->s->dev_id =3D=3D 0) {
> -        pdu->s->dev_id =3D stbuf->st_dev;
> -    } else if (pdu->s->dev_id !=3D stbuf->st_dev) {
> -        error_report_once(
> -            "9p: Multiple devices detected in same VirtFS export. "
> -            "You must use a separate export for each device."
> -        );
> -        return -ENOSYS;
> +    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> +        /* map inode+device to qid path (fast path) */
> +        err =3D qid_path_prefixmap(pdu, stbuf, &qidp->path);
> +        if (err) {
> +            return err;
> +        }
> +    } else {
> +        if (pdu->s->dev_id =3D=3D 0) {
> +            pdu->s->dev_id =3D stbuf->st_dev;
> +        } else if (pdu->s->dev_id !=3D stbuf->st_dev) {
> +            error_report_once(
> +                "9p: Multiple devices detected in same VirtFS export. "
> +                "You must either use a separate export for each device "
> +                "shared from host or enable virtfs option 'remap_inodes'=
."
> +            );
> +            return -ENOSYS;
> +        }
> +        size_t size;

=46rom CODING_STYLE:

5. Declarations

Mixed declarations (interleaving statements and declarations within
blocks) are generally not allowed; declarations should be at the beginning
of blocks.

Please do so for "size" and add an extra blank line.

> +        memset(&qidp->path, 0, sizeof(qidp->path));
> +        size =3D MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
> +        memcpy(&qidp->path, &stbuf->st_ino, size);
>      }
> =20
> -    memset(&qidp->path, 0, sizeof(qidp->path));
> -    size =3D MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
> -    memcpy(&qidp->path, &stbuf->st_ino, size);
>      qidp->version =3D stbuf->st_mtime ^ (stbuf->st_size << 8);
>      qidp->type =3D 0;
>      if (S_ISDIR(stbuf->st_mode)) {
> @@ -3676,6 +3749,10 @@ int v9fs_device_realize_common(V9fsState *s, const=
 V9fsTransport *t,
> =20
>      s->dev_id =3D 0;
> =20
> +    /* QID path hash table. 1 entry ought to be enough for anybody ;) */
> +    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
> +    s->qp_prefix_next =3D 1; /* reserve 0 to detect overflow */
> +
>      s->ctx.fst =3D &fse->fst;
>      fsdev_throttle_init(s->ctx.fst);
> =20
> @@ -3689,6 +3766,7 @@ out:
>          }
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
> +        qpp_table_destroy(&s->qpp_table);
>          v9fs_path_free(&path);
>      }
>      return rc;
> @@ -3701,6 +3779,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Err=
or **errp)
>      }
>      fsdev_throttle_cleanup(s->ctx.fst);
>      g_free(s->tag);
> +    qpp_table_destroy(&s->qpp_table);
>      g_free(s->ctx.fs_root);
>  }
> =20
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 5e316178d5..0200e04176 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -8,6 +8,7 @@
>  #include "fsdev/9p-iov-marshal.h"
>  #include "qemu/thread.h"
>  #include "qemu/coroutine.h"
> +#include "qemu/qht.h"
> =20
>  enum {
>      P9_TLERROR =3D 6,
> @@ -235,6 +236,15 @@ struct V9fsFidState
>      V9fsFidState *rclm_lst;
>  };
> =20
> +#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)

This won't give the expected result on a 32-bit host. Since this
is a mask for 64-bit entities, it should rather be:

#define QPATH_INO_MASK        ((1ULL << 48) - 1)

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
> @@ -257,6 +267,8 @@ struct V9fsState
>      V9fsConf fsconf;
>      V9fsQID root_qid;
>      dev_t dev_id;
> +    struct qht qpp_table;
> +    uint16_t qp_prefix_next;
>  };
> =20
>  /* 9p2000.L open flags */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0d8beb4afd..e7ea136da1 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1334,7 +1334,7 @@ ETEXI
> =20
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>      "-virtfs local,path=3Dpath,mount_tag=3Dtag,security_model=3Dmapped-x=
attr|mapped-file|passthrough|none\n"
> -    "        [,id=3Did][,writeout=3Dimmediate][,readonly][,fmode=3Dfmode=
][,dmode=3Ddmode]\n"
> +    "        [,id=3Did][,writeout=3Dimmediate][,readonly][,fmode=3Dfmode=
][,dmode=3Ddmode][,remap_inodes]\n"

This feature applies to all backends IIUC. We don't really care for the
synth backend since it generates non-colliding inode numbers by design,
but the proxy backend has the same issue as local. So...

>      "-virtfs proxy,mount_tag=3Dtag,socket=3Dsocket[,id=3Did][,writeout=
=3Dimmediate][,readonly]\n"
>      "-virtfs proxy,mount_tag=3Dtag,sock_fd=3Dsock_fd[,id=3Did][,writeout=
=3Dimmediate][,readonly]\n"

... please update these two ^^ as well.

>      "-virtfs synth,mount_tag=3Dtag[,id=3Did][,readonly]\n",
> @@ -1342,7 +1342,7 @@ DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
> =20
>  STEXI
> =20
> -@item -virtfs local,path=3D@var{path},mount_tag=3D@var{mount_tag} ,secur=
ity_model=3D@var{security_model}[,writeout=3D@var{writeout}][,readonly] [,f=
mode=3D@var{fmode}][,dmode=3D@var{dmode}]
> +@item -virtfs local,path=3D@var{path},mount_tag=3D@var{mount_tag} ,secur=
ity_model=3D@var{security_model}[,writeout=3D@var{writeout}][,readonly] [,f=
mode=3D@var{fmode}][,dmode=3D@var{dmode}][,remap_inodes]
>  @itemx -virtfs proxy,socket=3D@var{socket},mount_tag=3D@var{mount_tag} [=
,writeout=3D@var{writeout}][,readonly]
>  @itemx -virtfs proxy,sock_fd=3D@var{sock_fd},mount_tag=3D@var{mount_tag}=
 [,writeout=3D@var{writeout}][,readonly]

Ditto.

>  @itemx -virtfs synth,mount_tag=3D@var{mount_tag}
> @@ -1398,6 +1398,19 @@ Specifies the default mode for newly created direc=
tories on the host. Works
>  only with security models "mapped-xattr" and "mapped-file".
>  @item mount_tag=3D@var{mount_tag}
>  Specifies the tag name to be used by the guest to mount this export poin=
t.
> +@item remap_inodes
> +By default virtfs 9p supports only one device per export in order to avo=
id
> +file ID collisions on guest which may otherwise happen because the origi=
nal
> +device IDs from host are not passed and exposed on guest. Instead all fi=
les
> +of an export shared with virtfs do have the same device id on guest. So =
two
> +files with identical inode numbers but from actually different devices on
> +host would otherwise cause a file ID collision and hence potential
> +misbehaviours on guest. For that reason it is recommended to create a
> +separate virtfs export for each device to be shared with guests. However
> +you may also enable "remap_inodes" which allows you to share multiple
> +devices with only one export instead, which is achieved by remapping the
> +original inode numbers from host to guest in a way that would prevent su=
ch
> +collisions.
>  @end table
>  ETEXI
> =20
> diff --git a/vl.c b/vl.c
> index 99a56b5556..de9d7b846c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3457,6 +3457,9 @@ int main(int argc, char **argv, char **envp)
>                  qemu_opt_set_bool(fsdev, "readonly",
>                                    qemu_opt_get_bool(opts, "readonly", 0),
>                                    &error_abort);
> +                qemu_opt_set_bool(fsdev, "remap_inodes",
> +                                  qemu_opt_get_bool(opts, "remap_inodes"=
, 0),
> +                                  &error_abort);
>                  device =3D qemu_opts_create(qemu_find_opts("device"), NU=
LL, 0,
>                                            &error_abort);
>                  qemu_opt_set(device, "driver", "virtio-9p-pci", &error_a=
bort);


