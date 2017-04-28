Received: from eggs.gnu.org ([2001:4830:134:3::10]:52627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d43kd-0003Fb-9V
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d43ka-0003Og-5F
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d43kZ-0003Ni-VY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:07:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84AD80F9E
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 11:07:46 +0000 (UTC)
Date: Fri, 28 Apr 2017 12:07:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428110740.GF2085@work-vm>
References: <1493287126-19072-1-git-send-email-peterx@redhat.com>
	<1493287126-19072-3-git-send-email-peterx@redhat.com>
	<20170427112313.GD2082@work-vm>
	<20170428102130.GD22801@pxdev.xzpeter.org>
	<20170428103950.GF22801@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428103950.GF22801@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ramblock: add new hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Apr 28, 2017 at 06:21:30PM +0800, Peter Xu wrote:
> > On Thu, Apr 27, 2017 at 12:23:14PM +0100, Dr. David Alan Gilbert wrote:
> 
> [...]
> 
> > > > +void ram_block_dump(Monitor *mon)
> > > > +{
> > > > +    RAMBlock *block;
> > > > +
> > > > +    rcu_read_lock();
> > > > +    monitor_printf(mon, "%24s %8s  %18s %18s %18s\n",
> > > > +                   "Block Name", "PSize", "Offset", "Used", "Total");
> > > > +    RAMBLOCK_FOREACH(block) {
> > > > +        monitor_printf(mon, "%24s %8s  0x%016" PRIx64 " 0x%016" PRIx64
> > > > +                       " 0x%016" PRIx64 "\n", block->idstr,
> > > > +                       page_size_to_str(block->page_size),
> > > > +                       (uint64_t)block->offset,
> > > > +                       (uint64_t)block->used_length,
> > > > +                       (uint64_t)block->max_length);
> > > > +    }
> > > 
> > > Yes that should work, I remember there's a RAM_ADDR_FMT macro that's
> > > supposed to be usable for ram_addr_t, but that's fine.
> > 
> > That looks better. Will switch to that. Thanks!
> 
> Oh, I found that RAM_ADDR_FMT didn't allow me to do the formatting
> with width ("%016..."). So maybe I'll still use current way for now.

Oh then just stick to the PRIx64 and the case; it's fine.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
