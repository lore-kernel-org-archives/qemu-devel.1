Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A156C41517
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D8421850
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D8421850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqG6S-000430-37
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqG6H-0003eR-GU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqG6G-0003sg-F3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqG6G-0003sY-9h
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8408F30833C1;
 Wed, 24 Jul 2019 12:10:27 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A66F45D71C;
 Wed, 24 Jul 2019 12:10:26 +0000 (UTC)
Date: Wed, 24 Jul 2019 13:10:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190724121024.GH2717@work-vm>
References: <20190722075339.25121-1-richardw.yang@linux.intel.com>
 <20190722075339.25121-3-richardw.yang@linux.intel.com>
 <20190723164703.GN2719@work-vm> <20190724012007.GC2199@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724012007.GC2199@richard>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 24 Jul 2019 12:10:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: extract ram_load_precopy
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
> On Tue, Jul 23, 2019 at 05:47:03PM +0100, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> After cleanup, it would be clear to audience there are two cases
> >> ram_load:
> >> 
> >>   * precopy
> >>   * postcopy
> >> 
> >> And it is not necessary to check postcopy_running on each iteration for
> >> precopy.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  migration/ram.c | 73 +++++++++++++++++++++++++++++++------------------
> >>  1 file changed, 46 insertions(+), 27 deletions(-)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 6bfdfae16e..5f6f07b255 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -4200,40 +4200,26 @@ static void colo_flush_ram_cache(void)
> >>      trace_colo_flush_ram_cache_end();
> >>  }
> >>  
> >> -static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >> +/**
> >> + * ram_load_precopy: load a page in precopy case
> >
> >This comment is wrong - although I realise you copied it from the
> >postcopy case; they don't just load a single page; they load 'pages'
> >
> 
> Thanks for pointing out.
> 
> Actually, I got one confusion in these two load. Compare these two cases, I
> found precopy would handle two more cases:
> 
>   * precopy:  RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>               RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE
>   * postcopy: RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE
> 
> Why postcopy doesn't need to handle the other two cases? Function
> ram_save_target_page() does the same thing in precopy and postcopy. I don't
> find the reason the behavior differs. Would you mind giving me a hint?

Because we don't support either compression or xbzrle with postcopy.
Compression could be fixed, but it needs to make sure it uses the
place-page function to atomically place the page.

xbzrle never gets used during the postcopy stage; it gets used
in the precopy stage in a migration that might switch to postcopy
though.  Since xbzrle relies on optimising differences between
passes, it's
   1) Not needed in postcopy where there's only one final pass
   2) Since the destination is changing RAM, you can't transmit
      deltas relative to the old data, since that data may have
      changed.

Dave

> >Other than that, I think it's OK, so:
> >
> >
> >Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

