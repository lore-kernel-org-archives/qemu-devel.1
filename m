Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40172C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B343205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B343205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgo23-0004ZV-ME
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56264)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgo0Y-0003S7-Nt
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgo0X-0006hw-D6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:21:30 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:57249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgo0X-0006fK-6H
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:21:29 -0400
Received: from player771.ha.ovh.net (unknown [10.108.35.13])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5FADA134F15
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 12:21:25 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 8DF9775A1071;
 Fri, 28 Jun 2019 10:21:21 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:21:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190628122120.60a1ec0b@bahia.lan>
In-Reply-To: <fa636e323b8644469f9b03619758b6c1c6d1d4f2.1561575449.git.qemu_oss@crudebyte.com>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <fa636e323b8644469f9b03619758b6c1c6d1d4f2.1561575449.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16871610105681975616
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.230
Subject: Re: [Qemu-devel] [PATCH v4 4/5] 9p: stat_to_qid: implement slow path
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

On Wed, 26 Jun 2019 20:46:24 +0200
Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:

> stat_to_qid attempts via qid_path_prefixmap to map unique files (which are
> identified by 64 bit inode nr and 32 bit device id) to a 64 QID path value.
> However this implementation makes some assumptions about inode number
> generation on the host.
> 
> If qid_path_prefixmap fails, we still have 48 bits available in the QID
> path to fall back to a less memory efficient full mapping.
> 
> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  hw/9pfs/9p.h |  9 +++++++++
>  2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 7ccc68a829..e6e410972f 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -579,23 +579,69 @@ static uint32_t qpp_hash(QppEntry e)
>      return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
>  }
>  
> +static uint32_t qpf_hash(QpfEntry e)
> +{
> +    return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
> +}
> +
>  static bool qpp_lookup_func(const void *obj, const void *userp)
>  {
>      const QppEntry *e1 = obj, *e2 = userp;
>      return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
>  }
>  
> -static void qpp_table_remove(void *p, uint32_t h, void *up)
> +static bool qpf_lookup_func(const void *obj, const void *userp)
> +{
> +    const QpfEntry *e1 = obj, *e2 = userp;
> +    return e1->dev == e2->dev && e1->ino == e2->ino;
> +}
> +
> +static void qp_table_remove(void *p, uint32_t h, void *up)
>  {
>      g_free(p);
>  }
>  
> -static void qpp_table_destroy(struct qht *ht)
> +static void qp_table_destroy(struct qht *ht)
>  {
> -    qht_iter(ht, qpp_table_remove, NULL);
> +    qht_iter(ht, qp_table_remove, NULL);
>      qht_destroy(ht);
>  }
>  
> +static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
> +                            uint64_t *path)
> +{
> +    QpfEntry lookup = {
> +        .dev = stbuf->st_dev,
> +        .ino = stbuf->st_ino
> +    }, *val;
> +    uint32_t hash = qpf_hash(lookup);
> +
> +    /* most users won't need the fullmap, so init the table lazily */
> +    if (!pdu->s->qpf_table.map) {
> +        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
> +    }
> +
> +    val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
> +
> +    if (!val) {
> +        if (pdu->s->qp_fullpath_next == 0) {
> +            /* no more files can be mapped :'( */

This would be the place to put the error_report_once() suggested
in the previous patch actually.

> +            return -ENFILE;
> +        }
> +
> +        val = g_malloc0(sizeof(QppEntry));
> +        *val = lookup;
> +
> +        /* new unique inode and device combo */
> +        val->path = pdu->s->qp_fullpath_next++;
> +        pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
> +        qht_insert(&pdu->s->qpf_table, val, hash, NULL);
> +    }
> +
> +    *path = val->path;
> +    return 0;
> +}
> +
>  /* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
>   * to a unique QID path (64 bits). To avoid having to map and keep track
>   * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
> @@ -642,6 +688,10 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
>      if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
>          /* map inode+device to qid path (fast path) */
>          err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
> +        if (err == -ENFILE) {
> +            /* fast path didn't work, fall back to full map */
> +            err = qid_path_fullmap(pdu, stbuf, &qidp->path);
> +        }
>          if (err) {
>              return err;
>          }
> @@ -3752,6 +3802,7 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>      /* QID path hash table. 1 entry ought to be enough for anybody ;) */
>      qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
>      s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
> +    s->qp_fullpath_next = 1;
>  
>      s->ctx.fst = &fse->fst;
>      fsdev_throttle_init(s->ctx.fst);
> @@ -3766,7 +3817,8 @@ out:
>          }
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
> -        qpp_table_destroy(&s->qpp_table);
> +        qp_table_destroy(&s->qpp_table);
> +        qp_table_destroy(&s->qpf_table);
>          v9fs_path_free(&path);
>      }
>      return rc;
> @@ -3779,7 +3831,8 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
>      }
>      fsdev_throttle_cleanup(s->ctx.fst);
>      g_free(s->tag);
> -    qpp_table_destroy(&s->qpp_table);
> +    qp_table_destroy(&s->qpp_table);
> +    qp_table_destroy(&s->qpf_table);

I'm starting to think v9fs_device_unrealize_common() should be made
idempotent, so that it can be used to handle rollback of a partially
realized device, and thus avoid the code duplication. But this is
out-of-scope for this series.

LGTM.

>      g_free(s->ctx.fs_root);
>  }
>  
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 0200e04176..2b74561030 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -245,6 +245,13 @@ typedef struct {
>      uint16_t qp_prefix;
>  } QppEntry;
>  
> +/* QID path full entry, as above */
> +typedef struct {
> +    dev_t dev;
> +    ino_t ino;
> +    uint64_t path;
> +} QpfEntry;
> +
>  struct V9fsState
>  {
>      QLIST_HEAD(, V9fsPDU) free_list;
> @@ -268,7 +275,9 @@ struct V9fsState
>      V9fsQID root_qid;
>      dev_t dev_id;
>      struct qht qpp_table;
> +    struct qht qpf_table;
>      uint16_t qp_prefix_next;
> +    uint64_t qp_fullpath_next;
>  };
>  
>  /* 9p2000.L open flags */


