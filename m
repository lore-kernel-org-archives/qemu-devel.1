Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112FC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEDD20675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEDD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKw1-0003Zo-Fs
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:40:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOKvB-0003Dr-AY
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOKvA-0001nU-3V
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hOKv9-0001n8-SF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:39:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CED5530842B2
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 11:39:34 +0000 (UTC)
Received: from xz-x1 (ovpn-12-65.pek2.redhat.com [10.72.12.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B0FD05D9C8;
	Wed,  8 May 2019 11:39:32 +0000 (UTC)
Date: Wed, 8 May 2019 19:39:29 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190508113929.GE18465@xz-x1>
References: <20190508061523.17666-1-peterx@redhat.com>
	<4df1963e-5b76-4990-6c2f-a66ecd172869@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4df1963e-5b76-4990-6c2f-a66ecd172869@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 08 May 2019 11:39:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/11] kvm/migration: support
 KVM_CLEAR_DIRTY_LOG
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 12:09:00PM +0200, Paolo Bonzini wrote:
> On 08/05/19 01:15, Peter Xu wrote:
> > Design
> > ===================
> > 
> > I started with a naive/stupid design that I always pass all 1's to the
> > KVM for a memory range to clear all the dirty bits within that memory
> > range, but then I encountered guest oops - it's simply because we
> > can't clear any dirty bit from QEMU if we are not _sure_ that the bit
> > is dirty in the kernel.  Otherwise we might accidentally clear a bit
> > that we don't even know of (e.g., the bit was clear in migration's
> > dirty bitmap in QEMU) but actually that page was just being written so
> > QEMU will never remember to migrate that new page again.
> > 
> > The new design is focused on a dirty bitmap cache within the QEMU kvm
> > layer (which is per kvm memory slot).  With that we know what's dirty
> > in the kernel previously (note! the kernel bitmap is still growing all
> > the time so the cache will only be a subset of the realtime kernel
> > bitmap but that's far enough for us) and with that we'll be sure to
> > not accidentally clear unknown dirty pages.
> > 
> > With this method, we can also avoid race when multiple users (e.g.,
> > DIRTY_MEMORY_VGA and DIRTY_MEMORY_MIGRATION) want to clear the bit for
> > multiple time.  If without the kvm memory slot cached dirty bitmap we
> > won't be able to know which bit has been cleared and then if we send
> > the CLEAR operation upon the same bit twice (or more) we can still
> > face the same issue to clear something accidentally while we
> > shouldn't.
> > 
> > Summary: we really need to be careful on what bit to clear otherwise
> > we can face anything after the migration completes.  And I hope this
> > series has considered all about this.
> 
> The disadvantage of this is that you won't clear in the kernel those
> dirty bits that come from other sources (e.g. vhost or
> address_space_map).  This can lead to double-copying of pages.
> 
> Migration already makes a local copy in rb->bmap, and
> memory_region_snapshot_and_clear_dirty can also do the clear.  Would it
> be possible to invoke the clear using rb->bmap instead of the KVMSlot's
> new bitmap?

Do you mean to invoke the clear notifications and deliver the bitmap
from the very top of the stack (for VGA it would probably be the
DirtyBitmapSnapshot, for MIGRATION it's the rb->bmap)?

Actually that's what I did in the first version before I post the work
but I noticed that there seems to have a race condition with the
design.  The problem is we have multiple copies of the same dirty
bitmap from KVM and the race can happen with those multiple users
(bitmaps of the users can be a merged version containing KVM and other
sources like vhost, address_space_map, etc. but let's just make it
simpler to not have them yet).  Here's one possible race condition
(assuming migration has started):

  (1) page P is written by the guest (let's version its data as P1),
      its dirty bit D is set in KVM

  (2) QEMU sync dirty log, fetch D for page P (which is set).  D is
      not cleared in KVM due to MANUAL_PROTECT cap.

  (3) QEMU copies the D bit to all users of dirty bmap (MIGRATION and
      VGA as example).

  (4) MIGRATION code collects bit D in migration bitmap, clear it,
      send CLEAR to KVM to clear the bit on remote (then D in KVM is
      cleared too), send the page P with content P1 to destination.
      CAUTION: when reach here VGA bitmap still has the D bit set.

  (5) page P is written by the guest again (let's version its data as
      P2), bit D set again in KVM.

  (6) VGA code collectes bit D (note! we haven't synced the log again
      so this is the _old_ dirty bit came from step 3 above) in VGA
      bitmap, clear it, send CLEAR to KVM to clear the bit on remote.
      Then D bit in KVM is cleared again.  Until here, D bit in all
      bitmaps are cleared (MIGRATION, VGA, KVM).

  (7) page P is never written again until migration completes (no
      matter whether we sync again D bit will be cleared).

  (8) On destination VM page P will contain content P1 rather than P2,
      this is data loss...

After I noticed it, I added the kvm bitmap layer with the lock to make
sure we won't send the 2nd clear at step (6) above because with the
per memslot bitmap we will be able to know that we've already cleared
a bit by one user so we shouldn't clear it again (as long as we don't
SYNC again).  However later on I just noticed maybe I don't even need
the top layer bitmap at all, because it seems to not bring much
benefit but instead it'll bring lots of more complexity - I'll need to
do bitmap convertions (because upper layer bitmaps are per ramblock,
and kvm bitmaps are per memslot), not to mention I'll need to AND the
two bitmaps (upper layer bitmap, and the QEMU kvm cached bitmap) to
avoid the above race.  So at last I simply removed the top layer
bitmap and only keep the per memslot bitmap as what this series did.

Thanks,

-- 
Peter Xu

