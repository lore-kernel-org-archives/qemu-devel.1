Received: from eggs.gnu.org ([2001:4830:134:3::10]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwn0G-0007WH-Ai
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwn0F-0004Si-Gj
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:22:12 -0400
Date: Tue, 26 Sep 2017 11:21:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170926102150.GD2689@work-vm>
References: <b802048c-f5c0-efff-5550-6faed26023cd@redhat.com>
	<1078f013-e554-1d75-d1e8-f24daace5965@virtuozzo.com>
	<20170919190634.GK2107@work-vm> <87bmm5k2zs.fsf@secure.laptop>
	<20170925132312.GA7999@localhost.localdomain>
	<a1145c5e-4b70-a5ab-b828-ba51a9a3f9e3@virtuozzo.com>
	<20170925145842.GB7999@localhost.localdomain>
	<b3121fed-0d31-f3f3-446c-1241561003a9@virtuozzo.com>
	<20170925152735.GG2656@work-vm>
	<20170926101245.GB3399@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926101245.GB3399@localhost.localdomain>
Subject: Re: [Qemu-devel] ping Re: [PATCH v7 03/16] migration: split common
 postcopy out of ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Juan Quintela <quintela@redhat.com>, peter.maydell@linaro.org, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, lirans@il.ibm.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 25.09.2017 um 17:27 hat Dr. David Alan Gilbert geschrieben:
> > > > Whatever you think the preferred way to set up postcopy migration is: If
> > > > something worked before this patch and doesn't after it, that's a
> > > > regression and breaks backwards compatibility.
> > > > 
> > > > If we were talking about a graceful failure, maybe we could discuss
> > > > whether carefully and deliberately breaking compatibility could be
> > > > justified in this specific case. But the breakage is neither mentioned
> > > > in the commit message nor is it graceful, so I can only call it a bug.
> > > > 
> > > > Kevin
> > > 
> > > It's of course my fault, I don't mean "it's wrong test, so it's not my
> > > problem") And I've already sent a patch.
> > 
> > Why does this fail so badly, asserts etc - I was hoping for something
> > a bit more obvious from the migration code.
> > 
> > postcopy did originally work without the destination having the flag on
> > but setting the flag on the destination was always good practice because
> > it detected whether the host support was there early on.
> 
> So what does this mean for 2.11? Do you think it is acceptable breaking
> cases where the flag isn't set on the destination?

I think so, because we've always recommended setting it on the
destination for the early detection.

> If so, just changing the test case is enough. But if not, I'd rather
> keep the test case as it is and fix only the migration code.

I'd take the test case fix, but I also want to dig why it fails so
badly; it would be nice just to have a clean failure telling you
that postcopy was expected.

Dave

> 
> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
