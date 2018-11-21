Received: from eggs.gnu.org ([2001:4830:134:3::10]:44513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPRja-0004SE-85
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPRjY-00079c-Fa
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:35:58 -0500
Date: Wed, 21 Nov 2018 07:35:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181121072954-mutt-send-email-mst@kernel.org>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181116172919.43f3e27d@redhat.com>
	<d4f6f0ef-1333-a917-e3eb-d9bad47c9648@redhat.com>
	<20181119163110.2f357f40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119163110.2f357f40@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon, Nov 19, 2018 at 04:31:10PM +0100, Igor Mammedov wrote:
> On Fri, 16 Nov 2018 17:37:54 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 16/11/18 17:29, Igor Mammedov wrote:
> > > General suggestions for this series:
> > >   1. Preferably don't do multiple changes within a patch
> > >      neither post huge patches (unless it's pure code movement).
> > >      (it's easy to squash patches later it necessary)
> > >   2. Start small, pick a table generalize it and send as
> > >      one small patchset. Tables are often independent
> > >      and it's much easier on both author/reviewer to agree upon
> > >      changes and rewrite it if necessary.  
> > 
> > How would that be done?  This series is on the bigger side, agreed, but
> > most of it is really just code movement.  It's a starting point, having
> > a generic ACPI library is way beyond what this is trying to do.
> I've tried to give suggestions how to restructure series
> on per patch basis. In my opinion it quite possible to split
> series in several smaller ones and it should really help with
> making series cleaner and easier/faster to review/amend/merge
> vs what we have in v5.
> (it's more frustrating to rework large series vs smaller one)
> 
> If something isn't clear, it's easy to reach out to me here
> or directly (email/irc/github) for clarification/feed back.

I assume the #1 goal is to add reduced HW support.  So another
option to speed up merging is to just go ahead and duplicate a
bunch of code e.g. in pc_virt.c acpi/reduced.c or in any other
file.
This way it might be easier to see what's common code and what isn't.
And I think offline Igor said he might prefer that way. Right Igor?

> > 
> > Paolo
> > 
> > >   3. when you think about refactoring acpi into a generic API
> > >      think about it as routines that go into a separate library
> > >      (pure acpi spec code) and qemu/acpi glue routines and
> > >       divide them correspondingly.  
> > 
