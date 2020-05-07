Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DCC47247
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49102082E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2SWbDey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49102082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiuf-0006mP-Q8
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWipG-0001Vk-Mi
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:52:42 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:44010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWipD-00054T-SK
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:52:42 -0400
Received: by mail-oi1-x235.google.com with SMTP id j16so5563653oih.10
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uHhlNWa+QHqY3duorH8jkUvSE//0HmWIYr7IEJS9ufE=;
 b=G2SWbDey39tKmJJxMAgQCICFUkjHNSj/g5lraSk+imyq/kHTwxmm1mYHNTb5ZtfjjC
 hS+EiisYEqLAQ2wQoVjLpxfoMPJb3tsA5ydkZr/URiCYVEjqHY0wguKiQH/X2utCGGkf
 pbvXJ4lJ5U3FX5MTN/P4Wl72jZb3QoAwSHVZKZnOwFQOpqcJQ3gLQjUiSqP05cbGcgYE
 SUg+Y3HJITI3QHm05acbXFWeq9qOREn+iA6c8Y/ZkZQvzt+V/XdkZNCpjuurlLf3j5/d
 F1sWsSxCtpWnsRfcgPLJAKrjRuI5xmnUPJfB2krSzOeHYSQK3UdswcHDML/c4CN0GhYB
 iM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uHhlNWa+QHqY3duorH8jkUvSE//0HmWIYr7IEJS9ufE=;
 b=m9mXrdgEA/2Urw57OPFf+3AlzmfJMfYrmIWSb58f9TGXpZrgvL0vkwONsU3IxJ/b7K
 4Db1ByuoSFFt755XpQPlERraR8rnuQYdbbmX7JmDD2udO2ybEpgkcwTj7KmkePa985Pq
 RC5q86ai2ENl3I3KCEa3d0AmTgoC2QZ8M9P+HHj2onVsGXb/6VM0SN74LA9lQerFrKVJ
 kcfvhI9RHF9mPnfQfE87/43yvJyeFFEurca7Gt3kEf1bTD0hvjfJDVj7VNEtSC6RC6Ch
 AeelE4TYhhfPF3CvVb/+u9H3n3LPZcALUg3zTTc2MqYFaPiuHso2tzlUMOGBIbVVNP/K
 3nlw==
X-Gm-Message-State: AGi0PuYuU1W1UiKIbmITzSwnfWOl2Ldr6o2LKm99jChd4CcflfDm0LMf
 P+AOvAfhTrWTE1PGSyDBZKtY5BuoRv+yUSTGkG3wUg==
X-Google-Smtp-Source: APiQypI+3eq8irjprUxtIu0bZlqjzePEkdIjUTl+JkKroxfBMK2VP+ZQT8jXzCDLdDFdw1SW5BqRtuD3W+l5DHUcBoQ=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr6618264oia.48.1588866758239; 
 Thu, 07 May 2020 08:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200505125826.1001451-1-mreitz@redhat.com>
 <20200505125826.1001451-25-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-25-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2020 16:52:27 +0100
Message-ID: <CAFEAcA_H7-YS4kKsoSpPKG5=3mqJNpa034KkNwPpBEgffUiT6g@mail.gmail.com>
Subject: Re: [PULL 24/24] block/block-copy: use aio-task-pool API
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 13:59, Max Reitz <mreitz@redhat.com> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Run block_copy iterations in parallel in aio tasks.
>
> Changes:
>   - BlockCopyTask becomes aio task structure. Add zeroes field to pass
>     it to block_copy_do_copy
>   - add call state - it's a state of one call of block_copy(), shared
>     between parallel tasks. For now used only to keep information about
>     first error: is it read or not.
>   - convert block_copy_dirty_clusters to aio-task loop.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20200429130847.28124-6-vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Hi; this patch seems to introduce a use-after-free (CID 1428756):


> @@ -484,6 +554,8 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>      int ret = 0;
>      bool found_dirty = false;
>      int64_t end = offset + bytes;
> +    AioTaskPool *aio = NULL;
> +    BlockCopyCallState call_state = {false, false};
>
>      /*
>       * block_copy() user is responsible for keeping source and target in same
> @@ -495,11 +567,11 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>
> -    while (bytes) {
> -        g_autofree BlockCopyTask *task = NULL;
> +    while (bytes && aio_task_pool_status(aio) == 0) {
> +        BlockCopyTask *task;
>          int64_t status_bytes;
>
> -        task = block_copy_task_create(s, offset, bytes);
> +        task = block_copy_task_create(s, &call_state, offset, bytes);
>          if (!task) {
>              /* No more dirty bits in the bitmap */
>              trace_block_copy_skip_range(s, offset, bytes);
> @@ -519,6 +591,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
>          }
>          if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>              block_copy_task_end(task, 0);
> +            g_free(task);

This hunk frees 'task' here...

>              progress_set_remaining(s->progress,
>                                     bdrv_get_dirty_count(s->copy_bitmap) +
>                                     s->in_flight_bytes);

...but the next lines after this one (just out of context) are:

            trace_block_copy_skip_range(s, task->offset, task->bytes);
            offset = task_end(task);

which now dereference 'task' after it is freed.

thanks
-- PMM

