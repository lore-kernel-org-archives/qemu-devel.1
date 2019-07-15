Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CBCC73C66
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 01:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFA5214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 01:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFA5214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmq5p-0000f7-LO
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 21:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hmq5e-0000Gr-NR
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 21:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hmq5d-0000Te-Kh
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 21:47:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hmq5d-0000Rl-Dy
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 21:47:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so6925297pgk.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 18:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J9egI/5jMAPYWV4Yw8vKmKqKKVbkzDCA9KHWbPkxOtI=;
 b=Xz5Nzx0Eudldyy7iI1a9gVEHB29aOgVAd4Kr2AyE6AS/tNgKf3wynxsJzCvVNFhUcw
 b/qNj9WRiO/swmM6/1zLiCdBL+E9dYGowbW82QGL+C/XE5hVjJW27Wq02NKGdkVeB7fL
 ynyS8QWiHnm+01h0Qpt20DjC7p5H3nAlOPCu6tslgXaTgKdS3YUPQj5m/D7ltIgszUNI
 xzKFh1/ckTcd7dXsigBhoXC194iMV/MbpvRvCMnYGCCEenPQWpDupxW1AuIoo8bB5qX1
 Lenjuis54KG++50HNJXkOQ2/17bsU1wSVcbzp2vf2dFwaPVECK6msiIWnQMIm3pyd8Cz
 rclw==
X-Gm-Message-State: APjAAAWfVwdcu/bP5xk0W2iuWdisrIE1iFxJntAl+LeRl6lNj4mvnbMV
 6bXwQphQBq+I77PYIWrfsAQlrA==
X-Google-Smtp-Source: APXvYqy0AEY9gkAqZEzrsovgVHEA/ArAoQHl2hQ1LK7S4VWzzbPM9OJUfpq5alYoqTeVbO015RIRXA==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr24965479pgf.340.1563155259213; 
 Sun, 14 Jul 2019 18:47:39 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i9sm15396320pgo.46.2019.07.14.18.47.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 18:47:38 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 Jul 2019 09:47:29 +0800
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190715014729.GA9050@xz-x1>
References: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: Re: [Qemu-devel] [PATCH] migration: always initial RAMBlock.bmap to
 1 for new migration
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 14, 2019 at 10:51:19PM +0800, Ivan Ren wrote:
> Reproduce the problem:
> migrate
> migrate_cancel
> migrate
> 
> Error happen for memory migration

Can mention "this mostly revert 0315851938 but with comments kept"
when merge...

> 
> The reason as follows:
> 1. qemu start, ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] all set to
>    1 by a series of cpu_physical_memory_set_dirty_range
> 2. migration start:ram_init_bitmaps
>    - memory_global_dirty_log_start: begin log diry
>    - memory_global_dirty_log_sync: sync dirty bitmap to
>      ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
>    - migration_bitmap_sync_range: sync ram_list.
>      dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
>      and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
> 3. migration data...
> 4. migrate_cancel, will stop log dirty
> 5. migration start:ram_init_bitmaps
>    - memory_global_dirty_log_start: begin log diry
>    - memory_global_dirty_log_sync: sync dirty bitmap to
>      ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
>    - migration_bitmap_sync_range: sync ram_list.
>      dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
>      and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
> 
>    Here RAMBlock.bmap only have new logged dirty pages, don't contain
>    the whole guest pages.

Fixes: 03158519384f158

> 
> Signed-off-by: Ivan Ren <ivanren@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

I think this is a bit severe and should be rc2 material.  Dave/Juan?

Thanks,

-- 
Peter Xu

