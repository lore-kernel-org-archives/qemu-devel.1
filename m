Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0879AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A312075A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A312075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPL4-0004qo-Fy
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGPKV-0004LZ-GJ; Thu, 10 Sep 2020 12:21:47 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:39365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGPKT-0007ir-9I; Thu, 10 Sep 2020 12:21:47 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.235])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id C45DE602D6CB;
 Thu, 10 Sep 2020 18:21:20 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 10 Sep
 2020 18:21:19 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0066e8b4359-616d-482d-a974-373c8c41d331,
 39F76413F398F3D3265C4F59F57E6F6E33B9D840) smtp.auth=groug@kaod.org
Date: Thu, 10 Sep 2020 18:21:18 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 03/14] block: check return value of bdrv_open_child and
 drop error propagation
Message-ID: <20200910182118.46171d78@bahia.lan>
In-Reply-To: <20200909185930.26524-4-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-4-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: d8dc5208-d9b5-46b0-b52d-1b326984dc7a
X-Ovh-Tracer-Id: 5944751508891408827
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 12:21:41
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

On Wed,  9 Sep 2020 21:59:19 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> This patch is generated by cocci script:
> 
> @@
> symbol bdrv_open_child, errp, local_err;
> expression file;
> @@
> 
>   file = bdrv_open_child(...,
> -                        &local_err
> +                        errp
>                         );
> - if (local_err)
> + if (!file)
>   {
>       ...
> -     error_propagate(errp, local_err);
>       ...
>   }
> 
> with command
> 
> spatch --sp-file x.cocci --macro-file scripts/cocci-macro-file.h \
> --in-place --no-show-diff --max-width 80 --use-gitgrep block
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  block/blkdebug.c     |  6 ++----
>  block/blklogwrites.c | 10 ++++------
>  block/blkreplay.c    |  6 ++----
>  block/blkverify.c    | 11 ++++-------
>  block/qcow2.c        |  5 ++---
>  block/quorum.c       |  6 ++----
>  6 files changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 9c08d8a005..61aaee9879 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -464,7 +464,6 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
>  {
>      BDRVBlkdebugState *s = bs->opaque;
>      QemuOpts *opts;
> -    Error *local_err = NULL;
>      int ret;
>      uint64_t align;
>  
> @@ -494,10 +493,9 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
>      bs->file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options, "image",
>                                 bs, &child_of_bds,
>                                 BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
> -                               false, &local_err);
> -    if (local_err) {
> +                               false, errp);
> +    if (!bs->file) {
>          ret = -EINVAL;
> -        error_propagate(errp, local_err);
>          goto out;
>      }
>  
> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> index 57315f56b4..7ef046cee9 100644
> --- a/block/blklogwrites.c
> +++ b/block/blklogwrites.c
> @@ -157,19 +157,17 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>      /* Open the file */
>      bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>                                 BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, false,
> -                               &local_err);
> -    if (local_err) {
> +                               errp);
> +    if (!bs->file) {
>          ret = -EINVAL;
> -        error_propagate(errp, local_err);
>          goto fail;
>      }
>  
>      /* Open the log file */
>      s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_of_bds,
> -                                  BDRV_CHILD_METADATA, false, &local_err);
> -    if (local_err) {
> +                                  BDRV_CHILD_METADATA, false, errp);
> +    if (!s->log_file) {
>          ret = -EINVAL;
> -        error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> diff --git a/block/blkreplay.c b/block/blkreplay.c
> index 30a0f5d57a..4a247752fd 100644
> --- a/block/blkreplay.c
> +++ b/block/blkreplay.c
> @@ -23,16 +23,14 @@ typedef struct Request {
>  static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
>                            Error **errp)
>  {
> -    Error *local_err = NULL;
>      int ret;
>  
>      /* Open the image file */
>      bs->file = bdrv_open_child(NULL, options, "image", bs, &child_of_bds,
>                                 BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
> -                               false, &local_err);
> -    if (local_err) {
> +                               false, errp);
> +    if (!bs->file) {
>          ret = -EINVAL;
> -        error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> diff --git a/block/blkverify.c b/block/blkverify.c
> index 4aed53ab59..95ae73e2aa 100644
> --- a/block/blkverify.c
> +++ b/block/blkverify.c
> @@ -112,7 +112,6 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
>  {
>      BDRVBlkverifyState *s = bs->opaque;
>      QemuOpts *opts;
> -    Error *local_err = NULL;
>      int ret;
>  
>      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> @@ -125,20 +124,18 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
>      bs->file = bdrv_open_child(qemu_opt_get(opts, "x-raw"), options, "raw",
>                                 bs, &child_of_bds,
>                                 BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
> -                               false, &local_err);
> -    if (local_err) {
> +                               false, errp);
> +    if (!bs->file) {
>          ret = -EINVAL;
> -        error_propagate(errp, local_err);
>          goto fail;
>      }
>  
>      /* Open the test file */
>      s->test_file = bdrv_open_child(qemu_opt_get(opts, "x-image"), options,
>                                     "test", bs, &child_of_bds, BDRV_CHILD_DATA,
> -                                   false, &local_err);
> -    if (local_err) {
> +                                   false, errp);
> +    if (!s->test_file) {
>          ret = -EINVAL;
> -        error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> diff --git a/block/qcow2.c b/block/qcow2.c
> index da56b1a4df..10175fa399 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1613,9 +1613,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>      /* Open external data file */
>      s->data_file = bdrv_open_child(NULL, options, "data-file", bs,
>                                     &child_of_bds, BDRV_CHILD_DATA,
> -                                   true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +                                   true, errp);
> +    if (!s->data_file) {
>          ret = -EINVAL;
>          goto fail;
>      }
> diff --git a/block/quorum.c b/block/quorum.c
> index 6df9449fc2..672b09e13d 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -898,7 +898,6 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
>                         Error **errp)
>  {
>      BDRVQuorumState *s = bs->opaque;
> -    Error *local_err = NULL;
>      QemuOpts *opts = NULL;
>      const char *pattern_str;
>      bool *opened;
> @@ -976,9 +975,8 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
>  
>          s->children[i] = bdrv_open_child(NULL, options, indexstr, bs,
>                                           &child_of_bds, BDRV_CHILD_DATA, false,
> -                                         &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +                                         errp);
> +        if (!s->children[i]) {
>              ret = -EINVAL;
>              goto close_exit;
>          }


