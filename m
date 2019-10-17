Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10764FA3733
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF80920854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOvTOawh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF80920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4Xz-0005jW-VQ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4WY-0004ju-7D
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4WW-0000dy-5M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:04:57 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL4WW-0000d2-0A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:04:56 -0400
Received: by mail-ot1-x336.google.com with SMTP id s22so1641858otr.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lm7qLrxU5trYYdcth8KC2Uqd5hobt1aOD4LXrPFBTWc=;
 b=LOvTOawhkOmVfDK+bWfD+f7KBuu6pMmdTxOWlCWhQwgE46yZfHic1kLrGpGz2cwx9s
 RndIWSvAui7LYRT0mINHfKmL4a2tVMmeIE9tFEjfCrzavXLrbie2OZnUljFBzSmG2+T7
 ZM/9Ya7bDry91CHWpwlX56ms1mjVSZV3YdWE3gRPDmtBwh8gkCfaMDyjU6xRV+7JOLp4
 O6GKuut4PU/5+/RyM/zq1QV6CMqcosnx076H8mobps/LSeablJp/ZQ/A1DE/JQ6cyaPG
 fUtC/pDF3rjg5tbQmr8Lxspfw7Z71eugglXu+YLXQOfeTNtEIHT6rd5+76p/UUw9lPt4
 4/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lm7qLrxU5trYYdcth8KC2Uqd5hobt1aOD4LXrPFBTWc=;
 b=psiFwpgrXB0OCvMdwf3hgtQA5ASGyPczyILoSO40xN8SycOb1jeSkeqLCGktVVGe9k
 aoXQGQj/3R59Zny2Xe6p2rUMAOS0spEmwvshuN4K22745W7Uy32AFgbLo1YOQdj5EyGr
 jVrT2UnUMUZ6qVIS07d0Pf1rc4S6FjV2q8Qc0hxS8eISzwoGUxPi7VtTDASTdkYZ7nQS
 ncvye8wUG4fmJ4V4nY2AMzUSM2nm9Luy5bnrvYzFOMq1YZzZpkscjvXzUb1sCRtrLYc9
 UDEgFk/g0O8usMB4IAJgTmgsV3fItbI2QdCdMwIUPJ0UM1oy0qydnFG1Ky4jPjATu2Un
 6KiQ==
X-Gm-Message-State: APjAAAU1YsCdKBgQZTIZol3bNGTkBIQx+ioiKyObMrQHlf82cMRjKwwl
 v7DtD6lg5elDxICkIdvuVflOFvGTK6kCfyOVznZDXQ==
X-Google-Smtp-Source: APXvYqzjCQ1t23z0otc+cbX0ZMMU1i3d4LWKfxw6Dr3bScxrMu5RtyINylD9p5x0rYL/1CIuypqTKev1aJ81tmzbl04=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr2753156otg.91.1571313893207;
 Thu, 17 Oct 2019 05:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191010114300.7746-1-mreitz@redhat.com>
 <20191010114300.7746-34-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-34-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 13:04:42 +0100
Message-ID: <CAFEAcA_jV_C1W_EsffV2vv9FjupV2ONTZ1wOxTLBmy76Gh5FgQ@mail.gmail.com>
Subject: Re: [PULL 33/36] block/backup: use backup-top instead of write
 notifiers
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 at 12:44, Max Reitz <mreitz@redhat.com> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Drop write notifiers and use filter node instead.

Hi; after this change Coverity complains about dead code in
backup_job_create() (CID 1406402):

> @@ -382,6 +353,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>      BackupBlockJob *job = NULL;
>      int64_t cluster_size;
>      BdrvRequestFlags write_flags;
> +    BlockDriverState *backup_top = NULL;
> +    BlockCopyState *bcs = NULL;
>
>      assert(bs);
>      assert(target);
> @@ -463,33 +436,35 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>      write_flags = (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
>                    (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
>
> +    backup_top = bdrv_backup_top_append(bs, target, filter_node_name,
> +                                        cluster_size, write_flags, &bcs, errp);
> +    if (!backup_top) {
> +        goto error;
> +    }
> +
>      /* job->len is fixed, so we can't allow resize */
> -    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK_PERM_ALL,
> +    job = block_job_create(job_id, &backup_job_driver, txn, backup_top,
> +                           0, BLK_PERM_ALL,
>                             speed, creation_flags, cb, opaque, errp);
>      if (!job) {
>          goto error;
>      }
>
> +    job->backup_top = backup_top;
>      job->source_bs = bs;
>      job->on_source_error = on_source_error;
>      job->on_target_error = on_target_error;
>      job->sync_mode = sync_mode;
>      job->sync_bitmap = sync_bitmap;
>      job->bitmap_mode = bitmap_mode;
> -
> -    job->bcs = block_copy_state_new(bs, target, cluster_size, write_flags,
> -                                    errp);
> -    if (!job->bcs) {
> -        goto error;
> -    }
> -

This code deletion has removed the only code path that can
reach the 'error' label after the successful creation of the job...

> +    job->bcs = bcs;
>      job->cluster_size = cluster_size;
>      job->len = len;
>
> -    block_copy_set_callbacks(job->bcs, backup_progress_bytes_callback,
> +    block_copy_set_callbacks(bcs, backup_progress_bytes_callback,
>                               backup_progress_reset_callback, job);
>
> -    /* Required permissions are already taken by block-copy-state target */
> +    /* Required permissions are already taken by backup-top target */
>      block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
>                         &error_abort);
>
> @@ -502,6 +477,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>      if (job) {
>          backup_clean(&job->common.job);
>          job_early_fail(&job->common.job);

...so down here in the 'error:' code the "if (job)" condition
can never pass, and the code in this part of the if statement
is dead.

> +    } else if (backup_top) {
> +        bdrv_backup_top_drop(backup_top);
>      }
>
>      return NULL;
>  {"return": {}}

thanks
-- PMM

