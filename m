Received: from eggs.gnu.org ([2001:4830:134:3::10]:37699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fqA1x-00046Y-ER
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fqA1u-0005vY-An
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:37:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fqA1s-0005uc-UC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:37:02 -0400
Date: Thu, 16 Aug 2018 12:36:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180816043653.GA19773@lemon.usersys.redhat.com>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-2-cota@braap.org>
	<20180815030942.GA14092@lemon.usersys.redhat.com>
	<20180815045323.GA7585@flamenco> <20180815235514.GA23767@flamenco>
	<20180816042933.GA17638@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816042933.GA17638@flamenco>
Subject: Re: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 08/16 00:29, Emilio G. Cota wrote:
> On Wed, Aug 15, 2018 at 19:55:14 -0400, Emilio G. Cota wrote:
> > On Wed, Aug 15, 2018 at 00:53:23 -0400, Emilio G. Cota wrote:
> > > On Wed, Aug 15, 2018 at 11:09:42 +0800, Fam Zheng wrote:
> > > > On Mon, 08/13 13:11, Emilio G. Cota wrote:
> > > > > +  --enable-sync-profiler) sync_profiler="yes"
> > > > > +  ;;
> > > > 
> > > > Curious, not asking for a change: can this be made a runtime option instead of
> > > > compile time, since there's no library dependencies? That should make this
> > > > somewhat easier to use.
> > > 
> > > Good point. I'll do some profiling tomorrow to see how the latency
> > > of the locking primitives could be minimized (ideally, not using
> > > the profiler should just add a well-predicted branch).
> > 
> > I reduced it to just a branch, but still, I measured a few percentage
> > points (1-2%, depending on the machine) slowdown when this is a
> > run-time option. (This is for a bootup+shutdown test of a guest.)
> > 
> > So I'll keep it as a build-time option, then.
> 
> I looked further into this. Turns out we don't need the branch at all;
> we can make indirect calls via function pointers, where the
> pointers are set by qsp_enable/disable().
> 
> Overhead of doing things this way is within noise range, since
> compilers and CPUs are so good at dealing with indirect calls.

Very nice finding! Thanks.

Fam

> 
> I'll send a v2 tomorrow.
> 
> 		Emilio
