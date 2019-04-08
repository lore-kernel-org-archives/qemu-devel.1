Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37EC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E0C2147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XBWlNVVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E0C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDWOF-0004LJ-58
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:40:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDWNS-0003xq-ES
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDWNO-00024X-3t
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:40:06 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:49615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDWNN-0001wH-9v; Mon, 08 Apr 2019 11:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=z/RNfwZJ2AQdnO3a49NZpYS09uCkGEXfcWem73lmzoM=; 
	b=XBWlNVVY/1RfSol8c04F9Ub8lBlLkRxhnjiuL8gnppz1rNLGMBgEzjElEWEmNKjJMEcSqYEjuslQWo6oEW2stE67C4n2cpZgZBFNELdeKFYmZ2dwQU7eUMY2NNJNYDzEo8ap35pMicmE/QNmANkU5ym9d/HjIq71eIndcTKmyIo6jdIqq/G+voIezgvsmhE6qtFKe5kHipR4Fb5jYR3m6KYfKvQVWb/ySkMIVJPorsKlTsiO46w7iQPCDunEcrRtsiq3yCzUvz6QTliMIF+Z4ICLmLVn4nLBYY1UiqooYBe9ryLsUOGYHdbXtvNNrinqxnJwkbhnAV8rPiozexYYBg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDWNG-0004FD-9G; Mon, 08 Apr 2019 17:39:54 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDWNG-0007jz-6l; Mon, 08 Apr 2019 17:39:54 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
In-Reply-To: <1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 08 Apr 2019 17:39:54 +0200
Message-ID: <w511s2cy08l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408153954.DNurgESICaLLab_thYcGG6DFJH8L8vpanSiz8GNR0PQ@z>

On Fri 05 Apr 2019 06:56:19 PM CEST, Andrey Shinkevich wrote:
> @@ -232,8 +232,13 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>      StreamBlockJob *s;
>      BlockDriverState *iter;
>      bool bs_read_only;
> +    BlockDriverState *bottom = NULL;
> +    int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
> +
> +    /* Find the bottom node that has the base as its backing image */
> +    bottom = bdrv_find_overlay(bs, base);

What happens if bs == base here ??

> +    /*
> +     * Block all intermediate nodes between bs and bottom (inclusive), because
> +     * they will disappear from the chain after this operation. The streaming
> +     * job reads every block only once, assuming that it doesn't change, so
> +     * forbid writes and resizes.
> +     */
> +    for (iter = bs; iter != bottom; iter = backing_bs(iter)) {
> +        block_job_add_bdrv(&s->common, "intermediate node", backing_bs(iter),
> +                           0, basic_flags, &error_abort);
>      }

This stops when iter == bottom, so bottom is not actually blocked.

> diff --git a/block/trace-events b/block/trace-events
> index 7335a42..5366d45 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -20,7 +20,7 @@ bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_of
>  
>  # stream.c
>  stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
> -stream_start(void *bs, void *base, void *s) "bs %p base %p s %p"
> +stream_start(void *bs, void *bottom, void *s) "bs %p bottom %p s %p"

Is this change still correct? We don't pass bottom anymore.

Berto

