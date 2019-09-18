Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112CDC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA83821906
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA83821906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVR2-0004zT-3M
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iAVQ5-00048c-SN
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iAVQ4-0005Gd-IJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iAVQ4-0005GL-9q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DF853083362;
 Wed, 18 Sep 2019 08:34:35 +0000 (UTC)
Received: from [10.36.116.238] (ovpn-116-238.ams2.redhat.com [10.36.116.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 694D05D9DC;
 Wed, 18 Sep 2019 08:34:31 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190918052641.21300-1-richard.henderson@linaro.org>
 <20190918052641.21300-2-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <38fead47-5d6e-5f67-c5b0-93273b22c0a7@redhat.com>
Date: Wed, 18 Sep 2019 10:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918052641.21300-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 18 Sep 2019 08:34:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/3] exec: Adjust notdirty tracing
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.09.19 07:26, Richard Henderson wrote:
> The memory_region_tb_read tracepoint is unreachable, since notdirty
> is supposed to apply only to reads.  The memory_region_tb_write
> tracepoint is mis-named, because notdirty is not only used for TB
> invalidation.  It is also used for e.g. VGA RAM updates.
> 
> Replace memory_region_tb_write with memory_notdirty_write, and
> place it in memory_notdirty_write_prepare where it can catch all
> of the instances.  Add memory_notdirty_dirty to log when we no
> longer intercept writes to a page.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  exec.c       | 3 +++
>  memory.c     | 4 ----
>  trace-events | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 8b998974f8..9babe57615 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2755,6 +2755,8 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
>      ndi->size = size;
>      ndi->pages = NULL;
>  
> +    trace_memory_notdirty_write(mem_vaddr, ram_addr, size);
> +
>      assert(tcg_enabled());
>      if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
>          ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
> @@ -2779,6 +2781,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
>      /* we remove the notdirty callback only if the code has been
>         flushed */
>      if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
> +        trace_memory_notdirty_dirty(ndi->mem_vaddr);
>          tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
>      }
>  }
> diff --git a/memory.c b/memory.c
> index b9dd6b94ca..57c44c97db 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -438,7 +438,6 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
> @@ -465,7 +464,6 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
> @@ -490,7 +488,6 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
> @@ -515,7 +512,6 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into a TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
> diff --git a/trace-events b/trace-events
> index 823a4ae64e..5c9a1631e7 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -52,14 +52,14 @@ dma_map_wait(void *dbs) "dbs=%p"
>  find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
>  find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
>  ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
> +memory_notdirty_write(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
> +memory_notdirty_dirty(uint64_t vaddr) "0x%" PRIx64

My only suggestion would be to give slightly better names like

memory_notdirty_write_access()
memory_notdirty_set_dirty()

-- 

Thanks,

David / dhildenb

