Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD3EC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92302078D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92302078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGedT-00014Y-0K
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGecP-0007rI-D6; Fri, 11 Sep 2020 04:41:18 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:57729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGecM-0002SO-KJ; Fri, 11 Sep 2020 04:41:16 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.217])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 91257606883C;
 Fri, 11 Sep 2020 10:41:10 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 10:41:09 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006ac774814-6f5f-4c9a-a409-cd6edb6aae80,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 10:41:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 09/14] block/qcow2: qcow2_get_specific_info(): drop
 error propagation
Message-ID: <20200911104108.1ad641d7@bahia.lan>
In-Reply-To: <20200909185930.26524-10-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-10-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 39abd96b-38a4-4954-aa86-d0d4d59046bc
X-Ovh-Tracer-Id: 4045921319009556923
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:34:40
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

On Wed,  9 Sep 2020 21:59:25 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Don't use error propagation in qcow2_get_specific_info(). For this
> refactor qcow2_get_bitmap_info_list, its current interface rather

... interface is rather

> weird.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  block/qcow2.h        |  4 ++--
>  block/qcow2-bitmap.c | 27 +++++++++++++--------------
>  block/qcow2.c        | 10 +++-------
>  3 files changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 065ec3df0b..ac6a2d3e2a 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -967,8 +967,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                    void **refcount_table,
>                                    int64_t *refcount_table_size);
>  bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> -Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
> -                                                Error **errp);
> +bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
> +                                Qcow2BitmapInfoList **info_list, Error **errp);
>  int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>  int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 8c34b2aef7..9b14c0791f 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1090,30 +1090,29 @@ static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
>  /*
>   * qcow2_get_bitmap_info_list()
>   * Returns a list of QCOW2 bitmap details.
> - * In case of no bitmaps, the function returns NULL and
> - * the @errp parameter is not set.
> - * When bitmap information can not be obtained, the function returns
> - * NULL and the @errp parameter is set.
> + * On success return true with bm_list set (probably to NULL, if no bitmaps),
> + * on failure return false with errp set.
>   */
> -Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
> -                                                Error **errp)
> +bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
> +                                Qcow2BitmapInfoList **info_list, Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      Qcow2BitmapList *bm_list;
>      Qcow2Bitmap *bm;
> -    Qcow2BitmapInfoList *list = NULL;
> -    Qcow2BitmapInfoList **plist = &list;
>  
>      if (s->nb_bitmaps == 0) {
> -        return NULL;
> +        *info_list = NULL;
> +        return true;
>      }
>  
>      bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>                                 s->bitmap_directory_size, errp);
> -    if (bm_list == NULL) {
> -        return NULL;
> +    if (!bm_list) {
> +        return false;
>      }
>  
> +    *info_list = NULL;
> +
>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>          Qcow2BitmapInfo *info = g_new0(Qcow2BitmapInfo, 1);
>          Qcow2BitmapInfoList *obj = g_new0(Qcow2BitmapInfoList, 1);
> @@ -1121,13 +1120,13 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
>          info->name = g_strdup(bm->name);
>          info->flags = get_bitmap_info_flags(bm->flags & ~BME_RESERVED_FLAGS);
>          obj->value = info;
> -        *plist = obj;
> -        plist = &obj->next;
> +        *info_list = obj;
> +        info_list = &obj->next;
>      }
>  
>      bitmap_list_free(bm_list);
>  
> -    return list;
> +    return true;
>  }
>  
>  int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 10175fa399..eb7c82120c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5056,12 +5056,10 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>      BDRVQcow2State *s = bs->opaque;
>      ImageInfoSpecific *spec_info;
>      QCryptoBlockInfo *encrypt_info = NULL;
> -    Error *local_err = NULL;
>  
>      if (s->crypto != NULL) {
> -        encrypt_info = qcrypto_block_get_info(s->crypto, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        encrypt_info = qcrypto_block_get_info(s->crypto, errp);
> +        if (!encrypt_info) {
>              return NULL;
>          }
>      }
> @@ -5078,9 +5076,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>          };
>      } else if (s->qcow_version == 3) {
>          Qcow2BitmapInfoList *bitmaps;
> -        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        if (!qcow2_get_bitmap_info_list(bs, &bitmaps, errp)) {
>              qapi_free_ImageInfoSpecific(spec_info);
>              qapi_free_QCryptoBlockInfo(encrypt_info);
>              return NULL;


