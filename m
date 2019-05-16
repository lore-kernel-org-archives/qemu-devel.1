Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EFDC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 09:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CED205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CED205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRCfF-0000fU-CW
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 05:27:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hRCeT-0000Oj-UH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 05:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hRCeS-0003h3-Oo
	for qemu-devel@nongnu.org; Thu, 16 May 2019 05:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hRCeS-0003fx-HG
	for qemu-devel@nongnu.org; Thu, 16 May 2019 05:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D2B8C0586C1
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:26:10 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 376C57855B;
	Thu, 16 May 2019 09:26:06 +0000 (UTC)
Date: Thu, 16 May 2019 17:26:03 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190516092603.GK16681@xz-x1>
References: <20190508061523.17666-1-peterx@redhat.com>
	<4df1963e-5b76-4990-6c2f-a66ecd172869@redhat.com>
	<20190508113929.GE18465@xz-x1>
	<a32b877c-1303-f378-316b-c564a8ccc419@redhat.com>
	<20190509023319.GG18465@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509023319.GG18465@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 16 May 2019 09:26:10 +0000 (UTC)
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

On Thu, May 09, 2019 at 10:33:19AM +0800, Peter Xu wrote:
> On Wed, May 08, 2019 at 01:55:07PM +0200, Paolo Bonzini wrote:
> > On 08/05/19 06:39, Peter Xu wrote:
> > >> The disadvantage of this is that you won't clear in the kernel those
> > >> dirty bits that come from other sources (e.g. vhost or
> > >> address_space_map).  This can lead to double-copying of pages.
> > >>
> > >> Migration already makes a local copy in rb->bmap, and
> > >> memory_region_snapshot_and_clear_dirty can also do the clear.  Would it
> > >> be possible to invoke the clear using rb->bmap instead of the KVMSlot's
> > >> new bitmap?
> > >
> > > Actually that's what I did in the first version before I post the work
> > > but I noticed that there seems to have a race condition with the
> > > design.  The problem is we have multiple copies of the same dirty
> > > bitmap from KVM and the race can happen with those multiple users
> > > (bitmaps of the users can be a merged version containing KVM and other
> > > sources like vhost, address_space_map, etc. but let's just make it
> > > simpler to not have them yet).
> > 
> > I see now.  And in fact the same double-copying inefficiency happens
> > already without this series, so you are improving the situation anyway.
> > 
> > Have you done any kind of benchmarking already?
> 
> Not yet.  I posted the series for some initial reviews first before
> moving on with performance tests.
> 
> My plan of the test scenario could be:
> 
> - find a guest with relatively large memory (I would guess it is
>   better to have memory like 64G or even more to make some big
>   difference)
> 
> - run random dirty memory workload upon most of the mem, with dirty
>   rate X Bps.
> 
> - setup the migration bandwidth to Y Bps (Y should be bigger than X
>   but not that big.  One could be X=800M and Y=1G to emulate 10G nic
>   with a workload that we can still converge with precopy only) and
>   start precopy migration.
> 
> - measure total migration time with CLEAR_LOG on & off. We should
>   expect the guest to have these with CLEAR_LOG: (1) not hang during
>   log_sync, and (2) migration should complete faster.

Some updates on performance numbers.

Summary: the ideal case below shows ~40% or even more time reduced to
migrate the same VM with the same workload.  In other words, it could
be seen as ~40% faster than before.

Test environment: 13G guest, 10G test mem (so I leave 3G untouched),
dirty rate 900MB/s, BW 10Gbps to emulate ixgbe, downtime 100ms.

IO pattern: I pre-fault all the 10G mem then I do random writes (with
command "mig_mon mm_dirty 10240 900 random" [1]) upon the test memory
with a constant dirty rate (900MB/s, as mentioned).  Then I migrate
during the IOs.

Here's the total migration time of such VM (for each scenario, I run
the migration 5 times then I get an average migration total time
used):

   |--------------+---------------------+-------------|
   | scenario     | migration times (s) | average (s) |
   |--------------+---------------------+-------------|
   | no CLEAR_LOG | 55, 54, 56, 74, 54  |          58 |
   | 1G chunk     | 40, 39, 41, 39, 40  |          40 |
   | 128M chunk   | 38, 40, 37, 40, 38  |          38 |
   | 16M chunk    | 42, 40, 38, 41, 38  |          39 |
   | 1M chunk     | 37, 40, 36, 40, 39  |          38 |
   |--------------+---------------------+-------------|

The first "no CLEAR_LOG" means the master branch which still uses the
GET_DIRTY only.  The latter four scenarios are all with the new
CLEAR_LOG interface, aka, this series.  The test result shows that
128M chunk size seems to be a good default value instead of 1G (which
this series used).  I'll adjust that accordingly when I post the next
version.

[1] https://github.com/xzpeter/clibs/blob/master/bsd/mig_mon/mig_mon.c

Regards,

-- 
Peter Xu

