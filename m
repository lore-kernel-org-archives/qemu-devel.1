Received: from eggs.gnu.org ([2001:4830:134:3::10]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0QsV-0006tF-FC
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0QsQ-0004xT-IE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d0QsQ-0004x3-C0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 07:00:54 -0400
Date: Tue, 18 Apr 2017 12:00:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170418110047.GD2205@work-vm>
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170413205525.GD4376@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413205525.GD4376@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH 0/3 for 2.10] migration/i386 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, quintela@redhat.com

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Wed, Apr 05, 2017 at 08:00:21PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Hi,
> >   This removes some qemu_get_ and qemu_put_ use from i386/machine.c
> > and cleans out some very old code.
> >   It breaks migration compatibility from prior to 0.12
> > for i386 and prior to ~0.14 for non-softfloat - it doesn't alter the
> > machine type, it just removes some old stream features.
> > 
> > (Has anyone got a good test of FP migration to make sure
> > I've not broken the FP/mmx/etc cases?)
> 
> It would be nice if we could allow kvm-unit-tests test cases
> trigger a migration operation at a specific instruction. I assume
> we don't have an existing mechanism that could be used for that?

Not that I know of, do we have any type of breakpoint type thing
we could use?

Dave

> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
