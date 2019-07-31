Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C22C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5344F206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5344F206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvGG-0001Op-KQ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hsvFc-0000tF-V8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hsvFb-0007KV-BR
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:31:08 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:35899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hsvFb-0007J3-2t
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:31:07 -0400
Received: from player695.ha.ovh.net (unknown [10.108.35.185])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 01CDA247766
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 22:31:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 584A1865036A;
 Wed, 31 Jul 2019 20:30:58 +0000 (UTC)
Date: Wed, 31 Jul 2019 22:30:57 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190731223057.3439026e@bahia.lan>
In-Reply-To: <742b9d876d86fc263492885a7aacc1e1cda274e1.1562154272.git.qemu_oss@crudebyte.com>
References: <cover.1562154272.git.qemu_oss@crudebyte.com>
 <742b9d876d86fc263492885a7aacc1e1cda274e1.1562154272.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18052679108127070528
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgddugeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.247
Subject: Re: [Qemu-devel] [PATCH v5 2/5] 9p: Treat multiple devices on one
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 13:01:34 +0200
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

The fix is good in the sense that it purely forbids cross-device accesses,
which provides improved security. But some people may wish to do cross-device
anyway, for example because they have ultimate knowledge or luck that their
usual setup doesn't have colliding inodes, or simply that their workload
doesn't care for inode numbers at all.

Next patches in this series introduce inode number remapping, which is
a good way of addressing collisions. This should always be used in a
cross-device setup. But again, people who don't do cross-device, may
wish to disable remapping to avoid the potential performance loss or
extra memory consumption.

I suggest you add a new property to the 9p device so that people can
choose the behavior that best fits their need. Something like:

-device virtio-9p,cross-device=[ignore|forbid|remap]

ignore: detect the cross-device condition and spit-once a big fat warning
        about the potential consequences, and alternatives to avoid
        them, but don't fail the I/O
forbid: detect the cross-device condition, spit-once an error and fail the
        I/O like the current patch does
remap: well... remap all inode numbers

I would make 'ignore' the default since it is the current behavior, but
I'm ready to change my mind if someone has a convincing argument that
the default should be more secure.

Cc'ing Stefan and Dave in case they have some more suggestions after the
discussion we had on irc.

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


