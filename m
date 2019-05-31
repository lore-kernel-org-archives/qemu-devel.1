Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BBC28CC0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 03:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9373422CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 03:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9373422CD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34571 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWXsc-0006Om-OB
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 23:06:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXrm-0005zH-TV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 23:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXrl-00016T-Pw
	for qemu-devel@nongnu.org; Thu, 30 May 2019 23:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWXrl-00013j-Gq
	for qemu-devel@nongnu.org; Thu, 30 May 2019 23:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 824B230821C2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 03:06:00 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B51560CAC;
	Fri, 31 May 2019 03:05:58 +0000 (UTC)
Date: Fri, 31 May 2019 11:05:56 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531030556.GL28587@xz-x1>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-13-peterx@redhat.com>
	<20190530185854.GJ2823@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530185854.GJ2823@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 31 May 2019 03:06:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 12/12] migration: Split log_clear() into
 smaller chunks
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

On Thu, May 30, 2019 at 07:58:55PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Currently we are doing log_clear() right after log_sync() which mostly
> > keeps the old behavior when log_clear() was still part of log_sync().
> > 
> > This patch tries to further optimize the migration log_clear() code
> > path to split huge log_clear()s into smaller chunks.
> > 
> > We do this by spliting the whole guest memory region into memory
> > chunks, whose size is decided by MigrationState.clear_bitmap_shift (an
> > example will be given below).  With that, we don't do the dirty bitmap
> > clear operation on the remote node (e.g., KVM) when we fetch the dirty
> > bitmap, instead we explicitly clear the dirty bitmap for the memory
> > chunk for each of the first time we send a page in that chunk.
> > 
> > Here comes an example.
> > 
> > Assuming the guest has 64G memory, then before this patch the KVM
> > ioctl KVM_CLEAR_DIRTY_LOG will be a single one covering 64G memory.
> > If after the patch, let's assume when the clear bitmap shift is 18,
> > then the memory chunk size on x86_64 will be 1UL<<18 * 4K = 1GB.  Then
> > instead of sending a big 64G ioctl, we'll send 64 small ioctls, each
> > of the ioctl will cover 1G of the guest memory.  For each of the 64
> > small ioctls, we'll only send if any of the page in that small chunk
> > was going to be sent right away.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> > ---
> >  include/exec/ram_addr.h | 75 +++++++++++++++++++++++++++++++++++++++--
> >  migration/migration.c   |  4 +++
> >  migration/migration.h   | 27 +++++++++++++++
> >  migration/ram.c         | 44 ++++++++++++++++++++++++
> >  migration/trace-events  |  1 +
> >  5 files changed, 149 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > index f8930914cd..c85896f4d5 100644
> > --- a/include/exec/ram_addr.h
> > +++ b/include/exec/ram_addr.h
> > @@ -50,8 +50,69 @@ struct RAMBlock {
> >      unsigned long *unsentmap;
> >      /* bitmap of already received pages in postcopy */
> >      unsigned long *receivedmap;
> > +
> > +    /*
> > +     * bitmap of already cleared dirty bitmap.  Set this up to
> 
> Is that description the right way around?  Isn't it set when
> we receive dirty info from the kernel and hence it needs clearing
> in the future?

Right.  I should say "bitmap to track ...".  I'll reword.

> 
> > +     * non-NULL to enable the capability to postpone and split
> > +     * clearing of dirty bitmap on the remote node (e.g., KVM).  The
> > +     * bitmap will be set only when doing global sync.
> > +     *
> > +     * NOTE: this bitmap is different comparing to the other bitmaps
> > +     * in that one bit can represent multiple guest pages (which is
> > +     * decided by the `clear_bmap_shift' variable below).  On
> > +     * destination side, this should always be NULL, and the variable
> > +     * `clear_bmap_shift' is meaningless.
> > +     */
> > +    unsigned long *clear_bmap;
> > +    uint8_t clear_bmap_shift;
> 
> Is this just here as a convenience rather than using the copy in
> the property?

Right.  It seems a bit awkward to use that directly.  Also note that
the other value can be different with this one when it's illegal
(e.g., bigger than CLEAR_BITMAP_SHIFT_MAX or smaller than
CLEAR_BITMAP_SHIFT_MIN).  This value will always be legal and we don't
need to check/assert it every time.

(Hmm, could bmap_shift be different for different ramblocks?  I never
 thought about that but actually, it can, of course)

Regards,

-- 
Peter Xu

