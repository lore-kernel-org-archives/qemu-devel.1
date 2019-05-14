Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E1AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393FB21473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393FB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYKH-00073W-G1
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:22:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQYJ3-0006bg-Fw
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQYJ2-000801-BY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQYJ2-0007xg-3X
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CE45301BE65;
	Tue, 14 May 2019 14:21:13 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 49BBF608AC;
	Tue, 14 May 2019 14:21:11 +0000 (UTC)
Date: Tue, 14 May 2019 15:21:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com
Message-ID: <20190514142108.GG2753@work-vm>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
	<20190430034412.12935-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430034412.12935-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 14 May 2019 14:21:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] migration/ram.c: start of
 cpu_physical_memory_sync_dirty_bitmap is always 0
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Since start of cpu_physical_memory_sync_dirty_bitmap is always 0, we can
> remove this parameter and simplify the calculation a bit.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

So I think you're right it's currently unused; however, lets ask
Paolo: Do we need to keep this parameter for flexiblity?

Dave

> ---
>  include/exec/ram_addr.h | 15 ++++++---------
>  migration/ram.c         |  2 +-
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 9ecd911c3e..3dfb2d52fb 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -409,18 +409,16 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>  
>  static inline
>  uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
> -                                               ram_addr_t start,
>                                                 ram_addr_t length,
>                                                 uint64_t *real_dirty_pages)
>  {
>      ram_addr_t addr;
> -    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
> +    unsigned long word = BIT_WORD(rb->offset >> TARGET_PAGE_BITS);
>      uint64_t num_dirty = 0;
>      unsigned long *dest = rb->bmap;
>  
> -    /* start address and length is aligned at the start of a word? */
> -    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
> -         (start + rb->offset) &&
> +    /* offset and length is aligned at the start of a word? */
> +    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) == (rb->offset) &&
>          !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
>          int k;
>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
> @@ -428,14 +426,13 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>          unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
>          unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
>                                          DIRTY_MEMORY_BLOCK_SIZE);
> -        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>  
>          rcu_read_lock();
>  
>          src = atomic_rcu_read(
>                  &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
>  
> -        for (k = page; k < page + nr; k++) {
> +        for (k = 0; k < nr; k++) {
>              if (src[idx][offset]) {
>                  unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>                  unsigned long new_dirty;
> @@ -458,11 +455,11 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>  
>          for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
>              if (cpu_physical_memory_test_and_clear_dirty(
> -                        start + addr + offset,
> +                        addr + offset,
>                          TARGET_PAGE_SIZE,
>                          DIRTY_MEMORY_MIGRATION)) {
>                  *real_dirty_pages += 1;
> -                long k = (start + addr) >> TARGET_PAGE_BITS;
> +                long k = addr >> TARGET_PAGE_BITS;
>                  if (!test_and_set_bit(k, dest)) {
>                      num_dirty++;
>                  }
> diff --git a/migration/ram.c b/migration/ram.c
> index 9948b2d021..1def8122e9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1646,7 +1646,7 @@ static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>                                          ram_addr_t length)
>  {
>      rs->migration_dirty_pages +=
> -        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
> +        cpu_physical_memory_sync_dirty_bitmap(rb, length,
>                                                &rs->num_dirty_pages_period);
>  }
>  
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

