Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54122C04A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 02:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2D2216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 02:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2D2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOYtA-00065T-9J
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 22:34:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOYsL-0005jn-1W
	for qemu-devel@nongnu.org; Wed, 08 May 2019 22:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOYsI-00012R-C1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 22:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hOYsI-00011n-5H
	for qemu-devel@nongnu.org; Wed, 08 May 2019 22:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 443593082A28
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 02:33:33 +0000 (UTC)
Received: from xz-x1 (ovpn-12-102.pek2.redhat.com [10.72.12.102])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 178525C269;
	Thu,  9 May 2019 02:33:30 +0000 (UTC)
Date: Thu, 9 May 2019 10:33:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190509023319.GG18465@xz-x1>
References: <20190508061523.17666-1-peterx@redhat.com>
	<4df1963e-5b76-4990-6c2f-a66ecd172869@redhat.com>
	<20190508113929.GE18465@xz-x1>
	<a32b877c-1303-f378-316b-c564a8ccc419@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a32b877c-1303-f378-316b-c564a8ccc419@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 09 May 2019 02:33:33 +0000 (UTC)
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

On Wed, May 08, 2019 at 01:55:07PM +0200, Paolo Bonzini wrote:
> On 08/05/19 06:39, Peter Xu wrote:
> >> The disadvantage of this is that you won't clear in the kernel those
> >> dirty bits that come from other sources (e.g. vhost or
> >> address_space_map).  This can lead to double-copying of pages.
> >>
> >> Migration already makes a local copy in rb->bmap, and
> >> memory_region_snapshot_and_clear_dirty can also do the clear.  Would it
> >> be possible to invoke the clear using rb->bmap instead of the KVMSlot's
> >> new bitmap?
> >
> > Actually that's what I did in the first version before I post the work
> > but I noticed that there seems to have a race condition with the
> > design.  The problem is we have multiple copies of the same dirty
> > bitmap from KVM and the race can happen with those multiple users
> > (bitmaps of the users can be a merged version containing KVM and other
> > sources like vhost, address_space_map, etc. but let's just make it
> > simpler to not have them yet).
> 
> I see now.  And in fact the same double-copying inefficiency happens
> already without this series, so you are improving the situation anyway.
> 
> Have you done any kind of benchmarking already?

Not yet.  I posted the series for some initial reviews first before
moving on with performance tests.

My plan of the test scenario could be:

- find a guest with relatively large memory (I would guess it is
  better to have memory like 64G or even more to make some big
  difference)

- run random dirty memory workload upon most of the mem, with dirty
  rate X Bps.

- setup the migration bandwidth to Y Bps (Y should be bigger than X
  but not that big.  One could be X=800M and Y=1G to emulate 10G nic
  with a workload that we can still converge with precopy only) and
  start precopy migration.

- measure total migration time with CLEAR_LOG on & off. We should
  expect the guest to have these with CLEAR_LOG: (1) not hang during
  log_sync, and (2) migration should complete faster.

Does above test plan makes sense?

If both the QEMU/KVM changes looks ok in general, I can at least try
this on some smaller guests (I can manage ~10G mem guests with my own
hosts, but I can also try to find some bigger ones).

Thanks,

-- 
Peter Xu

