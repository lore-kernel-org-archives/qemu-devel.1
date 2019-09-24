Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB34C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643DA2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643DA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChv4-0003Gv-L9
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 06:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iChu7-0002Lx-RY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iChu6-00071r-5n
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:18:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iChu5-00071a-TO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28F5B3007C5E;
 Tue, 24 Sep 2019 10:18:41 +0000 (UTC)
Received: from work-vm (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2B02600CC;
 Tue, 24 Sep 2019 10:18:39 +0000 (UTC)
Date: Tue, 24 Sep 2019 11:18:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/3] migration/postcopy: unsentmap is not necessary for
 postcopy
Message-ID: <20190924101837.GB2725@work-vm>
References: <20190819061843.28642-1-richardw.yang@linux.intel.com>
 <20190819061843.28642-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819061843.28642-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 24 Sep 2019 10:18:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
> Commit f3f491fcd6dd594ba695 ('Postcopy: Maintain unsentmap') introduced
> unsentmap to track not yet sent pages.
> 
> This is not necessary since:
> 
>     * unsentmap is a sub-set of bmap before postcopy start
>     * unsentmap is the summation of bmap and unsentmap after canonicalizing
> 
> This patch just removes it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Yes, that's simpler


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/exec/ram_addr.h |  6 ----
>  migration/ram.c         | 80 ++++++++---------------------------------
>  2 files changed, 14 insertions(+), 72 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index a327a80cfe..e96e621de5 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -44,12 +44,6 @@ struct RAMBlock {
>      size_t page_size;
>      /* dirty bitmap used during migration */
>      unsigned long *bmap;
> -    /* bitmap of pages that haven't been sent even once
> -     * only maintained and used in postcopy at the moment
> -     * where it's used to send the dirtymap at the start
> -     * of the postcopy phase
> -     */
> -    unsigned long *unsentmap;
>      /* bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 075ddc468c..066eb4755f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2348,7 +2348,7 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
>              dirty = test_bit(page, block->bmap);
>              if (!dirty) {
>                  trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
> -                       page, test_bit(page, block->unsentmap));
> +                       page, test_bit(page, block->bmap));

We could actually lose that last trace parameter.

Dave

>              } else {
>                  trace_get_queued_page(block->idstr, (uint64_t)offset, page);
>              }
> @@ -2619,10 +2619,6 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
>          }
>  
>          pages += tmppages;
> -        if (pss->block->unsentmap) {
> -            clear_bit(pss->page, pss->block->unsentmap);
> -        }
> -
>          pss->page++;
>      } while ((pss->page & (pagesize_bits - 1)) &&
>               offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS));
> @@ -2776,8 +2772,6 @@ static void ram_save_cleanup(void *opaque)
>          block->clear_bmap = NULL;
>          g_free(block->bmap);
>          block->bmap = NULL;
> -        g_free(block->unsentmap);
> -        block->unsentmap = NULL;
>      }
>  
>      xbzrle_cleanup();
> @@ -2857,8 +2851,6 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>   * Returns zero on success
>   *
>   * Callback from postcopy_each_ram_send_discard for each RAMBlock
> - * Note: At this point the 'unsentmap' is the processed bitmap combined
> - *       with the dirtymap; so a '1' means it's either dirty or unsent.
>   *
>   * @ms: current migration state
>   * @block: RAMBlock to discard
> @@ -2867,17 +2859,17 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms, RAMBlock *block)
>  {
>      unsigned long end = block->used_length >> TARGET_PAGE_BITS;
>      unsigned long current;
> -    unsigned long *unsentmap = block->unsentmap;
> +    unsigned long *bitmap = block->bmap;
>  
>      for (current = 0; current < end; ) {
> -        unsigned long one = find_next_bit(unsentmap, end, current);
> +        unsigned long one = find_next_bit(bitmap, end, current);
>          unsigned long zero, discard_length;
>  
>          if (one >= end) {
>              break;
>          }
>  
> -        zero = find_next_zero_bit(unsentmap, end, one + 1);
> +        zero = find_next_zero_bit(bitmap, end, one + 1);
>  
>          if (zero >= end) {
>              discard_length = end - one;
> @@ -2938,16 +2930,12 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
>   * clean, not a mix.  This function canonicalizes the bitmaps.
>   *
>   * @ms: current migration state
> - * @unsent_pass: if true we need to canonicalize partially unsent host pages
> - *               otherwise we need to canonicalize partially dirty host pages
>   * @block: block that contains the page we want to canonicalize
>   */
> -static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
> -                                          RAMBlock *block)
> +static void postcopy_chunk_hostpages_pass(MigrationState *ms, RAMBlock *block)
>  {
>      RAMState *rs = ram_state;
>      unsigned long *bitmap = block->bmap;
> -    unsigned long *unsentmap = block->unsentmap;
>      unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
>      unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
>      unsigned long run_start;
> @@ -2957,13 +2945,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>          return;
>      }
>  
> -    if (unsent_pass) {
> -        /* Find a sent page */
> -        run_start = find_next_zero_bit(unsentmap, pages, 0);
> -    } else {
> -        /* Find a dirty page */
> -        run_start = find_next_bit(bitmap, pages, 0);
> -    }
> +    /* Find a dirty page */
> +    run_start = find_next_bit(bitmap, pages, 0);
>  
>      while (run_start < pages) {
>  
> @@ -2973,11 +2956,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>           */
>          if (QEMU_IS_ALIGNED(run_start, host_ratio)) {
>              /* Find the end of this run */
> -            if (unsent_pass) {
> -                run_start = find_next_bit(unsentmap, pages, run_start + 1);
> -            } else {
> -                run_start = find_next_zero_bit(bitmap, pages, run_start + 1);
> -            }
> +            run_start = find_next_zero_bit(bitmap, pages, run_start + 1);
>              /*
>               * If the end isn't at the start of a host page, then the
>               * run doesn't finish at the end of a host page
> @@ -2994,9 +2973,6 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>              /* Clean up the bitmap */
>              for (page = fixup_start_addr;
>                   page < fixup_start_addr + host_ratio; page++) {
> -                /* All pages in this host page are now not sent */
> -                set_bit(page, unsentmap);
> -
>                  /*
>                   * Remark them as dirty, updating the count for any pages
>                   * that weren't previously dirty.
> @@ -3005,13 +2981,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>              }
>          }
>  
> -        if (unsent_pass) {
> -            /* Find the next sent page for the next iteration */
> -            run_start = find_next_zero_bit(unsentmap, pages, run_start);
> -        } else {
> -            /* Find the next dirty page for the next iteration */
> -            run_start = find_next_bit(bitmap, pages, run_start);
> -        }
> +        /* Find the next dirty page for the next iteration */
> +        run_start = find_next_bit(bitmap, pages, run_start);
>      }
>  }
>  
> @@ -3033,13 +3004,10 @@ static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
>  {
>      postcopy_discard_send_init(ms, block->idstr);
>  
> -    /* First pass: Discard all partially sent host pages */
> -    postcopy_chunk_hostpages_pass(ms, true, block);
>      /*
> -     * Second pass: Ensure that all partially dirty host pages are made
> -     * fully dirty.
> +     * Ensure that all partially dirty host pages are made fully dirty.
>       */
> -    postcopy_chunk_hostpages_pass(ms, false, block);
> +    postcopy_chunk_hostpages_pass(ms, block);
>  
>      postcopy_discard_send_finish(ms);
>      return 0;
> @@ -3077,19 +3045,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      rs->last_page = 0;
>  
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        unsigned long pages = block->used_length >> TARGET_PAGE_BITS;
> -        unsigned long *bitmap = block->bmap;
> -        unsigned long *unsentmap = block->unsentmap;
> -
> -        if (!unsentmap) {
> -            /* We don't have a safe way to resize the sentmap, so
> -             * if the bitmap was resized it will be NULL at this
> -             * point.
> -             */
> -            error_report("migration ram resized during precopy phase");
> -            rcu_read_unlock();
> -            return -EINVAL;
> -        }
>          /* Deal with TPS != HPS and huge pages */
>          ret = postcopy_chunk_hostpages(ms, block);
>          if (ret) {
> @@ -3097,12 +3052,9 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>              return ret;
>          }
>  
> -        /*
> -         * Update the unsentmap to be unsentmap = unsentmap | dirty
> -         */
> -        bitmap_or(unsentmap, unsentmap, bitmap, pages);
>  #ifdef DEBUG_POSTCOPY
> -        ram_debug_dump_bitmap(unsentmap, true, pages);
> +        ram_debug_dump_bitmap(block->bmap, true,
> +                              block->used_length >> TARGET_PAGE_BITS);
>  #endif
>      }
>      trace_ram_postcopy_send_discard_bitmap();
> @@ -3270,10 +3222,6 @@ static void ram_list_init_bitmaps(void)
>              bitmap_set(block->bmap, 0, pages);
>              block->clear_bmap_shift = shift;
>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> -            if (migrate_postcopy_ram()) {
> -                block->unsentmap = bitmap_new(pages);
> -                bitmap_set(block->unsentmap, 0, pages);
> -            }
>          }
>      }
>  }
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

