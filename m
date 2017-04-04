Received: from eggs.gnu.org ([2001:4830:134:3::10]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvSNI-0005gG-9N
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvSNF-0004mZ-7U
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvSNF-0004m5-1j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:36:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF66B770E
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 17:36:07 +0000 (UTC)
Date: Tue, 4 Apr 2017 18:36:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170404173604.GK2147@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170331143438.GJ4514@work-vm> <87vaqk3x5y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vaqk3x5y.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v2 00/51] Creating RAMState for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Hi
> >
> > Some high level points:
> >
> >> Continuation of previous series, all review comments addressed. New things:
> >> - Consolidate all function comments in the same style (yes, docs)
> >> - Be much more careful with maintaining comments correct
> >> - Move all postcopy fields to RAMState
> >
> >> - Move QEMUFile to RAMState
> >> - rename qemu_target_page_bits() to qemu_target_page_size() to reflect use
> >> - Remove MigrationState from functions that don't need it
> >> - reorganize last_sent_block to the place where it is used/needed
> >> - Move several places from offsets to pages
> >> - Rename last_ram_offset() to last_ram_page() to refect use
> >
> > An interesting question is what happens if we ever have multiple threads
> > working on RAM at once, I assume you're thinking there will be multiple
> > RAMStates?  It'll be interesting to see whether everything we have now got
> > in RAMState is stuff that wants to be replicated that way.
> 
> Working on paolo suggestion on sending everyhting through multiplefd's.
> That requires multiple FD's.

Yes, but for example do we want multiple postcopy request queues?
Do we have one reverse stream for requests or multiple?

Dave

> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
