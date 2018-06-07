Received: from eggs.gnu.org ([2001:4830:134:3::10]:58857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQwq8-0007bk-D4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQwq4-0003W4-DJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:28:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQwq4-0003Vr-6k
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCDD640137FE
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 15:28:35 +0000 (UTC)
Date: Thu, 7 Jun 2018 16:28:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180607152832.GR2522@work-vm>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-5-dgilbert@redhat.com>
	<20180607084933.GH750@xz-mi> <87muw6wzud.fsf@dusky.pond.sub.org>
	<20180607134529.GL2522@work-vm> <87sh5yr5pv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh5yr5pv.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Tue, Jun 05, 2018 at 01:26:34PM +0100, Dr. David Alan Gilbert (git) wrote:
> >> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> >> 
> >> >> Allow a bunch of the info commands to be used in preconfig.
> >> >> Could probably add most of them.
> >> >
> >> > I guess some of them may not work yet during preconfig.  E.g.:
> >> >
> >> > $ ./x86_64-softmmu/qemu-system-x86_64 -preconfig -monitor stdio
> >> > QEMU 2.12.50 monitor - type 'help' for more information
> >> > (qemu) info mtree
> >> > address-space: memory
> >> >   0000000000000000-ffffffffffffffff (prio 0, i/o): system
> >> >
> >> > address-space: I/O
> >> >   0000000000000000-000000000000ffff (prio 0, i/o): io
> >> >
> >> > But it's fine to enable that I guess.
> >> >
> >> > (Which "info" command would you want to use during preconfig?)
> >> >
> >> >> 
> >> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> >
> >> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >> 
> >> The reason for having -preconfig is us despairing of making -S do the
> >> right thing.  We'd have to *understand* the tangled mess that is our
> >> startup, and rearrange it so QMP becomes available early enough for
> >> configuring NUMA (and other things), yet late enough for everything to
> >> work.
> >> 
> >> -preconfig is a cheap hack to avoid this headache, by bypassing almost
> >> all of "everything".
> >> 
> >> Now you bring back some of "everything".  Dangerous.  You better show it
> >> actually works.  Until you do:
> >> 
> >> NAK
> >
> > Well I did test each command in here to make sure it didn't
> > crash/produce complete junk; but here's the output with the v2 of this
> > patch that Igor R-b:
> [...]
> 
> For the sake of the argument, let's assume these commands all work in
> preconfig state.  Are their QMP equivalents all available in preconfig
> state?

That I don't know; I was happy to fix my list to the ones
Igor recommended.  If you object to some particular entries I'll
be happy to change them.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
