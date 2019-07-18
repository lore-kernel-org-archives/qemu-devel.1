Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D307EC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 08:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89D42173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 08:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89D42173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho1ba-00057a-Rx
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 04:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho1bP-0004ih-AW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 04:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho1bO-0000Cj-9g
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 04:17:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho1bO-0000CL-2V
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 04:17:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so14293557wmc.4
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5W4ftR5mCaVb9P/dqEazkO77YvL5B0NuGQhi9qaSqTA=;
 b=rGIhlgoEM4WU6rMx1Zi2hsrnF7BLMzbG3Xg4Es4jIDY/ZWBQ+zLJvX0r/ourjJAGK5
 1bHoE1IhvpiK0w5ZYc8cSEe8jmEE76jpj6CabNLOQk4hfQVpB9B7cxxI1pzecQ2DLxO9
 wPOPKxSMadL0nBbs/Ms8WZHLKxEiiwpx+S8xWwQIrm3BURi8KvFp3LVQ9veaztE+yYvm
 I5k9us9vgysC4vdwNxO8wdFQHxId/wQfOg/xN8jAO2c5wlC/knoxZCIYunmoREZQqv7A
 pazET4MFg2g/3YYhoLpEjHorOsewsTkgcIUJV13dcOltOyXZ54abhTyPsU/6YQBDbkop
 WFIw==
X-Gm-Message-State: APjAAAXmhBwqXS/sD6Axl2rEDQgjRrUjG1v0Q8SYT5ZFfU2eSc0pcgnr
 Bq8FFYbFakaA86jrlIx1djP8QQ==
X-Google-Smtp-Source: APXvYqzW1f/bflOfD6IlPzbfzwBRdM7DwVzHcuMG0OXwm4ev1QbpiTQjon7lPKd14ox8Mqn7WJwaHg==
X-Received: by 2002:a1c:1b97:: with SMTP id
 b145mr38967805wmb.158.1563437840962; 
 Thu, 18 Jul 2019 01:17:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id u6sm30856424wml.9.2019.07.18.01.17.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 01:17:20 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190718012547.16373-1-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7ea77b75-c4d0-3f98-eedc-6900bb95ffa1@redhat.com>
Date: Thu, 18 Jul 2019 10:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718012547.16373-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] migration: just pass RAMBlock is enough
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 03:25, Wei Yang wrote:
> RAMBlock->used_length is always passed to migration_bitmap_sync_range(),
> which could be retrieved from RAMBlock.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/ram.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 908517fc2b..0a6070d787 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1669,11 +1669,10 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>      return ret;
>  }
>  
> -static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
> -                                        ram_addr_t length)
> +static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb)
>  {
>      rs->migration_dirty_pages +=
> -        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
> +        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
>                                                &rs->num_dirty_pages_period);
>  }
>  
> @@ -1762,7 +1761,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        migration_bitmap_sync_range(rs, block, block->used_length);
> +        migration_bitmap_sync_range(rs, block);
>      }
>      ram_counters.remaining = ram_bytes_remaining();
>      rcu_read_unlock();
> @@ -4193,7 +4192,7 @@ static void colo_flush_ram_cache(void)
>      memory_global_dirty_log_sync();
>      rcu_read_lock();
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        migration_bitmap_sync_range(ram_state, block, block->used_length);
> +        migration_bitmap_sync_range(ram_state, block);
>      }
>      rcu_read_unlock();
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

and in fact we can rename the function to ramblock_sync_dirty_bitmap.

Paolo

