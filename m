Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA3C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B25720578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B25720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJYC-0006VF-K5
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 06:11:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJVs-0004N3-Lp
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJVr-0002N1-NG
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOJVr-0002Mi-HP
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so1166097wrs.11
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 03:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uLPywSGVG+l4McPe07txfigGD5Suwi+ILhFgnuGxY8g=;
	b=LTQ5D0BfYXeVeYz7GZwMUha9u3E15o6RmFfnpi76t0t0renncDOx/msGTpjTsj6Tf6
	zJEaA3DvnG6adJ4QMi0a6p3QH54RewSQb6yPUvQLL5Go7ka23236EEpJFZ9JysX4tX1m
	QJBc/Ke6USnOepx2WdynAgA0fodU/1k0MTsDEWZiJbv0Z1Ey8SzWxQ8cudNR0fxAUbpt
	CyVAcr2khEKixBEG5PvOXDo3YeVBpf+iC99a1Ebiaa+DvHUHrkKJMe1Mx0drvHyfPn5V
	gkR5XDIws3HFodXEv1Hx/eLXO7M94+liQNY0iy3y+X17ZFU5JJNCQFTG0IH8PgZxoAd9
	IZcg==
X-Gm-Message-State: APjAAAX6loxrciK4WkoM+BgO/PMPUzZEEHAVFSnpT1Y3jzAUvx4RZ3uX
	Qeh/61l2PvQ7KbYH2Ssxn7kXCw==
X-Google-Smtp-Source: APXvYqxm30b6777EHbcJ0tky7+uRV6u0dEn/JorGe8uqag2jSWcHsO9KRAsBrgHhzgTkTvLHz2fgcA==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr26127455wrq.207.1557310161988; 
	Wed, 08 May 2019 03:09:21 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	q4sm13049668wrx.25.2019.05.08.03.09.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 03:09:21 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190508061523.17666-1-peterx@redhat.com>
	<20190508061523.17666-2-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d642321-a485-ab75-7526-d81af2944afe@redhat.com>
Date: Wed, 8 May 2019 12:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508061523.17666-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 01/11] migration: No need to take rcu
 during sync_dirty_bitmap
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/19 01:15, Peter Xu wrote:
> cpu_physical_memory_sync_dirty_bitmap() has one RAMBlock* as
> parameter, which means that it must be with RCU read lock held
> already.  Taking it again inside seems redundant.  Removing it.
> Instead comment on the functions about the RCU read lock.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/exec/ram_addr.h | 5 +----
>  migration/ram.c         | 1 +
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 139ad79390..993fb760f3 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -408,6 +408,7 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>  }
>  
>  
> +/* Must be with rcu read lock held */
>  static inline
>  uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                                                 ram_addr_t start,
> @@ -431,8 +432,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                                          DIRTY_MEMORY_BLOCK_SIZE);
>          unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>  
> -        rcu_read_lock();
> -
>          src = atomic_rcu_read(
>                  &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
>  
> @@ -452,8 +451,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                  idx++;
>              }
>          }
> -
> -        rcu_read_unlock();
>      } else {
>          ram_addr_t offset = rb->offset;
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 1ca9ba77b6..3e11806ccd 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1680,6 +1680,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>      return ret;
>  }
>  
> +/* Must be with rcu read lock held */
>  static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>                                          ram_addr_t start, ram_addr_t length)
>  {
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

