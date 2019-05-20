Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F03C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808592081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808592081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfrC-0005ZK-SB
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:49:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfpt-0004vV-7i
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfps-0000U3-8p
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:48:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hSfps-0000TH-2a
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:48:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so11160740wmh.3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7Ir7GJpdw8eBKbaZLMHLgtUWuGhGm73HuKiMq+waUxM=;
	b=QNLbYzzvYuG1OoA8qN9/h5drzQg31YNSTVOdsFBno/J3SjGBW6x19DTpd8qBixM8oI
	Z+/bN09X1jsrN6Kc7plAWF8c1nrb8i+rUOS5UqhU0DE54Q/+Djf+kJRaIBN0bPzOyDd7
	M1tJLx7YBbAbefbd0dilrHblhZHyMWPoy3aQr/mwRt/VR/To2YFLhOY5thmZ0Hbog5XW
	bZ8XxrFOTtqUaKUvqG4ac4tbGOc8pQUe2FEWoxklibVGkkHn/xs03niY9hF5+NSPJa+y
	/P271RLVHNQTMq2Qg3PbfPTaJ2eowCZlAQ6sZzm40X4HCoNM1sxKLHkuyyaNmAdEJ0pw
	cdbA==
X-Gm-Message-State: APjAAAXPlAHJ2VS+1XvBdfee/dAN4KGTa0TJcEfi/teQHgCaWTEOq+f5
	zSEMHPryzXM8o2wmRhnmxgk5Fw==
X-Google-Smtp-Source: APXvYqySoMiZPw4oqiC3Z/g8DCMrlisZcehH31hefVcSV3VXCZQXFsY22h0MvfEbnDzpuNALZ4tVrQ==
X-Received: by 2002:a05:600c:2289:: with SMTP id
	9mr27518558wmf.106.1558349283070; 
	Mon, 20 May 2019 03:48:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id p8sm6824202wro.0.2019.05.20.03.48.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 03:48:02 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-4-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30752917-8ec0-492c-bba2-e6a31a56e858@redhat.com>
Date: Mon, 20 May 2019 12:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520030839.6795-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 03/15] migration: No need to take rcu
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

On 20/05/19 05:08, Peter Xu wrote:
> cpu_physical_memory_sync_dirty_bitmap() has one RAMBlock* as
> parameter, which means that it must be with RCU read lock held
> already.  Taking it again inside seems redundant.  Removing it.
> Instead comment on the functions about the RCU read lock.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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

The usual way to spell this is "Called within RCU critical section.",
otherwise the patch looks good.

Paolo

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
> index 4c60869226..05f9f36c7c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1678,6 +1678,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>      return ret;
>  }
>  
> +/* Must be with rcu read lock held */
>  static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>                                          ram_addr_t length)
>  {
> 


