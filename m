Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C603C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 17:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8410206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 17:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8410206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs9qL-00049f-Pr
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 13:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46317)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hs9pr-0003hJ-QG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hs9pq-0006Lw-RW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hs9pq-0006HG-MA; Mon, 29 Jul 2019 13:53:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26FA5307D978;
 Mon, 29 Jul 2019 17:53:21 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3AAE600F8;
 Mon, 29 Jul 2019 17:53:17 +0000 (UTC)
Date: Mon, 29 Jul 2019 18:53:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190729175315.GK2756@work-vm>
References: <20190729145229.4333-1-imammedo@redhat.com>
 <20190729145229.4333-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729145229.4333-2-imammedo@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 29 Jul 2019 17:53:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] memory: make MemoryRegion alias
 migratable
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
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Igor Mammedov (imammedo@redhat.com) wrote:
> use qemu_ram_alloc_from_ptr() to create aliased RAMBlock
> to the part of original memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  exec.c   | 7 ++++---
>  memory.c | 5 +++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 3e78de3b8f..daef0cd54f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2313,7 +2313,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>                                          new_block->used_length,
>                                          DIRTY_CLIENTS_ALL);
>  
> -    if (new_block->host) {
> +    if (new_block->host && !new_block->mr->alias) {
>          qemu_ram_setup_dump(new_block->host, new_block->max_length);
>          qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
>          /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
> @@ -2671,7 +2671,8 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>  
>      rcu_read_lock();
>      block = atomic_rcu_read(&ram_list.mru_block);
> -    if (block && block->host && host - block->host < block->max_length) {
> +    if (block && !block->mr->alias && block->host &&
> +        host - block->host < block->max_length) {
>          goto found;
>      }
>  
> @@ -2680,7 +2681,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>          if (block->host == NULL) {
>              continue;
>          }
> -        if (host - block->host < block->max_length) {
> +        if (!block->mr->alias && host - block->host < block->max_length) {
>              goto found;
>          }
>      }
> diff --git a/memory.c b/memory.c
> index 5d8c9a9234..d710c17a26 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1678,6 +1678,11 @@ void memory_region_init_alias(MemoryRegion *mr,
>      memory_region_init(mr, owner, name, size);
>      mr->alias = orig;
>      mr->alias_offset = offset;
> +    if (orig->ram_block && size) {
> +        mr->ram_block = qemu_ram_alloc_from_ptr(size,
> +                                                orig->ram_block->host + offset,
> +                                                mr, &error_fatal);
> +    }
>  }

Doesn't this cause new memory regions to be created in other existing
machines, e.g. x86's mem-smram, or the various PCI vga hacks?

Dave
>  
>  void memory_region_init_rom_nomigrate(MemoryRegion *mr,
> -- 
> 2.18.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

