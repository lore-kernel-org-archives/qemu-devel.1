Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5DDC28CC0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 02:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C68218D9
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 02:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C68218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWXQ0-0000Zm-9j
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 22:37:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXPF-0000I3-4j
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXPE-00009O-5a
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWXPD-00005c-Ve
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6927E3079B81
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:36:30 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73C4A1001E64;
	Fri, 31 May 2019 02:36:28 +0000 (UTC)
Date: Fri, 31 May 2019 10:36:26 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531023626.GH28587@xz-x1>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-7-peterx@redhat.com>
	<20190530112200.GE2823@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530112200.GE2823@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 31 May 2019 02:36:30 +0000 (UTC)
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

On Thu, May 30, 2019 at 12:22:00PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Also we change the 2nd parameter of it to be the relative offset
> > within the memory region. This is to be used in follow up patches.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  exec.c                  | 3 ++-
> >  include/exec/ram_addr.h | 2 +-
> >  memory.c                | 3 +--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index 4e734770c2..2615b4cfed 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1387,9 +1387,10 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
> >  }
> >  
> >  DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
> > -     (ram_addr_t start, ram_addr_t length, unsigned client)
> > +(MemoryRegion *mr, hwaddr addr, hwaddr length, unsigned client)
> 
> Better to keep some indent?

Ok.  Emacs did it automatically for me without being noticed.  The
previous 5-spaces is odd, I'll use 4 spaces.

> 
> >  {
> >      DirtyMemoryBlocks *blocks;
> > +    ram_addr_t start = memory_region_get_ram_addr(mr) + addr;
> >      unsigned long align = 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
> >      ram_addr_t first = QEMU_ALIGN_DOWN(start, align);
> >      ram_addr_t last  = QEMU_ALIGN_UP(start + length, align);
> > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > index 79e70a96ee..f8ee011d3c 100644
> > --- a/include/exec/ram_addr.h
> > +++ b/include/exec/ram_addr.h
> > @@ -403,7 +403,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
> >                                                unsigned client);
> >  
> >  DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
> > -    (ram_addr_t start, ram_addr_t length, unsigned client);
> > +(MemoryRegion *mr, ram_addr_t start, hwaddr length, unsigned client);
> 
> You've called it 'start' there but 'addr' in the definition.
> Either way a comment saying that it's the offset with mr would be good.

Right I missed that.  Let me directly rename it to "offset" in both
places to be clear.  Also, I should use hwaddr rather than ram_addr_t,
and I'll fix the indent too here.

-- 
Peter Xu

