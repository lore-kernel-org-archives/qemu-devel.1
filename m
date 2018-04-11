Received: from eggs.gnu.org ([2001:4830:134:3::10]:40843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1f6CZL-0001W5-Ma
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1f6CZH-00087D-2u
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1f6CZG-00086i-Ub
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:01:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EFDE40006E6
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 10:01:26 +0000 (UTC)
Date: Wed, 11 Apr 2018 12:01:16 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20180411100116.GA130486@orkuz.home>
References: <20180409102744.GC2449@work-vm>
	<20180409134003.GG5294@localhost.localdomain>
	<20180410073635.GA91107@orkuz.home>
	<20180410081848.GA7026@localhost.localdomain>
	<20180410084524.GB2559@work-vm>
	<20180410091437.GC7026@localhost.localdomain>
	<20180410104047.GD2559@work-vm>
	<20180410122652.GD7026@localhost.localdomain>
	<20180410142253.GG2559@work-vm>
	<20180410144756.GG7026@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410144756.GG7026@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] migration: Don't activate block devices if
 using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, peterx@redhat.com

On Tue, Apr 10, 2018 at 16:47:56 +0200, Kevin Wolf wrote:
> Am 10.04.2018 um 16:22 hat Dr. David Alan Gilbert geschrieben:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Am 10.04.2018 um 12:40 hat Dr. David Alan Gilbert geschrieben:
> > > > Hmm; having chatted to Jiri I'm OK with reverting it, on the condition
> > > > that I actually understand how this alternative would work first.
> > > > 
> > > > I can't currently see how a block-inactivate would be used.
> > > > I also can't see how a block-activate unless it's also with the
> > > > change that you're asking to revert.
> > > > 
> > > > Can you explain the way you see it working?
> > > 
> > > The key is making the delayed activation of block devices (and probably
> > > delayed announcement of NICs? - you didn't answer that part) optional
> > > instead of making it the default.
> > 
> > NIC announcments are broken in similar but slightly different ways;  we
> > did have a series on list to help a while ago but it never got merged;
> > I'd like to keep that mess separate.
> 
> Okay. I just thought that it would make sense to have clear migration
> phases that are the same for all external resources that the QEMU
> processes use.

I don't think NIC announcements should be delayed in this specific case
since we're dealing with a failure recovery which should be rare in
comparison to successful migration when we want NIC announcements to be
send early. In other words, any NIC issues should be solved separately
and Laine would likely be a better person for discussing them since he
has a broader knowledge of all the fancy network stuff which libvirt
needs to coordinate with.

Jirka
