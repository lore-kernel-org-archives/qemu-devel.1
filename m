Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692EC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8FD204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8FD204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwci-0006CM-T0
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:42:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwbx-0005tJ-1n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwbv-0007uq-1B
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:42:09 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:56033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNwbu-0007tu-OW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:42:06 -0400
Received: from player698.ha.ovh.net (unknown [10.108.57.141])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5E4801E7793
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 11:42:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id 9E459579B33D;
	Tue,  7 May 2019 09:42:01 +0000 (UTC)
Date: Tue, 7 May 2019 11:41:58 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190507114158.7e0130b8@bahia.lan>
In-Reply-To: <2658428.sN558u4hSW@silver>
References: <cover.1556896526.git.qemu_oss@crudebyte.com>
	<2658428.sN558u4hSW@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5975150806934853952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkedtgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.176
Subject: Re: [Qemu-devel] [PATCH v2 3/4] 9p: persistency of QID path beyond
 reboots / suspensions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 03 May 2019 18:23:03 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This patch aims to keep QID path identical beyond the scope of reboots and
> guest suspensions. With the 1st patch alone the QID path of the same files
> might change after reboots / suspensions, since 9p would restart with
> empty qpp_table and the resulting QID path depends on the precise sequence
> of files being accessed on guest.
> 
> The first patch should already avoid the vast majority of potential QID
> path collisions. However especially network services running on guest
> would still be prone to QID path issues when just using the 1st patch.
> For instance Samba is exporting file IDs to clients in the network and
> SMB cliens in the network will use those IDs to access and request
> changes on the file server. If guest is now interrupted in between, like
> it commonly happens on maintenance, e.g. software updates on host, then
> SMB clients in the network will continue working with old file IDs, which
> in turn leads to data corruption and data loss on the file server.
> Furthermore on SMB client side I also encountered severe misbehaviours in
> this case, for instance Macs accessing the file server would either
> start to hang or die with a kernel panic within seconds, since the smbx
> implementation on macOS heavily relies on file IDs being unique (within
> the context of a connection that is).
> 
> So this patch here mitigates the remaining problem described above by
> storing the qpp_table persistently as extended attribute(s) on the
> exported root of the file system and automatically tries to restore the
> qpp_table i.e. after reboots / resumptions.
> 
> This patch is aimed at real world scenarios, in which qpp_table will only
> ever get few dozens of entries (and none ever in qpf_table). So it is e.g.
> intentionally limited to only store qpp_table, not qpf_table; and so far
> I have not made optimizations, since in practice the qpf_table is really
> just tiny.
> 
> Since there is currently no callback in qemu yet that would reliably be
> called on guest shutdowns, the table is stored on every new insertion for
> now.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 315 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/9pfs/9p.h |  33 +++++++
>  2 files changed, 343 insertions(+), 5 deletions(-)
> 

Yikes... both the changelog and the diffstat have an impressive size. Since
I'm likely the only QEMU developer who will review this, please expect some
delay before I get down to it... :-\ Of course, if you can split this into
smaller patches, it will probably help :)

Same remark for patch 4.

> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 2b893e25a1..29c6dfc68a 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -26,6 +26,19 @@
>  #include "migration/blocker.h"
>  #include "sysemu/qtest.h"
>  #include "qemu/xxhash.h"
> +#include "qemu/crc32c.h"
> +#if defined(__linux__) /* TODO: This should probably go into osdep.h instead */
> +# include <linux/limits.h> /* for XATTR_SIZE_MAX */
> +#endif
> +
> +/*
> + * How many bytes may we store to fs per extended attribute value?
> + */
> +#ifdef XATTR_SIZE_MAX
> +# define ATTR_MAX_SIZE XATTR_SIZE_MAX /* Linux only: 64kB limit in kernel */
> +#else
> +# define ATTR_MAX_SIZE 65536 /* Most systems allow a bit more, so we take this as basis.  */
> +#endif
>  
>  int open_fd_hw;
>  int total_open_fd;
> @@ -642,6 +655,285 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
>      return 0;
>  }
>  
> +static inline bool is_ro_export(FsContext *ctx)
> +{
> +    return ctx->export_flags & V9FS_RDONLY;
> +}
> +
> +/*
> + * Once qpp_table size exceeds this value, we no longer save
> + * the table persistently. See comment in v9fs_store_qpp_table()
> + */
> +#define QPP_TABLE_PERSISTENCY_LIMIT 32768
> +
> +/* Remove all user.virtfs.system.qidp.* xattrs from export root. */
> +static void remove_qidp_xattr(FsContext *ctx)
> +{
> +    V9fsString name;
> +    int i;
> +
> +    /* just for a paranoid endless recursion sanity check */
> +    const ssize_t max_size =
> +        sizeof(QppSrlzHeader) +
> +        QPP_TABLE_PERSISTENCY_LIMIT * sizeof(QppEntryS);
> +
> +    v9fs_string_init(&name);
> +    for (i = 0; i * ATTR_MAX_SIZE < max_size; ++i) {
> +        v9fs_string_sprintf(&name, "user.virtfs.system.qidp.%d", i);
> +        if (lremovexattr(ctx->fs_root, name.data) < 0)
> +            break;
> +    }
> +    v9fs_string_free(&name);
> +}
> +
> +/* Used to convert qpp hash table into continuous stream. */
> +static void qpp_table_serialize(void *p, uint32_t h, void *up)
> +{
> +    const QppEntry *entry = (const QppEntry*) p;
> +    QppSerialize *ser = (QppSerialize*) up;
> +
> +    if (ser->error)
> +        return;
> +
> +    /* safety first */
> +    if (entry->qp_prefix - 1 >= ser->count) {
> +        ser->error = -1;
> +        return;
> +    }
> +
> +    ser->elements[entry->qp_prefix - 1] = (QppEntryS) {
> +        .dev = entry->dev,
> +        .ino_prefix = entry->ino_prefix
> +    };
> +    ser->done++;
> +}
> +
> +/*
> + * Tries to store the current qpp_table as extended attribute(s) on the
> + * exported file system root with the goal to preserve identical qids
> + * beyond the scope of reboots.
> + */
> +static void v9fs_store_qpp_table(V9fsState *s)
> +{
> +    FsContext *ctx = &s->ctx;
> +    V9fsString name;
> +    int i, res;
> +    size_t size;
> +    QppSrlzStream* stream;
> +    QppSerialize ser;
> +
> +    if (is_ro_export(ctx))
> +        return;
> +
> +    /*
> +     * Whenever we exceeded some certain (arbitrary) high qpp_table size we
> +     * delete the stored table from the file system to get rid of old device
> +     * ids / inodes that might no longer exist with the goal to potentially
> +     * yield in a smaller table size after next reboot.
> +     */
> +    if (!s->qp_prefix_next || s->qp_prefix_next >= QPP_TABLE_PERSISTENCY_LIMIT) {
> +        if (s->qp_prefix_next == QPP_TABLE_PERSISTENCY_LIMIT) {
> +            remove_qidp_xattr(ctx);
> +        }
> +        return;
> +    }
> +
> +    /* Convert qpp hash table into continuous array. */
> +    size = sizeof(QppSrlzHeader) +
> +           ( (s->qp_prefix_next - 1) /* qpp_table entry count */ * sizeof(QppEntryS) );
> +    stream = g_malloc0(size);
> +    ser = (QppSerialize) {
> +        .elements = &stream->elements[0],
> +        .count = s->qp_prefix_next - 1,
> +        .done  = 0,
> +        .error = 0,
> +    };
> +    qht_iter(&s->qpp_table, qpp_table_serialize, &ser);
> +    if (ser.error || ser.done != ser.count)
> +        goto out;
> +
> +    /* initialize header and calculate CRC32 checksum */
> +    stream->header = (QppSrlzHeader) {
> +        .version = 1,
> +        .reserved = 0,
> +        .crc32 = crc32c(
> +            0xffffffff,
> +            (const uint8_t*) &stream->elements[0],
> +            (ser.count * sizeof(QppEntryS))
> +        ),
> +    };
> +
> +    /*
> +     * Actually just required if the qpp_table size decreased, or if the
> +     * previous xattr size limit increased on OS (kernel/fs) level.
> +     */
> +    remove_qidp_xattr(ctx);
> +
> +    /*
> +     * Subdivide (if required) the data stream into individual xattrs
> +     * to cope with the system's max. supported xattr value size.
> +     */
> +    v9fs_string_init(&name);
> +    for (i = 0; size > (i * ATTR_MAX_SIZE); ++i) {
> +        v9fs_string_sprintf(&name, "user.virtfs.system.qidp.%d", i);
> +        res = lsetxattr(
> +            ctx->fs_root,
> +            name.data,
> +            ((const uint8_t*)stream) + i * ATTR_MAX_SIZE,
> +            MIN(ATTR_MAX_SIZE, size - i * ATTR_MAX_SIZE),
> +            0/*flags*/
> +        );
> +        if (res < 0) {
> +            if (i > 0)
> +                remove_qidp_xattr(ctx);
> +            break;
> +        }
> +    }
> +    v9fs_string_free(&name);
> +out:
> +    g_free(stream);
> +}
> +
> +/* Frees the entire chain of passed nodes from memory. */
> +static void destroy_xattr_nodes(XAttrNode **first)
> +{
> +    XAttrNode *prev;
> +    if (!first)
> +        return;
> +    while (*first) {
> +        if ((*first)->value)
> +            g_free((*first)->value);
> +        prev = *first;
> +        *first = (*first)->next;
> +        g_free(prev);
> +    }
> +}
> +
> +/*
> + * Loads all user.virtfs.system.qidp.* xattrs from exported fs root and
> + * returns a linked list with one node per xattr.
> + */
> +static XAttrNode* v9fs_load_qidp_xattr_nodes(V9fsState *s)
> +{
> +    FsContext *ctx = &s->ctx;
> +    XAttrNode *first = NULL, *current = NULL;
> +    V9fsString name;
> +    ssize_t size;
> +    int i;
> +
> +    const ssize_t max_size =
> +        sizeof(QppSrlzHeader) +
> +        QPP_TABLE_PERSISTENCY_LIMIT * sizeof(QppEntryS);
> +
> +    v9fs_string_init(&name);
> +
> +    for (i = 0; i * ATTR_MAX_SIZE < max_size; ++i) {
> +        v9fs_string_sprintf(&name, "user.virtfs.system.qidp.%d", i);
> +        size = lgetxattr(ctx->fs_root, name.data, NULL, 0);
> +        if (size <= 0)
> +            break;
> +        if (!first) {
> +            first = current = g_malloc0(sizeof(XAttrNode));
> +        } else {
> +            current = current->next = g_malloc0(sizeof(XAttrNode));
> +        }
> +        current->value = g_malloc0(size);
> +        current->length = lgetxattr(
> +            ctx->fs_root, name.data, current->value, size
> +        );
> +        if (current->length <= 0) {
> +            goto out_w_err;
> +        }
> +    }
> +    goto out;
> +
> +out_w_err:
> +    destroy_xattr_nodes(&first);
> +out:
> +    v9fs_string_free(&name);
> +    return first;
> +}
> +
> +/*
> + * Try to load previously stored qpp_table from file system. Calling this
> + * function assumes that qpp_table is yet empty.
> + *
> + * @see v9fs_store_qpp_table()
> + */
> +static void v9fs_load_qpp_table(V9fsState *s)
> +{
> +    ssize_t size, count;
> +    XAttrNode *current, *first;
> +    QppSrlzStream* stream = NULL;
> +    uint32_t crc32;
> +    int i;
> +    QppEntry *val;
> +    uint32_t hash;
> +
> +    if (s->qp_prefix_next != 1)
> +        return;
> +
> +    first = v9fs_load_qidp_xattr_nodes(s);
> +    if (!first)
> +        return;
> +
> +    /* convert nodes into continuous stream */
> +    size = 0;
> +    for (current = first; current; current = current->next) {
> +        size += current->length;
> +    }
> +    if (size <= 0) {
> +        goto out;
> +    }
> +    stream = g_malloc0(size);
> +    size = 0;
> +    for (current = first; current; current = current->next) {
> +        memcpy(((uint8_t*)stream) + size, current->value, current->length);
> +        size += current->length;
> +    }
> +
> +    if (stream->header.version != 1) {
> +        goto out;
> +    }
> +
> +    count = (size - sizeof(QppSrlzHeader)) / sizeof(QppEntryS);
> +    if (count <= 0) {
> +        goto out;
> +    }
> +
> +    /* verify CRC32 checksum of stream */
> +    crc32 = crc32c(
> +        0xffffffff,
> +        (const uint8_t*) &stream->elements[0],
> +        (count * sizeof(QppEntryS))
> +    );
> +    if (crc32 != stream->header.crc32) {
> +        goto out;
> +    }
> +
> +    /* fill qpp_table with the retrieved elements */
> +    for (i = 0; i < count; ++i) {
> +        val = g_malloc0(sizeof(QppEntry));
> +        *val = (QppEntry) {
> +            .dev = stream->elements[i].dev,
> +            .ino_prefix = stream->elements[i].ino_prefix,
> +        };
> +        hash = qpp_hash(*val);
> +        if (qht_lookup(&s->qpp_table, val, hash)) {
> +            /* should never happen: duplicate entry detected */
> +            g_free(val);
> +            goto out;
> +        }
> +        val->qp_prefix = s->qp_prefix_next++;
> +        qht_insert(&s->qpp_table, val, hash, NULL);
> +    }
> +
> +out:
> +    destroy_xattr_nodes(&first);
> +    if (stream)
> +        g_free(stream);
> +}
> +
>  /* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
>   * to a unique QID path (64 bits). To avoid having to map and keep track
>   * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
> @@ -675,6 +967,14 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
>          /* new unique inode prefix and device combo */
>          val->qp_prefix = pdu->s->qp_prefix_next++;
>          qht_insert(&pdu->s->qpp_table, val, hash, NULL);
> +
> +        /*
> +         * Store qpp_table as extended attribute(s) to file system.
> +         *
> +         * TODO: This should better only be called from a guest shutdown and
> +         * suspend handler.
> +         */
> +        v9fs_store_qpp_table(pdu->s);
>      }
>  
>      *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
> @@ -1064,11 +1364,6 @@ static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
>      v9fs_path_free(&str);
>  }
>  
> -static inline bool is_ro_export(FsContext *ctx)
> -{
> -    return ctx->export_flags & V9FS_RDONLY;
> -}
> -
>  static void coroutine_fn v9fs_version(void *opaque)
>  {
>      ssize_t err;
> @@ -3784,6 +4079,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>      qht_init(&s->qpp_table, qpp_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
>      s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
>      s->qp_fullpath_next = 1;
> +    /* try to load and restore previous qpp_table */
> +    v9fs_load_qpp_table(s);
>  
>      s->ctx.fst = &fse->fst;
>      fsdev_throttle_init(s->ctx.fst);
> @@ -3807,6 +4104,14 @@ out:
>  
>  void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
>  {
> +    /*
> +     * Store qpp_table as extended attribute(s) to file system.
> +     *
> +     * This was actually plan A, but unfortunately unserialize is not called
> +     * reliably on guest shutdowns and suspensions.
> +     */
> +    v9fs_store_qpp_table(s);
> +
>      if (s->ops->cleanup) {
>          s->ops->cleanup(&s->ctx);
>      }
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 44112ea97f..54ce039969 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -245,6 +245,13 @@ typedef struct {
>      uint16_t qp_prefix;
>  } QppEntry;
>  
> +/* Small version of QppEntry for serialization as xattr. */
> +struct QppEntryS {
> +    dev_t dev;
> +    uint16_t ino_prefix;
> +} __attribute__((packed));
> +typedef struct QppEntryS QppEntryS;
> +
>  /* QID path full entry, as above */
>  typedef struct {
>      dev_t dev;
> @@ -252,6 +259,32 @@ typedef struct {
>      uint64_t path;
>  } QpfEntry;
>  
> +typedef struct {
> +    QppEntryS *elements;
> +    uint count; /* In: QppEntryS count in @a elements */
> +    uint done; /* Out: how many QppEntryS did we actually fill in @a elements */
> +    int error; /* Out: zero on success */
> +} QppSerialize;
> +
> +struct QppSrlzHeader {
> +    uint16_t version;
> +    uint16_t reserved; /* might be used e.g. for flags in future */
> +    uint32_t crc32;
> +} __attribute__((packed));
> +typedef struct QppSrlzHeader QppSrlzHeader;
> +
> +struct QppSrlzStream {
> +    QppSrlzHeader header;
> +    QppEntryS elements[0];
> +} __attribute__((packed));
> +typedef struct QppSrlzStream QppSrlzStream;
> +
> +typedef struct XAttrNode {
> +    uint8_t* value;
> +    ssize_t length;
> +    struct XAttrNode* next;
> +} XAttrNode;
> +
>  struct V9fsState
>  {
>      QLIST_HEAD(, V9fsPDU) free_list;


