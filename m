Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A98206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li1kEYSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A98206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDhD-00044o-3r
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleksandr@redhat.com>)
 id 1jZ8d4-0004fT-Op
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:50:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <oleksandr@redhat.com>)
 id 1jZ8d4-0000rv-1E
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589442601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CvaQsisbBhkvZ9/fGO6MKPG1zUiSENWKmNdoMIn5ApA=;
 b=Li1kEYSZW71XAap4LkDmb2xGriB1bIOsqoBgMgF0bj2XA90TBxWYGhFVGzQZvHrzGqrkDl
 /725ckXvarcw+SBIg5VOXucYBzafZkGpX9NbF1F+SWxM9BJtiAYnY5Jy5muC35yFexTntg
 9VaujTGNM6ehHYqoSq7asRFKfy7uCoc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-9yfIeidSMGmXaSMSezBoCQ-1; Thu, 14 May 2020 03:48:48 -0400
X-MC-Unique: 9yfIeidSMGmXaSMSezBoCQ-1
Received: by mail-wm1-f70.google.com with SMTP id e15so3669294wme.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 00:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CvaQsisbBhkvZ9/fGO6MKPG1zUiSENWKmNdoMIn5ApA=;
 b=rhNdP/zdUR+SZG1DiUJTTiicIRUcPRhWHJwW7v4xsQHnFVGzdAbXRforH9aF2UMbua
 SUKkpB0accFoF7sJKnxP+jvM7+2cgmJjBMP9ruOdjGVdwrRIhke1TEVSyUH4Ql2pcEOZ
 IPK68w0vJ5DTwE7YpWkW5w/7oWKRyP+nGKuf8ePvUwrgQ6YR/ksEZ5B4B55iqR/CS3jh
 n1NPYsOHYTKifmazSwGi/P/6ZggvgBlk98pe+L538CPMLDjI9tGGyUwzvOywn+vTXDks
 62Uerl/p7pg+NTgvwb+LM7mFKWcqc96fs9L2rM88WM0OrNPo/UqFUhPSiFZUjNSy1E61
 1y2g==
X-Gm-Message-State: AOAM533UAOCwLOMSqvZejpCTg1F/UK/MZhA7NWLkEghTmtSGYpb5wZYK
 EWFixMXT1pHRRojGvkmyeac2Z8ndFOl8ZBMr7gPfDN4kAgimNK6uCN8lSRgjCeVq5q2e4Jga0OH
 rMKIDZ1HlAEbih4I=
X-Received: by 2002:adf:a51a:: with SMTP id i26mr3710526wrb.332.1589442527585; 
 Thu, 14 May 2020 00:48:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBBkvq2zQH/CwwQKqJPAn5m1nBU5f938vAMaUMlec5ayAu8k96oKCDQdWd1U7ZEg23nmkOBg==
X-Received: by 2002:adf:a51a:: with SMTP id i26mr3710498wrb.332.1589442527240; 
 Thu, 14 May 2020 00:48:47 -0700 (PDT)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
 by smtp.gmail.com with ESMTPSA id q2sm2654517wrx.60.2020.05.14.00.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 00:48:46 -0700 (PDT)
Date: Thu, 14 May 2020 09:48:45 +0200
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] aio-posix: don't duplicate fd handler deletion in
 fdmon_io_uring_destroy()
Message-ID: <20200514074845.tcub47qfgt7sggfl@butterfly.localdomain>
References: <20200511183630.279750-1-stefanha@redhat.com>
 <20200511183630.279750-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200511183630.279750-2-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=oleksandr@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 May 2020 09:13:25 -0400
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 07:36:29PM +0100, Stefan Hajnoczi wrote:
> The io_uring file descriptor monitoring implementation has an internal
> list of fd handlers that are pending submission to io_uring.
> fdmon_io_uring_destroy() deletes all fd handlers on the list.
> 
> Don't delete fd handlers directly in fdmon_io_uring_destroy() for two
> reasons:
> 1. This duplicates the aio-posix.c AioHandler deletion code and could
>    become outdated if the struct changes.
> 2. Only handlers with the FDMON_IO_URING_REMOVE flag set are safe to
>    remove. If the flag is not set then something still has a pointer to
>    the fd handler. Let aio-posix.c and its user worry about that. In
>    practice this isn't an issue because fdmon_io_uring_destroy() is only
>    called when shutting down so all users have removed their fd
>    handlers, but the next patch will need this!
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c      |  1 +
>  util/fdmon-io_uring.c | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index c3613d299e..8af334ab19 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -679,6 +679,7 @@ void aio_context_destroy(AioContext *ctx)
>  {
>      fdmon_io_uring_destroy(ctx);
>      fdmon_epoll_disable(ctx);
> +    aio_free_deleted_handlers(ctx);
>  }
>  
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index d5a80ed6fb..1d14177df0 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -342,11 +342,18 @@ void fdmon_io_uring_destroy(AioContext *ctx)
>  
>          io_uring_queue_exit(&ctx->fdmon_io_uring);
>  
> -        /* No need to submit these anymore, just free them. */
> +        /* Move handlers due to be removed onto the deleted list */
>          while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
> +            unsigned flags = atomic_fetch_and(&node->flags,
> +                    ~(FDMON_IO_URING_PENDING |
> +                      FDMON_IO_URING_ADD |
> +                      FDMON_IO_URING_REMOVE));
> +
> +            if (flags & FDMON_IO_URING_REMOVE) {
> +                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
> +            }
> +
>              QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
> -            QLIST_REMOVE(node, node);
> -            g_free(node);
>          }
>  
>          ctx->fdmon_ops = &fdmon_poll_ops;

Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>

(run Windows 10 VM with storage accessible via io_uring on qemu v5.0.0
with these 2 patches)

Thank you.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer


