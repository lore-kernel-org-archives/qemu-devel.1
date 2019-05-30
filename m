Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF5C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F8125813
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F8125813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJ9P-0003zJ-LJ
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:23:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWJ8M-0003Ys-5g
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWJ8L-0006Pm-58
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hWJ8K-0006Nv-VK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:22:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 380F19FFF2
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 11:22:08 +0000 (UTC)
Received: from work-vm (ovpn-117-91.ams2.redhat.com [10.36.117.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 085047944B;
	Thu, 30 May 2019 11:22:02 +0000 (UTC)
Date: Thu, 30 May 2019 12:22:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190530112200.GE2823@work-vm>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530092919.26059-7-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 30 May 2019 11:22:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 06/12] memory: Pass mr into
 snapshot_and_clear_dirty
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Also we change the 2nd parameter of it to be the relative offset
> within the memory region. This is to be used in follow up patches.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  exec.c                  | 3 ++-
>  include/exec/ram_addr.h | 2 +-
>  memory.c                | 3 +--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 4e734770c2..2615b4cfed 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1387,9 +1387,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
>  }
>  
>  DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
> -     (ram_addr_t start, ram_addr_t length, unsigned client)
> +(MemoryRegion *mr, hwaddr addr, hwaddr length, unsigned client)

Better to keep some indent?

>  {
>      DirtyMemoryBlocks *blocks;
> +    ram_addr_t start = memory_region_get_ram_addr(mr) + addr;
>      unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
>      ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
>      ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 79e70a96ee..f8ee011d3c 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -403,7 +403,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
>                                                unsigned client);
>  
>  DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
> -    (ram_addr_t start, ram_addr_t length, unsigned client);
> +(MemoryRegion *mr, ram_addr_t start, hwaddr length, unsigned client);

You've called it 'start' there but 'addr' in the definition.
Either way a comment saying that it's the offset with mr would be good.

Dave

>  
>  bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
>                                              ram_addr_t start,
> diff --git a/memory.c b/memory.c
> index cff0ea8f40..84bba7b65c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2071,8 +2071,7 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
>  {
>      assert(mr->ram_block);
>      memory_region_sync_dirty_bitmap(mr);
> -    return cpu_physical_memory_snapshot_and_clear_dirty(
> -                memory_region_get_ram_addr(mr) + addr, size, client);
> +    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
>  }
>  
>  bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

