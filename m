Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE3F206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE3F206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPBF-00068P-PH
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGPAC-0005Za-Ql; Thu, 10 Sep 2020 12:11:12 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGPA6-0006Lx-Bj; Thu, 10 Sep 2020 12:11:08 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.252])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7B58F59B1281;
 Thu, 10 Sep 2020 18:10:58 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 10 Sep
 2020 18:10:57 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002e5e6a0bf-332a-4377-a1f9-5e3e594a0a79,
 39F76413F398F3D3265C4F59F57E6F6E33B9D840) smtp.auth=groug@kaod.org
Date: Thu, 10 Sep 2020 18:10:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 02/14] block: use return status of bdrv_append()
Message-ID: <20200910181056.039cd173@bahia.lan>
In-Reply-To: <20200909185930.26524-3-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-3-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 9bf2c249-4a84-40ae-811d-7c0f67fcdb20
X-Ovh-Tracer-Id: 5769674075501402555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
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

On Wed,  9 Sep 2020 21:59:18 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Now bdrv_append returns status and we can drop all the local_err things
> around it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

Just one suggestion for a follow-up below...

>  block.c                     |  5 +----
>  block/backup-top.c          | 20 ++++++++------------
>  block/commit.c              |  5 +----
>  block/mirror.c              |  6 ++----
>  blockdev.c                  |  4 +---
>  tests/test-bdrv-graph-mod.c |  6 +++---
>  6 files changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 6d35449027..9b624b2535 100644
> --- a/block.c
> +++ b/block.c
> @@ -3156,7 +3156,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
>      int64_t total_size;
>      QemuOpts *opts = NULL;
>      BlockDriverState *bs_snapshot = NULL;
> -    Error *local_err = NULL;
>      int ret;
>  
>      /* if snapshot, we create a temporary backing file and open it
> @@ -3203,9 +3202,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
>       * order to be able to return one, we have to increase
>       * bs_snapshot's refcount here */
>      bdrv_ref(bs_snapshot);
> -    bdrv_append(bs_snapshot, bs, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (bdrv_append(bs_snapshot, bs, errp) < 0) {
>          bs_snapshot = NULL;
>          goto out;
>      }
> diff --git a/block/backup-top.c b/block/backup-top.c
> index af2f20f346..de9d5e1634 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c
> @@ -192,7 +192,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>                                           BlockCopyState **bcs,
>                                           Error **errp)
>  {
> -    Error *local_err = NULL;
> +    ERRP_GUARD();
>      BDRVBackupTopState *state;
>      BlockDriverState *top;
>      bool appended = false;
> @@ -225,9 +225,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>      bdrv_drained_begin(source);
>  
>      bdrv_ref(top);
> -    bdrv_append(top, source, &local_err);
> -    if (local_err) {
> -        error_prepend(&local_err, "Cannot append backup-top filter: ");
> +    if (bdrv_append(top, source, errp) < 0) {
> +        error_prepend(errp, "Cannot append backup-top filter: ");
>          goto fail;
>      }
>      appended = true;
> @@ -237,18 +236,16 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>       * we want.
>       */
>      state->active = true;
> -    bdrv_child_refresh_perms(top, top->backing, &local_err);
> -    if (local_err) {
> -        error_prepend(&local_err,
> -                      "Cannot set permissions for backup-top filter: ");
> +    if (bdrv_child_refresh_perms(top, top->backing, errp) < 0) {
> +        error_prepend(errp, "Cannot set permissions for backup-top filter: ");
>          goto fail;
>      }
>  
>      state->cluster_size = cluster_size;
>      state->bcs = block_copy_state_new(top->backing, state->target,
> -                                      cluster_size, write_flags, &local_err);
> -    if (local_err) {
> -        error_prepend(&local_err, "Cannot create block-copy-state: ");
> +                                      cluster_size, write_flags, errp);
> +    if (!state->bcs) {
> +        error_prepend(errp, "Cannot create block-copy-state: ");
>          goto fail;
>      }
>      *bcs = state->bcs;
> @@ -266,7 +263,6 @@ fail:
>      }
>  
>      bdrv_drained_end(source);
> -    error_propagate(errp, local_err);
>  
>      return NULL;
>  }
> diff --git a/block/commit.c b/block/commit.c
> index 7732d02dfe..7720d4729b 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -253,7 +253,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>      CommitBlockJob *s;
>      BlockDriverState *iter;
>      BlockDriverState *commit_top_bs = NULL;
> -    Error *local_err = NULL;
>      int ret;
>  

... this is unrelated but while reviewing I've noticed that the ret
variable isn't really needed.

>      assert(top != bs);
> @@ -292,10 +291,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>  
>      commit_top_bs->total_sectors = top->total_sectors;
>  
> -    bdrv_append(commit_top_bs, top, &local_err);
> -    if (local_err) {
> +    if (bdrv_append(commit_top_bs, top, errp) < 0) {
>          commit_top_bs = NULL;
> -        error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> diff --git a/block/mirror.c b/block/mirror.c
> index e8e8844afc..ca250f765d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1557,7 +1557,6 @@ static BlockJob *mirror_start_job(
>      BlockDriverState *mirror_top_bs;
>      bool target_graph_mod;
>      bool target_is_backing;
> -    Error *local_err = NULL;
>      int ret;
>  
>      if (granularity == 0) {
> @@ -1606,12 +1605,11 @@ static BlockJob *mirror_start_job(
>       * it alive until block_job_create() succeeds even if bs has no parent. */
>      bdrv_ref(mirror_top_bs);
>      bdrv_drained_begin(bs);
> -    bdrv_append(mirror_top_bs, bs, &local_err);
> +    ret = bdrv_append(mirror_top_bs, bs, errp);
>      bdrv_drained_end(bs);
>  
> -    if (local_err) {
> +    if (ret < 0) {
>          bdrv_unref(mirror_top_bs);
> -        error_propagate(errp, local_err);
>          return NULL;
>      }
>  
> diff --git a/blockdev.c b/blockdev.c
> index 3848a9c8ab..36bef6b188 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1576,9 +1576,7 @@ static void external_snapshot_prepare(BlkActionState *common,
>       * can fail, so we need to do it in .prepare; undoing it for abort is
>       * always possible. */
>      bdrv_ref(state->new_bs);
> -    bdrv_append(state->new_bs, state->old_bs, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (bdrv_append(state->new_bs, state->old_bs, errp) < 0) {
>          goto out;
>      }
>      state->overlay_appended = true;
> diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
> index 8cff13830e..2b71601c24 100644
> --- a/tests/test-bdrv-graph-mod.c
> +++ b/tests/test-bdrv-graph-mod.c
> @@ -101,7 +101,7 @@ static BlockDriverState *pass_through_node(const char *name)
>   */
>  static void test_update_perm_tree(void)
>  {
> -    Error *local_err = NULL;
> +    int ret;
>  
>      BlockBackend *root = blk_new(qemu_get_aio_context(),
>                                   BLK_PERM_WRITE | BLK_PERM_CONSISTENT_READ,
> @@ -114,8 +114,8 @@ static void test_update_perm_tree(void)
>      bdrv_attach_child(filter, bs, "child", &child_of_bds,
>                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, &error_abort);
>  
> -    bdrv_append(filter, bs, &local_err);
> -    error_free_or_abort(&local_err);
> +    ret = bdrv_append(filter, bs, NULL);
> +    assert(ret < 0);
>  
>      blk_unref(root);
>  }


