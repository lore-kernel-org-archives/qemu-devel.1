Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A84C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D8E20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D8E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQJC-0000Lw-9H
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:48:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQHz-0008FT-K8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQHy-0004RT-Ic
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:47:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLQHw-0004Pg-0W; Tue, 30 Apr 2019 06:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0052730ADBA6;
	Tue, 30 Apr 2019 10:47:03 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C9806D08F;
	Tue, 30 Apr 2019 10:46:56 +0000 (UTC)
Date: Tue, 30 Apr 2019 12:46:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190430104653.GD5607@linux.fritz.box>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
	<20190422145838.70903-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-5-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 30 Apr 2019 10:47:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/9] block/qed: use buffer-based io
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430104653.YU6TcjK0p3pt6bmoTCAmu435mH8VaQuIMwHqWsbhFpI@z>

Am 22.04.2019 um 16:58 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Move to _co_ versions of io functions qed_read_table() and
> qed_write_table(), as we use qemu_co_mutex_unlock()
> anyway.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qed-table.c | 12 +++++-------
>  block/qed.c       |  6 ++----
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/block/qed-table.c b/block/qed-table.c
> index c497bd4aec..cf30edd977 100644
> --- a/block/qed-table.c
> +++ b/block/qed-table.c
> @@ -21,22 +21,22 @@
>  /* Called with table_lock held.  */
>  static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
>  {
> -    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(
> -        qiov, table->offsets, s->header.cluster_size * s->header.table_size);
> +    unsigned int bytes = s->header.cluster_size * s->header.table_size;
> +
>      int noffsets;
>      int i, ret;
>  
>      trace_qed_read_table(s, offset, table);
>  
>      qemu_co_mutex_unlock(&s->table_lock);
> -    ret = bdrv_preadv(s->bs->file, offset, &qiov);
> +    ret = bdrv_co_pread(s->bs->file, offset, bytes, table->offsets, 0);

Careful! This function is not marked as coroutine_fn, and I remember
that there were some non-coroutine callers when I converted qed to
coroutines.

It looks like we're lucky and all callers have been converted to
coroutines meanwhile, but I would prefer if we added the coroutine_fn
marker everywhere where we rely on it now to document this fact.

>      qemu_co_mutex_lock(&s->table_lock);
>      if (ret < 0) {
>          goto out;
>      }
>  
>      /* Byteswap offsets */
> -    noffsets = qiov.size / sizeof(uint64_t);
> +    noffsets = bytes / sizeof(uint64_t);
>      for (i = 0; i < noffsets; i++) {
>          table->offsets[i] = le64_to_cpu(table->offsets[i]);
>      }
> @@ -66,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
>      unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
>      unsigned int start, end, i;
>      QEDTable *new_table;
> -    QEMUIOVector qiov;
>      size_t len_bytes;
>      int ret;
>  
> @@ -79,7 +78,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
>      len_bytes = (end - start) * sizeof(uint64_t);
>  
>      new_table = qemu_blockalign(s->bs, len_bytes);
> -    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
>  
>      /* Byteswap table */
>      for (i = start; i < end; i++) {
> @@ -91,7 +89,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
>      offset += start * sizeof(uint64_t);
>  
>      qemu_co_mutex_unlock(&s->table_lock);
> -    ret = bdrv_pwritev(s->bs->file, offset, &qiov);
> +    ret = bdrv_co_pwrite(s->bs->file, offset, len_bytes, new_table->offsets, 0);
>      qemu_co_mutex_lock(&s->table_lock);
>      trace_qed_write_table_cb(s, table, flush, ret);
>      if (ret < 0) {

Same for the callers of this function.

Kevin

