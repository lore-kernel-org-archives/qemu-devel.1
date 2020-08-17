Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD16C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD47C2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEiK6h7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD47C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bLK-0003hf-3N
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7ay2-0004Tx-2z
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k7axz-00062x-Uj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597654686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dgmctd3manNBQBiaD9YImAfOH4rP+7lahcnG09PTuBU=;
 b=bEiK6h7jeLx8t6oxJvIJ0SlYHs3+LY0NRKrHy+slLEtEbUrOl9MX1teE6IGI0VhpS9bXgH
 X+oZu1jCggMFq/OTVV5VQjAf/lmuBCnxpb8TXol6evPmasV1RUD8ulG7DgU6LFFsabSm/O
 70kYxH5oIYVfGvPHtq7mLYsbZt1MIi4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-gZHaR9HwORe0FfdO6Baj-A-1; Mon, 17 Aug 2020 04:58:04 -0400
X-MC-Unique: gZHaR9HwORe0FfdO6Baj-A-1
Received: by mail-wr1-f71.google.com with SMTP id 89so6727821wrr.15
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Dgmctd3manNBQBiaD9YImAfOH4rP+7lahcnG09PTuBU=;
 b=X6unXmJ4hvqzcqG10TwF0Rx8c5sNypXJdU+bgHlVO4dJxa0D+Cs9xP595KQOiyzS7a
 yl0lWe5EbtEvLgrZLVFqOnjLmXWcZc0IoEZ05thtO+Jl8q3u/hduUmDQLJ26LIkprmUa
 +NHGJeFMM5mzyf24VHxuflIlp5tTnup8G8GHwkU/Z5Ywprxb7XzCeTg3C9jl+sJW+afJ
 ELyiXN61eOB/01fUrY215EClU1QBWUiC6sPB7Xj+9is606JWsV+dljUYhzeY15S79241
 DlxGNb0mv4yNY1MyChDCeLGPDnXolLBMxas0dCv68cfoKQ64DYp60Af6hXA90b5Fk1/G
 njEw==
X-Gm-Message-State: AOAM5306pcTvHuLrJXn7BfmeLADwMoPSOn9I1dXdg79BKEJgE0UCoGH6
 ncJM5hUjpCwXr/awX9auHObCDMgpjfPwAEWwadTBcWYKBTpV4QauxS2ajKWE8LAIQdO3KYJjlNC
 2baSPPYJ6MozkDdA=
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr13782838wme.18.1597654682975; 
 Mon, 17 Aug 2020 01:58:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCd6m7Ky9fwp4Ds+T8KkpCtgW6QjU38AQqTmqv+At6v3NMu7IS6SnvthglT55N3Q+mPHS4IQ==
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr13782810wme.18.1597654682719; 
 Mon, 17 Aug 2020 01:58:02 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id i14sm36532069wrc.19.2020.08.17.01.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:58:02 -0700 (PDT)
Date: Mon, 17 Aug 2020 10:57:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 10/12] block/file-posix: fix a possible undefined behavior
Message-ID: <20200817085658.tvxnqvw6gjyxozie@steredhat>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-11-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200814160241.7915-11-pannengyuan@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 euler.robot@huawei.com, kuhn.chenqun@huawei.com,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 12:02:39PM -0400, Pan Nengyuan wrote:
> local_err is not initialized to NULL, it will cause a assert error as below:
> qemu/util/error.c:59: error_setv: Assertion `*errp == NULL' failed.
> 
> Fixes: c6447510690
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Aarushi Mehta <mehta.aaru20@gmail.com>
> Cc: qemu-block@nongnu.org
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 9a00d4190a..697a7d9eea 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2113,7 +2113,7 @@ static void raw_aio_attach_aio_context(BlockDriverState *bs,
>  #endif
>  #ifdef CONFIG_LINUX_IO_URING
>      if (s->use_linux_io_uring) {
> -        Error *local_err;
> +        Error *local_err = NULL;
>          if (!aio_setup_linux_io_uring(new_context, &local_err)) {
>              error_reportf_err(local_err, "Unable to use linux io_uring, "
>                                           "falling back to thread pool: ");
> -- 
> 2.18.2
> 
> 


