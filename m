Received: from eggs.gnu.org ([2001:4830:134:3::10]:57028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPcnL-0007ef-20
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 19:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPchV-0001qe-De
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 19:18:34 -0500
Date: Thu, 22 Nov 2018 01:17:50 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181122001750.GF4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181116172919.43f3e27d@redhat.com>
	<d4f6f0ef-1333-a917-e3eb-d9bad47c9648@redhat.com>
	<20181119163110.2f357f40@redhat.com>
	<20181121072954-mutt-send-email-mst@kernel.org>
	<20181121151526.5785b43f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121151526.5785b43f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/24] ACPI reorganization for
 hardware-reduced API addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 21, 2018 at 03:15:26PM +0100, Igor Mammedov wrote:
> On Wed, 21 Nov 2018 07:35:47 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Nov 19, 2018 at 04:31:10PM +0100, Igor Mammedov wrote:
> > > On Fri, 16 Nov 2018 17:37:54 +0100
> > > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >   
> > > > On 16/11/18 17:29, Igor Mammedov wrote:  
> > > > > General suggestions for this series:
> > > > >   1. Preferably don't do multiple changes within a patch
> > > > >      neither post huge patches (unless it's pure code movement).
> > > > >      (it's easy to squash patches later it necessary)
> > > > >   2. Start small, pick a table generalize it and send as
> > > > >      one small patchset. Tables are often independent
> > > > >      and it's much easier on both author/reviewer to agree upon
> > > > >      changes and rewrite it if necessary.    
> > > > 
> > > > How would that be done?  This series is on the bigger side, agreed, but
> > > > most of it is really just code movement.  It's a starting point, having
> > > > a generic ACPI library is way beyond what this is trying to do.  
> > > I've tried to give suggestions how to restructure series
> > > on per patch basis. In my opinion it quite possible to split
> > > series in several smaller ones and it should really help with
> > > making series cleaner and easier/faster to review/amend/merge
> > > vs what we have in v5.
> > > (it's more frustrating to rework large series vs smaller one)
> > > 
> > > If something isn't clear, it's easy to reach out to me here
> > > or directly (email/irc/github) for clarification/feed back.  
> > 
> > I assume the #1 goal is to add reduced HW support.  So another
> > option to speed up merging is to just go ahead and duplicate a
> > bunch of code e.g. in pc_virt.c acpi/reduced.c or in any other
> > file.
> > This way it might be easier to see what's common code and what isn't.
> > And I think offline Igor said he might prefer that way. Right Igor?
> You mean probably 'x86 reduced hw' support.
That's what this is going to eventually look like, unfortunately.
And there's no technical reasons why we could not have a arch agnostic
hw-reduced support, so this should only be an intermediate step.

> That's was what I've
> already suggested for PCI AML code during patch review. Just don't
> call it generic when it's not and place code in hw/i386/ directory beside
> acpi-build.c. It might apply to some other tables (i.e. complex cases).
> 
> On per patch review I gave suggestions how to amend series to make
> it acceptable without doing complex refactoring and pointed out
> places we probably shouldn't refactor now and just duplicate as
> it's too complex or not clear how to generalize it yet.
I think I got the idea, and I will try to rework this serie according
to these directions.


> Problem with duplication is that a random contributor is not
> around to clean code up after a feature is merged and we end up
> with a bunch of messy code.
I'd argue that the same could be said of a potential "x86 hw-reduced"
solution. The same random contributor may not be around to push it to
the next step and make it more generic. I'd also argue we're not
planning to be random contributors, dropping code to the mailing list
and leaving.


> A word to the contributors,
> Don't do refactoring in silence, keep discussing approaches here,
> suggest alternatives.
Practically speaking, a large chunk of the NEMU work rely on having a
generic hardware-reduced ACPI implementation. We could not have blocked
the project waiting for an upstream acceptable solution for it and we
had to pick one route.
Retroactively I think we should have gone the self-contained, fully
duplicated route and move on with the rest of the NEMU work. Upstream
discussions could have then happened in parallel without much disruption
for the project.

Cheers,
Samuel.
