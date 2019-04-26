Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8766C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605E92077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cfUd5Sct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605E92077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47588 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1Rk-0004sJ-B8
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 10:03:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Q3-0003rK-Q4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Py-0005eQ-6h
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:01:39 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hK1Pw-0005dO-E5; Fri, 26 Apr 2019 10:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=fuqIgJrfHkhklr9pxnSZyHN8MLMPos0K/i/+JiDhCZA=; 
	b=cfUd5SctTUq24w+9k3j2u5SYYIE+MzZXTQ3oEo729itVAAGHI2nNq6IEwBXEIQwPDj90TBJKJk+6Je4pYA2VDsbgt3LSyLeIg8JmzxNhe/rIF0C65CBV/gJpTL6s7gZcm42T7fVE32le8wO74xSfcCVwp11W5iWsHGXivQ43qdHtCaSSvAO+Q+qcMwmRZegIbDRFfntawbJ4du40mbfErNVBJ3FGk+W17dChzEHwQcyV96HmfbJjxwbgdZDwhIrOFYGzZOYcYhf7IN/ybvUu+5Trly7cXYG2aDV+7L3ACx4MP7u5vDhTeUDOBPXRmMzhtEmvBILCxU4vJzDlIwlzmA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hK1Pr-0005iM-Pi; Fri, 26 Apr 2019 16:01:27 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hK1Pr-0000Ub-Mw; Fri, 26 Apr 2019 16:01:27 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
In-Reply-To: <20190403143748.9790-1-berto@igalia.com>
References: <20190403143748.9790-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Fri, 26 Apr 2019 16:01:27 +0200
Message-ID: <w511s1ohnm0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Use bdrv_append() in
 commit_start()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426140127.qc1kf0lYhzKX_lmUm5I5tKtGucX83hLlkgMK-8dmR6M@z>

ping

On Wed 03 Apr 2019 04:37:48 PM CEST, Alberto Garcia wrote:
> This function combines bdrv_set_backing_hd() and bdrv_replace_node()
> so we can use it to simplify the code a bit in commit_start().
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/block/commit.c b/block/commit.c
> index ba60fef58a..a0beb7d265 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -304,23 +304,14 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>      commit_top_bs->total_sectors = top->total_sectors;
>      bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
>  
> -    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
> +    bdrv_append(commit_top_bs, top, &local_err);
>      if (local_err) {
> -        bdrv_unref(commit_top_bs);
> -        commit_top_bs = NULL;
> -        error_propagate(errp, local_err);
> -        goto fail;
> -    }
> -    bdrv_replace_node(top, commit_top_bs, &local_err);
> -    if (local_err) {
> -        bdrv_unref(commit_top_bs);
>          commit_top_bs = NULL;
>          error_propagate(errp, local_err);
>          goto fail;
>      }
>  
>      s->commit_top_bs = commit_top_bs;
> -    bdrv_unref(commit_top_bs);
>  
>      /* Block all nodes between top and base, because they will
>       * disappear from the chain after this operation. */
> -- 
> 2.11.0

