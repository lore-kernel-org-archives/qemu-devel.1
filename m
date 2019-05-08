Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11E9C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A1820578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 10:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A1820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJXG-00058S-MG
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 06:10:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJW2-0004TG-Oa
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOJW1-0002Q4-Ec
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOJW0-0002PR-SB
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:09:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so2499965wme.3
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 03:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Zl/ag0j59R78ioltGC0oApLxj+x2SXVqFcJvsiVMx8k=;
	b=D1mWKd+Dde2QrGFV0R98+bihOcGKWTM0fqbZlHGYGftjHaJiDf0zCRQBUmP9N6yae3
	Ib44JF2WdTmO89nDFlx8wh5tyP8MGW7+/EX3U9nNtTDzM1I2fZiVIDFyQMn2xfKXfkWy
	9K8pFNjq/tIT1CjvRkNwLfisFG/4euPhVXefZDvv4TM6L2UtW9O9LUTSmhN8dTtA6Oqy
	iQcTKX6VLd18UvQzs8slRalZ0GnMb9hQuKQhrvTew6Vr7XZ6aKZK3K/Tk9Xgf1Ozde1m
	YMGBsB9Fjfzq+GXxAV3EjljL/Sv4XV6VJ22lp1dVC0ipLkDxKoY6/l5egX6fWapnadG6
	o5wg==
X-Gm-Message-State: APjAAAXETjYE4ALRqz1tkG82zjkeMEYWlb2mEPAKb3+UeIRNWeuCkJRN
	ceoMxXzs1xsZRXURo/OTyUl6Ow==
X-Google-Smtp-Source: APXvYqwXXn3dHtOKTDBcV6KONfDZGcVgBjYQiZyxVKTqiqXA7MZVg3M2Q+U7W7NSRfbwhae6Ip9anA==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr2582745wmb.100.1557310171791;
	Wed, 08 May 2019 03:09:31 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id j4sm8379510wrw.94.2019.05.08.03.09.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 03:09:31 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190508061523.17666-1-peterx@redhat.com>
	<20190508061523.17666-4-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef78aa6a-0634-f479-72fb-364af13ab037@redhat.com>
Date: Wed, 8 May 2019 12:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508061523.17666-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 03/11] memory: Don't set migration bitmap
 when without migration
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
> Similar to 9460dee4b2 ("memory: do not touch code dirty bitmap unless
> TCG is enabled", 2015-06-05) but for the migration bitmap - we can
> skip the MIGRATION bitmap update if migration not enabled.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/exec/memory.h   |  2 ++
>  include/exec/ram_addr.h | 12 +++++++++++-
>  memory.c                |  2 +-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e6140e8a04..f29300c54d 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -46,6 +46,8 @@
>          OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
>                           TYPE_IOMMU_MEMORY_REGION)
>  
> +extern bool global_dirty_log;
> +
>  typedef struct MemoryRegionOps MemoryRegionOps;
>  typedef struct MemoryRegionMmio MemoryRegionMmio;
>  
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 993fb760f3..86bc8e1a4a 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -348,8 +348,13 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>              if (bitmap[k]) {
>                  unsigned long temp = leul_to_cpu(bitmap[k]);
>  
> -                atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset], temp);
>                  atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
> +
> +                if (global_dirty_log) {
> +                    atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset],
> +                              temp);
> +                }
> +
>                  if (tcg_enabled()) {
>                      atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], temp);
>                  }
> @@ -366,6 +371,11 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>          xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
>      } else {
>          uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
> +
> +        if (!global_dirty_log) {
> +            clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
> +        }
> +
>          /*
>           * bitmap-traveling is faster than memory-traveling (for addr...)
>           * especially when most of the memory is not dirty.
> diff --git a/memory.c b/memory.c
> index 0cce3a6fc5..1cc3531df5 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -38,7 +38,7 @@
>  static unsigned memory_region_transaction_depth;
>  static bool memory_region_update_pending;
>  static bool ioeventfd_update_pending;
> -static bool global_dirty_log = false;
> +bool global_dirty_log;
>  
>  static QTAILQ_HEAD(, MemoryListener) memory_listeners
>      = QTAILQ_HEAD_INITIALIZER(memory_listeners);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

