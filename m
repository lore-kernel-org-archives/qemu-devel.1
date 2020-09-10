Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58063C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6512076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6512076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOrg-00031e-Eu
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGOr2-0002Yf-TC; Thu, 10 Sep 2020 11:51:21 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGOqz-0003ec-N0; Thu, 10 Sep 2020 11:51:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.195])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 191F159AF3DB;
 Thu, 10 Sep 2020 17:51:07 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 10 Sep
 2020 17:51:06 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0022b2091cd-d4e2-4b1b-8077-71b9f8343d6e,
 39F76413F398F3D3265C4F59F57E6F6E33B9D840) smtp.auth=groug@kaod.org
Date: Thu, 10 Sep 2020 17:51:05 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 01/14] block: return status from bdrv_append and friends
Message-ID: <20200910175105.01cc95f0@bahia.lan>
In-Reply-To: <20200909185930.26524-2-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-2-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 2a1e82af-aa45-48cd-b6ab-22ad02257c37
X-Ovh-Tracer-Id: 5434155902602549691
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 11:51:07
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

On Wed,  9 Sep 2020 21:59:17 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> The recommended use of qemu error api assumes returning status together
> with setting errp and avoid void functions with errp parameter. Let's
> improve bdrv_append and some friends to reduce error-propagation
> overhead in further patches.
> 
> Choose int return status, because bdrv_replace_node() has call to
> bdrv_check_update_perm(), which reports int status, which seems correct
> to propagate.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/block/block.h | 12 ++++++------
>  block.c               | 39 ++++++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 6e36154061..03b3cee8f8 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -336,10 +336,10 @@ int bdrv_create(BlockDriver *drv, const char* filename,
>  int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
>  
>  BlockDriverState *bdrv_new(void);
> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> -                 Error **errp);
> -void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> -                       Error **errp);
> +int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> +                Error **errp);
> +int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> +                      Error **errp);
>  
>  int bdrv_parse_aio(const char *mode, int *flags);
>  int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
> @@ -351,8 +351,8 @@ BdrvChild *bdrv_open_child(const char *filename,
>                             BdrvChildRole child_role,
>                             bool allow_none, Error **errp);
>  BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
> -void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> -                         Error **errp);
> +int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> +                        Error **errp);
>  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>                             const char *bdref_key, Error **errp);
>  BlockDriverState *bdrv_open(const char *filename, const char *reference,
> diff --git a/block.c b/block.c
> index 2ba76b2c36..6d35449027 100644
> --- a/block.c
> +++ b/block.c
> @@ -2866,14 +2866,15 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
>   * Sets the backing file link of a BDS. A new reference is created; callers
>   * which don't need their own reference any more must call bdrv_unref().
>   */
> -void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
> +int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>                           Error **errp)
>  {
> +    int ret = 0;
>      bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
>          bdrv_inherits_from_recursive(backing_hd, bs);
>  
>      if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
> -        return;
> +        return -EPERM;
>      }
>  
>      if (backing_hd) {
> @@ -2891,15 +2892,22 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>  
>      bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_of_bds,
>                                      bdrv_backing_role(bs), errp);
> +    if (!bs->backing) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
>      /* If backing_hd was already part of bs's backing chain, and
>       * inherits_from pointed recursively to bs then let's update it to
>       * point directly to bs (else it will become NULL). */
> -    if (bs->backing && update_inherits_from) {
> +    if (update_inherits_from) {
>          backing_hd->inherits_from = bs;
>      }
>  
>  out:
>      bdrv_refresh_limits(bs, NULL);
> +
> +    return ret;
>  }
>  
>  /*
> @@ -4517,8 +4525,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
>      return ret;
>  }
>  
> -void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> -                       Error **errp)
> +int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
> +                      Error **errp)
>  {
>      BdrvChild *c, *next;
>      GSList *list = NULL, *p;
> @@ -4540,6 +4548,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>              continue;
>          }
>          if (c->frozen) {
> +            ret = -EPERM;
>              error_setg(errp, "Cannot change '%s' link to '%s'",
>                         c->name, from->node_name);
>              goto out;
> @@ -4575,6 +4584,8 @@ out:
>      g_slist_free(list);
>      bdrv_drained_end(from);
>      bdrv_unref(from);
> +
> +    return ret;
>  }
>  
>  /*
> @@ -4593,20 +4604,16 @@ out:
>   * parents of bs_top after bdrv_append() returns. If the caller needs to keep a
>   * reference of its own, it must call bdrv_ref().
>   */
> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> -                 Error **errp)
> +int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> +                Error **errp)
>  {
> -    Error *local_err = NULL;
> -
> -    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    int ret = bdrv_set_backing_hd(bs_new, bs_top, errp);
> +    if (ret < 0) {
>          goto out;
>      }
>  
> -    bdrv_replace_node(bs_top, bs_new, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    ret = bdrv_replace_node(bs_top, bs_new, errp);
> +    if (ret < 0) {
>          bdrv_set_backing_hd(bs_new, NULL, &error_abort);
>          goto out;
>      }
> @@ -4615,6 +4622,8 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>       * additional reference any more. */
>  out:
>      bdrv_unref(bs_new);
> +
> +    return ret;
>  }
>  
>  static void bdrv_delete(BlockDriverState *bs)


