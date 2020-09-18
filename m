Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4172FC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73632100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73632100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJCM-0000vZ-Nv
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJIv1-0006a5-Pc; Fri, 18 Sep 2020 12:07:27 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:49749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kJIuz-0003BR-CN; Fri, 18 Sep 2020 12:07:27 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.129])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 720CA6335169;
 Fri, 18 Sep 2020 18:07:20 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 18:07:19 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001cb4bc9a3-75ad-46a8-b6b4-38e53dc00fde,
 26E73787F9CAC9185D3FF732CC8AC9B997D690EB) smtp.auth=groug@kaod.org
Date: Fri, 18 Sep 2020 18:07:13 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 13/13] block/qed: bdrv_qed_do_open: deal with errp
Message-ID: <20200918180713.0c09e11d@bahia.lan>
In-Reply-To: <20200917195519.19589-14-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
 <20200917195519.19589-14-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7cc00237-5be0-4f7e-bf57-1a03f1e3a548
X-Ovh-Tracer-Id: 15796375693385701819
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:15:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 22:55:19 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Set errp always on failure. Generic bdrv_open_driver supports driver
> functions which can return negative value and forget to set errp.
> That's a strange thing.. Let's improve bdrv_qed_do_open to not behave
> this way. This allows to simplify code in
> bdrv_qed_co_invalidate_cache().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  block/qed.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/block/qed.c b/block/qed.c
> index b27e7546ca..f45c640513 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -393,6 +393,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>  
>      ret = bdrv_pread(bs->file, 0, &le_header, sizeof(le_header));
>      if (ret < 0) {
> +        error_setg(errp, "Failed to read QED header");
>          return ret;
>      }
>      qed_header_le_to_cpu(&le_header, &s->header);
> @@ -408,25 +409,30 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>          return -ENOTSUP;
>      }
>      if (!qed_is_cluster_size_valid(s->header.cluster_size)) {
> +        error_setg(errp, "QED cluster size is invalid");
>          return -EINVAL;
>      }
>  
>      /* Round down file size to the last cluster */
>      file_size = bdrv_getlength(bs->file->bs);
>      if (file_size < 0) {
> +        error_setg(errp, "Failed to get file length");
>          return file_size;
>      }
>      s->file_size = qed_start_of_cluster(s, file_size);
>  
>      if (!qed_is_table_size_valid(s->header.table_size)) {
> +        error_setg(errp, "QED table size is invalid");
>          return -EINVAL;
>      }
>      if (!qed_is_image_size_valid(s->header.image_size,
>                                   s->header.cluster_size,
>                                   s->header.table_size)) {
> +        error_setg(errp, "QED image size is invalid");
>          return -EINVAL;
>      }
>      if (!qed_check_table_offset(s, s->header.l1_table_offset)) {
> +        error_setg(errp, "QED table offset is invalid");
>          return -EINVAL;
>      }
>  
> @@ -438,6 +444,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>  
>      /* Header size calculation must not overflow uint32_t */
>      if (s->header.header_size > UINT32_MAX / s->header.cluster_size) {
> +        error_setg(errp, "QED header size is too large");
>          return -EINVAL;
>      }
>  
> @@ -445,6 +452,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>          if ((uint64_t)s->header.backing_filename_offset +
>              s->header.backing_filename_size >
>              s->header.cluster_size * s->header.header_size) {
> +            error_setg(errp, "QED backing filename offset is invalid");
>              return -EINVAL;
>          }
>  
> @@ -453,6 +461,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>                                bs->auto_backing_file,
>                                sizeof(bs->auto_backing_file));
>          if (ret < 0) {
> +            error_setg(errp, "Failed to read backing filename");
>              return ret;
>          }
>          pstrcpy(bs->backing_file, sizeof(bs->backing_file),
> @@ -475,6 +484,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>  
>          ret = qed_write_header_sync(s);
>          if (ret) {
> +            error_setg(errp, "Failed to update header");
>              return ret;
>          }
>  
> @@ -487,6 +497,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>  
>      ret = qed_read_l1_table_sync(s);
>      if (ret) {
> +        error_setg(errp, "Failed to read L1 table");
>          goto out;
>      }
>  
> @@ -503,6 +514,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
>  
>              ret = qed_check(s, &result, true);
>              if (ret) {
> +                error_setg(errp, "Image corrupted");
>                  goto out;
>              }
>          }
> @@ -1537,22 +1549,16 @@ static void coroutine_fn bdrv_qed_co_invalidate_cache(BlockDriverState *bs,
>                                                        Error **errp)
>  {
>      BDRVQEDState *s = bs->opaque;
> -    Error *local_err = NULL;
>      int ret;
>  
>      bdrv_qed_close(bs);
>  
>      bdrv_qed_init_state(bs);
>      qemu_co_mutex_lock(&s->table_lock);
> -    ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
> +    ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, errp);
>      qemu_co_mutex_unlock(&s->table_lock);
> -    if (local_err) {
> -        error_propagate_prepend(errp, local_err,
> -                                "Could not reopen qed layer: ");
> -        return;
> -    } else if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Could not reopen qed layer");
> -        return;
> +    if (ret < 0) {
> +        error_prepend(errp, "Could not reopen qed layer: ");
>      }
>  }
>  


