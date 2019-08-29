Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A137C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8522166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8522166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NIF-00082W-F3
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3NGx-00075h-Dn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3NGv-0002yF-4K
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:27:42 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:35085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3NGu-0002wi-TD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:27:41 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.52])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id AE50818CEBB
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:27:38 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id D69AF939CAB0;
 Thu, 29 Aug 2019 16:27:32 +0000 (UTC)
Date: Thu, 29 Aug 2019 18:27:30 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190829182730.1e1d69b2@bahia.lan>
In-Reply-To: <5415baa3955c354d9f1e6aab39270ab2abca662a.1566503584.git.qemu_oss@crudebyte.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <5415baa3955c354d9f1e6aab39270ab2abca662a.1566503584.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18228882444967188800
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeivddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.60.232
Subject: Re: [Qemu-devel] [PATCH v6 1/4] 9p: Treat multiple devices on one
 export as an error
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 21:28:19 +0200
Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:

> The QID path should uniquely identify a file. However, the
> inode of a file is currently used as the QID path, which
> on its own only uniquely identifies files within a device.
> Here we track the device hosting the 9pfs share, in order
> to prevent security issues with QID path collisions from
> other devices.
> 
> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> [CS: - Assign dev_id to export root's device already in
>        v9fs_device_realize_common(), not postponed in
>        stat_to_qid().
>      - error_report_once() if more than one device was
>        shared by export.
>      - Return -ENODEV instead of -ENOSYS in stat_to_qid().
>      - Fixed typo in log comment. ]
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++------------
>  hw/9pfs/9p.h |  1 +
>  2 files changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 586a6dccba..8cc65c2c67 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -572,10 +572,18 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
>                                  P9_STAT_MODE_SOCKET)
>  
>  /* This is the algorithm from ufs in spfs */
> -static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
> +static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
>  {
>      size_t size;
>  
> +    if (pdu->s->dev_id != stbuf->st_dev) {
> +        error_report_once(
> +            "9p: Multiple devices detected in same VirtFS export. "
> +            "You must use a separate export for each device."
> +        );
> +        return -ENODEV;

As explained in the v5 review, we don't necessarily want to break existing
cross-device setups that just happen to work. Moreover, the next patch
re-allows them since remap_inodes=ignore is the default. I would thus
only do:

        warn_report_once(
                    "9p: Multiple devices detected in same VirtFS export, "
                    "which might lead to file ID collisions and severe "
                    "misbehaviours on guest! You should use a separate "
                    "export for each device shared from host."
        );

So I've just changed that and applied to 9p-next since it is
a valuable improvement. Note that I've kept the signature change
of stat_to_qid() for simplicity even if it isn't needed before
the next patch.

> +    }
> +
>      memset(&qidp->path, 0, sizeof(qidp->path));
>      size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
>      memcpy(&qidp->path, &stbuf->st_ino, size);
> @@ -587,6 +595,8 @@ static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
>      if (S_ISLNK(stbuf->st_mode)) {
>          qidp->type |= P9_QID_TYPE_SYMLINK;
>      }
> +
> +    return 0;
>  }
>  
>  static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
> @@ -599,7 +609,10 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
>      if (err < 0) {
>          return err;
>      }
> -    stat_to_qid(&stbuf, qidp);
> +    err = stat_to_qid(pdu, &stbuf, qidp);
> +    if (err < 0) {
> +        return err;
> +    }
>      return 0;
>  }
>  
> @@ -830,7 +843,10 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
>  
>      memset(v9stat, 0, sizeof(*v9stat));
>  
> -    stat_to_qid(stbuf, &v9stat->qid);
> +    err = stat_to_qid(pdu, stbuf, &v9stat->qid);
> +    if (err < 0) {
> +        return err;
> +    }
>      v9stat->mode = stat_to_v9mode(stbuf);
>      v9stat->atime = stbuf->st_atime;
>      v9stat->mtime = stbuf->st_mtime;
> @@ -891,7 +907,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
>  #define P9_STATS_ALL           0x00003fffULL /* Mask for All fields above */
>  
>  
> -static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
> +static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
>                                  V9fsStatDotl *v9lstat)
>  {
>      memset(v9lstat, 0, sizeof(*v9lstat));
> @@ -913,7 +929,7 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
>      /* Currently we only support BASIC fields in stat */
>      v9lstat->st_result_mask = P9_STATS_BASIC;
>  
> -    stat_to_qid(stbuf, &v9lstat->qid);
> +    return stat_to_qid(pdu, stbuf, &v9lstat->qid);
>  }
>  
>  static void print_sg(struct iovec *sg, int cnt)
> @@ -1115,7 +1131,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>      uint64_t request_mask;
>      V9fsStatDotl v9stat_dotl;
>      V9fsPDU *pdu = opaque;
> -    V9fsState *s = pdu->s;
>  
>      retval = pdu_unmarshal(pdu, offset, "dq", &fid, &request_mask);
>      if (retval < 0) {
> @@ -1136,7 +1151,10 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>      if (retval < 0) {
>          goto out;
>      }
> -    stat_to_v9stat_dotl(s, &stbuf, &v9stat_dotl);
> +    retval = stat_to_v9stat_dotl(pdu, &stbuf, &v9stat_dotl);
> +    if (retval < 0) {
> +        goto out;
> +    }
>  
>      /*  fill st_gen if requested and supported by underlying fs */
>      if (request_mask & P9_STATS_GEN) {
> @@ -1381,7 +1399,10 @@ static void coroutine_fn v9fs_walk(void *opaque)
>              if (err < 0) {
>                  goto out;
>              }
> -            stat_to_qid(&stbuf, &qid);
> +            err = stat_to_qid(pdu, &stbuf, &qid);
> +            if (err < 0) {
> +                goto out;
> +            }
>              v9fs_path_copy(&dpath, &path);
>          }
>          memcpy(&qids[name_idx], &qid, sizeof(qid));
> @@ -1483,7 +1504,10 @@ static void coroutine_fn v9fs_open(void *opaque)
>      if (err < 0) {
>          goto out;
>      }
> -    stat_to_qid(&stbuf, &qid);
> +    err = stat_to_qid(pdu, &stbuf, &qid);
> +    if (err < 0) {
> +        goto out;
> +    }
>      if (S_ISDIR(stbuf.st_mode)) {
>          err = v9fs_co_opendir(pdu, fidp);
>          if (err < 0) {
> @@ -1593,7 +1617,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
>          fidp->flags |= FID_NON_RECLAIMABLE;
>      }
>      iounit =  get_iounit(pdu, &fidp->path);
> -    stat_to_qid(&stbuf, &qid);
> +    err = stat_to_qid(pdu, &stbuf, &qid);
> +    if (err < 0) {
> +        goto out;
> +    }
>      err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
>      if (err < 0) {
>          goto out;
> @@ -2327,7 +2354,10 @@ static void coroutine_fn v9fs_create(void *opaque)
>          }
>      }
>      iounit = get_iounit(pdu, &fidp->path);
> -    stat_to_qid(&stbuf, &qid);
> +    err = stat_to_qid(pdu, &stbuf, &qid);
> +    if (err < 0) {
> +        goto out;
> +    }
>      err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
>      if (err < 0) {
>          goto out;
> @@ -2384,7 +2414,10 @@ static void coroutine_fn v9fs_symlink(void *opaque)
>      if (err < 0) {
>          goto out;
>      }
> -    stat_to_qid(&stbuf, &qid);
> +    err = stat_to_qid(pdu, &stbuf, &qid);
> +    if (err < 0) {
> +        goto out;
> +    }
>      err =  pdu_marshal(pdu, offset, "Q", &qid);
>      if (err < 0) {
>          goto out;
> @@ -3064,7 +3097,10 @@ static void coroutine_fn v9fs_mknod(void *opaque)
>      if (err < 0) {
>          goto out;
>      }
> -    stat_to_qid(&stbuf, &qid);
> +    err = stat_to_qid(pdu, &stbuf, &qid);
> +    if (err < 0) {
> +        goto out;
> +    }
>      err = pdu_marshal(pdu, offset, "Q", &qid);
>      if (err < 0) {
>          goto out;
> @@ -3222,7 +3258,10 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
>      if (err < 0) {
>          goto out;
>      }
> -    stat_to_qid(&stbuf, &qid);
> +    err = stat_to_qid(pdu, &stbuf, &qid);
> +    if (err < 0) {
> +        goto out;
> +    }
>      err = pdu_marshal(pdu, offset, "Q", &qid);
>      if (err < 0) {
>          goto out;
> @@ -3633,6 +3672,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>          goto out;
>      }
>  
> +    s->dev_id = stat.st_dev;
> +
>      s->ctx.fst = &fse->fst;
>      fsdev_throttle_init(s->ctx.fst);
>  
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 8883761b2c..5e316178d5 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -256,6 +256,7 @@ struct V9fsState
>      Error *migration_blocker;
>      V9fsConf fsconf;
>      V9fsQID root_qid;
> +    dev_t dev_id;
>  };
>  
>  /* 9p2000.L open flags */


