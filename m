Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB71C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDA12168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA12168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5DiY-0006En-Q3
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 14:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5Dhs-0005nj-I8
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5Dhp-0008LM-E2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5Dhp-0008L9-5L
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:39:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FCA94904;
 Tue,  3 Sep 2019 18:39:04 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B34A611DB;
 Tue,  3 Sep 2019 18:39:02 +0000 (UTC)
Date: Tue, 3 Sep 2019 19:39:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190903183900.GZ2744@work-vm>
References: <20190802060359.16556-1-richardw.yang@linux.intel.com>
 <20190823155919.GO2784@work-vm>
 <20190826130544.bsypypma2mcqocyy@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826130544.bsypypma2mcqocyy@master>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 03 Sep 2019 18:39:04 +0000 (UTC)
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richard.weiyang@gmail.com) wrote:
> On Fri, Aug 23, 2019 at 04:59:19PM +0100, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> This patch enable compress with postcopy.
> >> 
> >> This is a RFC and based on some unmerged patch
> >> 
> >>   "migration: extract ram_load_precopy"
> >>   "migration/postcopy: skip compression when postcopy is active"
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  migration/postcopy-ram.c |  3 +--
> >>  migration/ram.c          | 35 +++++++++++++++++++++--------------
> >>  2 files changed, 22 insertions(+), 16 deletions(-)
> >> 
> >> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >> index a7e7ec9c22..70b6beb5a9 100644
> >> --- a/migration/postcopy-ram.c
> >> +++ b/migration/postcopy-ram.c
> >> @@ -1252,8 +1252,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> >>              }
> >>              memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
> >>          }
> >> -        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
> >> -                                   rb);
> >> +        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page, rb);
> >
> >Please keep these type of cleanups separate.
> >
> >>      }
> >>  }
> >>  
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index a0d3bc60b2..c1d6eadf38 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -2384,16 +2384,6 @@ static bool save_page_use_compression(RAMState *rs)
> >>          return false;
> >>      }
> >>  
> >> -    /*
> >> -     * The decompression threads asynchronously write into RAM
> >> -     * rather than use the atomic copies needed to avoid
> >> -     * userfaulting.  It should be possible to fix the decompression
> >> -     * threads for compatibility in future.
> >> -     */
> >> -    if (migration_in_postcopy()) {
> >> -        return false;
> >> -    }
> >> -
> >>      /*
> >>       * If xbzrle is on, stop using the data compression after first
> >>       * round of migration even if compression is enabled. In theory,
> >> @@ -3433,6 +3423,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> >>          }
> >>          i++;
> >>      }
> >> +
> >> +    if (migrate_postcopy_ram()) {
> >> +        flush_compressed_data(rs);
> >> +    }
> >> +
> >>      rcu_read_unlock();
> >>  
> >>      /*
> >> @@ -4019,6 +4014,7 @@ static int ram_load_postcopy(QEMUFile *f)
> >>          void *place_source = NULL;
> >>          RAMBlock *block = NULL;
> >>          uint8_t ch;
> >> +        int len;
> >>  
> >>          addr = qemu_get_be64(f);
> >>  
> >> @@ -4036,7 +4032,8 @@ static int ram_load_postcopy(QEMUFile *f)
> >>  
> >>          trace_ram_load_postcopy_loop((uint64_t)addr, flags);
> >>          place_needed = false;
> >> -        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
> >> +        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> >> +                     RAM_SAVE_FLAG_COMPRESS_PAGE)) {
> >>              block = ram_block_from_stream(f, flags);
> >>  
> >>              host = host_from_ram_block_offset(block, addr);
> >> @@ -4109,6 +4106,17 @@ static int ram_load_postcopy(QEMUFile *f)
> >>                                           TARGET_PAGE_SIZE);
> >>              }
> >>              break;
> >> +        case RAM_SAVE_FLAG_COMPRESS_PAGE:
> >> +            all_zero = false;
> >> +            len = qemu_get_be32(f);
> >> +            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
> >> +                error_report("Invalid compressed data length: %d", len);
> >> +                ret = -EINVAL;
> >> +                break;
> >> +            }
> >> +            decompress_data_with_multi_threads(f, page_buffer, len);
> >> +            ret |= wait_for_decompress_done();
> >
> >I think this might work for a 4k page host; but I'm not sure it's
> >safe on hugepages or ARM/Power where they have bigger pages.
> >ram_load_postcopy relies on all of the pages within a single hostpage
> >arriving before the last subpage and that's what then triggers the call
> >to postcopy_place_page;  that relies on some ordering - but I don't
> >think that the multiple compress threads on the source have any ordering
> >between the threads - or am I missing something about how the multiple
> >threads are organised?
> >
> 
> Thanks for your comment. I think you are right. It's me who miss this
> situation.
> 
> One quick fix for this problem is to leverage save_compress_page to do the
> flush before it compress another page. But this would lose the multi-thread
> capability.
> 
> The other way is to have a similar "buf" like the receiving side to hold the
> compressed page and send it after all threads finish compressing.

The problem becomes you then need a buf as big as a host page for each
thread; that gets a bit big for huge pages (although it's not too bad
for 2MB hugepages, and the really big 1GB hugepages are a bad idea for
postcopy anyway).  I'm guessing it's more efficient if the compression
code worked in host pages and you were using host pages anyway -
compressing one 2MB chunk sounds easier than compressing 512x4KB chunks.

> BTW, is multifd have this in order? Looks we can have multifd with postcopy?

I think multifd has the same problem; it's code can set the granularity
of each thread, so I think you could set it to 2MB chunks for example
that would help; but the receive code in multifd_recv_unfill_packet
just sets up an iov, I don't think it uses place_page.

Dave

> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

