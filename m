Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979FEC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A480217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A480217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvmLT-0005dd-Oq
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 13:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35501)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvmKx-00053e-NO
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvmKw-00016N-NG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:36:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvmKw-00015g-I4
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B66BC00A166;
 Thu,  8 Aug 2019 17:36:25 +0000 (UTC)
Received: from work-vm (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F08D608A7;
 Thu,  8 Aug 2019 17:36:23 +0000 (UTC)
Date: Thu, 8 Aug 2019 18:36:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190808173621.GM2852@work-vm>
References: <20190808033155.30162-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808033155.30162-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 08 Aug 2019 17:36:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] migration: rename
 migration_bitmap_sync_range to ramblock_sync_dirty_bitmap
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Rename for better understanding of the code.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

> 
> ---
> v2:
>   * rebase on top of "just pass RAMBlock is enough"
> 
> ---
>  migration/ram.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index eee68a7991..0d12fa8e92 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1748,7 +1748,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>  }
>  
>  /* Called with RCU critical section */
> -static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb)
> +static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
>  {
>      rs->migration_dirty_pages +=
>          cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
> @@ -1840,7 +1840,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        migration_bitmap_sync_range(rs, block);
> +        ramblock_sync_dirty_bitmap(rs, block);
>      }
>      ram_counters.remaining = ram_bytes_remaining();
>      rcu_read_unlock();
> @@ -4261,7 +4261,7 @@ static void colo_flush_ram_cache(void)
>      memory_global_dirty_log_sync();
>      rcu_read_lock();
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        migration_bitmap_sync_range(ram_state, block);
> +        ramblock_sync_dirty_bitmap(ram_state, block);
>      }
>      rcu_read_unlock();
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

