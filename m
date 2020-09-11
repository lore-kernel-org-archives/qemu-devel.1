Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9790C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEAF21D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEAF21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfWb-0008Mi-RY
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 05:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGfW3-0007qw-87; Fri, 11 Sep 2020 05:38:47 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:60749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGfW1-0001WW-77; Fri, 11 Sep 2020 05:38:46 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.172])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 02D646070368;
 Fri, 11 Sep 2020 11:38:40 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 11:38:40 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003787ca668-9b00-4b39-95db-4600228ad712,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 11:38:38 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 11/14] block/qcow2-bitmap: return startus from
 qcow2_store_persistent_dirty_bitmaps
Message-ID: <20200911113838.482b062e@bahia.lan>
In-Reply-To: <20200909185930.26524-12-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-12-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e1c0ed83-13d7-47e9-af90-5c275fcc02cc
X-Ovh-Tracer-Id: 5017009984898111931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:34:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

s/startus/status

On Wed,  9 Sep 2020 21:59:27 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> It's better to return status together with setting errp. It makes
> possible to avoid error propagation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h        |  2 +-
>  block/qcow2-bitmap.c | 13 ++++++-------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index e7e662533b..49824be5c6 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
>                                  Qcow2BitmapInfoList **info_list, Error **errp);
>  int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>  int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>                                            bool release_stored, Error **errp);
>  int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>  bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index f58923fce3..5eeff1cb1c 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1524,9 +1524,10 @@ out:
>   * readonly to begin with, and whether we opened directly or reopened to that
>   * state shouldn't matter for the state we get afterward.
>   */
> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>                                            bool release_stored, Error **errp)
>  {
> +    ERRP_GUARD();

Maybe worth mentioning in the changelog that this ERRP_GUARD() fixes
an error_prepend(errp, ...) not visible in the patch context.

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

>      BdrvDirtyBitmap *bitmap;
>      BDRVQcow2State *s = bs->opaque;
>      uint32_t new_nb_bitmaps = s->nb_bitmaps;
> @@ -1546,7 +1547,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>          bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>                                     s->bitmap_directory_size, errp);
>          if (bm_list == NULL) {
> -            return;
> +            return false;
>          }
>      }
>  
> @@ -1661,7 +1662,7 @@ success:
>      }
>  
>      bitmap_list_free(bm_list);
> -    return;
> +    return true;
>  
>  fail:
>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> @@ -1679,16 +1680,14 @@ fail:
>      }
>  
>      bitmap_list_free(bm_list);
> +    return false;
>  }
>  
>  int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>  {
>      BdrvDirtyBitmap *bitmap;
> -    Error *local_err = NULL;
>  
> -    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> +    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
>          return -EINVAL;
>      }
>  


