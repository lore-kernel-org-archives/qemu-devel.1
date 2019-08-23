Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE90C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B41206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B41206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1C18-000894-QW
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1ByH-0006dr-J4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1ByG-0007IB-8a
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:59:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1ByF-0007H7-Ll
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:59:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3F0FC087353;
 Fri, 23 Aug 2019 15:59:22 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B737960610;
 Fri, 23 Aug 2019 15:59:21 +0000 (UTC)
Date: Fri, 23 Aug 2019 16:59:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190823155919.GO2784@work-vm>
References: <20190802060359.16556-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802060359.16556-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 23 Aug 2019 15:59:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] migration/postcopy: enable compress
 with postcopy
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> This patch enable compress with postcopy.
> 
> This is a RFC and based on some unmerged patch
> 
>   "migration: extract ram_load_precopy"
>   "migration/postcopy: skip compression when postcopy is active"
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/postcopy-ram.c |  3 +--
>  migration/ram.c          | 35 +++++++++++++++++++++--------------
>  2 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index a7e7ec9c22..70b6beb5a9 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1252,8 +1252,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>              }
>              memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
>          }
> -        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
> -                                   rb);
> +        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page, rb);

Please keep these type of cleanups separate.

>      }
>  }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index a0d3bc60b2..c1d6eadf38 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2384,16 +2384,6 @@ static bool save_page_use_compression(RAMState *rs)
>          return false;
>      }
>  
> -    /*
> -     * The decompression threads asynchronously write into RAM
> -     * rather than use the atomic copies needed to avoid
> -     * userfaulting.  It should be possible to fix the decompression
> -     * threads for compatibility in future.
> -     */
> -    if (migration_in_postcopy()) {
> -        return false;
> -    }
> -
>      /*
>       * If xbzrle is on, stop using the data compression after first
>       * round of migration even if compression is enabled. In theory,
> @@ -3433,6 +3423,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          }
>          i++;
>      }
> +
> +    if (migrate_postcopy_ram()) {
> +        flush_compressed_data(rs);
> +    }
> +
>      rcu_read_unlock();
>  
>      /*
> @@ -4019,6 +4014,7 @@ static int ram_load_postcopy(QEMUFile *f)
>          void *place_source = NULL;
>          RAMBlock *block = NULL;
>          uint8_t ch;
> +        int len;
>  
>          addr = qemu_get_be64(f);
>  
> @@ -4036,7 +4032,8 @@ static int ram_load_postcopy(QEMUFile *f)
>  
>          trace_ram_load_postcopy_loop((uint64_t)addr, flags);
>          place_needed = false;
> -        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
> +        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> +                     RAM_SAVE_FLAG_COMPRESS_PAGE)) {
>              block = ram_block_from_stream(f, flags);
>  
>              host = host_from_ram_block_offset(block, addr);
> @@ -4109,6 +4106,17 @@ static int ram_load_postcopy(QEMUFile *f)
>                                           TARGET_PAGE_SIZE);
>              }
>              break;
> +        case RAM_SAVE_FLAG_COMPRESS_PAGE:
> +            all_zero = false;
> +            len = qemu_get_be32(f);
> +            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
> +                error_report("Invalid compressed data length: %d", len);
> +                ret = -EINVAL;
> +                break;
> +            }
> +            decompress_data_with_multi_threads(f, page_buffer, len);
> +            ret |= wait_for_decompress_done();

I think this might work for a 4k page host; but I'm not sure it's
safe on hugepages or ARM/Power where they have bigger pages.
ram_load_postcopy relies on all of the pages within a single hostpage
arriving before the last subpage and that's what then triggers the call
to postcopy_place_page;  that relies on some ordering - but I don't
think that the multiple compress threads on the source have any ordering
between the threads - or am I missing something about how the multiple
threads are organised?

Dave

> +            break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              multifd_recv_sync_main();
> @@ -4130,8 +4138,7 @@ static int ram_load_postcopy(QEMUFile *f)
>              void *place_dest = host + TARGET_PAGE_SIZE - block->page_size;
>  
>              if (all_zero) {
> -                ret = postcopy_place_page_zero(mis, place_dest,
> -                                               block);
> +                ret = postcopy_place_page_zero(mis, place_dest, block);
>              } else {
>                  ret = postcopy_place_page(mis, place_dest,
>                                            place_source, block);
> @@ -4372,6 +4379,7 @@ static int ram_load_precopy(QEMUFile *f)
>          }
>      }
>  
> +    ret |= wait_for_decompress_done();
>      return ret;
>  }
>  
> @@ -4405,7 +4413,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          ret = ram_load_precopy(f);
>      }
>  
> -    ret |= wait_for_decompress_done();
>      rcu_read_unlock();
>      trace_ram_load_complete(ret, seq_iter);
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

