Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC1C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C1A206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prgVOION"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C1A206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j550l-0004Vf-Ip
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j550C-00040W-KI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j550B-0006vl-Kf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:53:44 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j550B-0006vH-Gy; Fri, 21 Feb 2020 04:53:43 -0500
Received: by mail-qk1-x743.google.com with SMTP id c20so1296372qkm.1;
 Fri, 21 Feb 2020 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EUfubrhvu8AXMm3943SlgW5+SEQU2dQHLijSnm+K4iI=;
 b=prgVOION0fnaBPXu3FQDkR3Fv6/FJ6wf2rFiRRaMwWaJBdUFRqXSDEnw5c53rBUH5M
 +oZy/g75/8FBKKhdIF2Xj590w2z+/tt7rAWVNi/m38sy79VVZM0MfWxiBvksXOwP+p3N
 Axji4CmiKg7iKqJGtkrtmDUd/u/3UoUytbt5QUZXK219ELoYhoL6XNPXiwYCx5SVDKw8
 OSLaHaKyLV7nMdcZXN3xf3BbVkRR1NR9A6GRd3cmPRKpmttRP8uYk56TUNVzDukgfoza
 oSLQXkWDYWhOcRj96FCdTaINqwQaJ7mTVs3p6CLuKkGQQVT73OnUNVWTuDvBHif/1mMw
 PDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EUfubrhvu8AXMm3943SlgW5+SEQU2dQHLijSnm+K4iI=;
 b=E6+FR9QNUW/6uTacqhiZxsRBEG06h1/kLgB4Gm8asiiAi4Vq1NBE7DSxCTzsZCDX6z
 9LC2vdNXpKfTrWkNXq9sKWew7mpgtmQ4hSSVK0XiGTRVcK9xeWVIzt/a3eSTKI2nUopL
 DxrlGrY+c2uPDip5iqHjDCc6Sq8r+PsAMA3GKIe+jrC5UVxUgVM+46ritX4tGnsaFIWp
 m17AJmA0590hKTd1VngpkC+YGbGPHDN+eGoJcK0/e/LY5gX8JmbsLQw5QochLUITt9tp
 2b4YBrQFeu20jDNnlYxdX7QbtG00uvzoSnqM4vcT1frzHCAbzM5G83nnxSq5ojmTgXbB
 JpIw==
X-Gm-Message-State: APjAAAXSwxVZV1pRIvzs6+8usgrd3nEjzDdJze4niiLP5VkKyNGhc4tj
 zb2rc9zCfKdBy3ou1qFwnLRFXojVPaL613uzEO4=
X-Google-Smtp-Source: APXvYqxUmnpQKWLIy9/x1RQxIMR5NvjGBV12DkhOYuq0DJ+AW3x2EFu83ThmuW4GZrVsL3u9f2VDW7caNLloyzwDBfE=
X-Received: by 2002:ae9:e518:: with SMTP id w24mr31602404qkf.236.1582278822652; 
 Fri, 21 Feb 2020 01:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221093951.1414693-1-stefanha@redhat.com>
In-Reply-To: <20200221093951.1414693-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 21 Feb 2020 09:53:31 +0000
Message-ID: <CAJSP0QU4Nvw5q3U2BMkQKeSB=Rpt9o3t29-hnzULi6yP9A1pQA@mail.gmail.com>
Subject: Re: [PATCH v3] util/async: make bh_aio_poll() O(1)
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 9:40 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The ctx->first_bh list contains all created BHs, including those that
> are not scheduled.  The list is iterated by the event loop and therefore
> has O(n) time complexity with respected to the number of created BHs.
>
> Rewrite BHs so that only scheduled or deleted BHs are enqueued.
> Only BHs that actually require action will be iterated.
>
> One semantic change is required: qemu_bh_delete() enqueues the BH and
> therefore invokes aio_notify().  The
> tests/test-aio.c:test_source_bh_delete_from_cb() test case assumed that
> g_main_context_iteration(NULL, false) returns false after
> qemu_bh_delete() but it now returns true for one iteration.  Fix up the
> test case.
>
> This patch makes aio_compute_timeout() and aio_bh_poll() drop from a CPU
> profile reported by perf-top(1).  Previously they combined to 9% CPU
> utilization when AioContext polling is commented out and the guest has 2
> virtio-blk,num-queues=1 and 99 virtio-blk,num-queues=32 devices.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * Use QSLIST_FOREACH_RCU() and QSLIST_FIRST_RCU() [Paolo]

I forgot to include Paolo's R-b that he gave conditional on making this change:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

