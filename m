Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drnEy-0007PB-Pn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drnEy-0007Eq-1O
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:36:44 -0400
Date: Tue, 12 Sep 2017 16:36:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170912153630.GC2225@work-vm>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912164644.2a0b6977@bahia.lan>
	<6198350f-a694-cf1b-ec00-4c42ccce39a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6198350f-a694-cf1b-ec00-4c42ccce39a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] hmp: fix "dump-quest-memory"
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com

* Thomas Huth (thuth@redhat.com) wrote:
> On 12.09.2017 16:46, Greg Kurz wrote:
> > On Tue, 12 Sep 2017 16:01:46 +0200
> > Laurent Vivier <lvivier@redhat.com> wrote:
> > 
> >> Fix aarch64 and ppc when dump-guest-memory is
> >> used with none machine type and no CPU.
> >>
> >> The other machine types don't have the problem.
> >>
> >> Update test-hmp, to test none machine type
> >> with (2 MB) and without memory, and add a test
> >> to test dump-quest-memory without filter parameters
> >> (it needs the fix from Cornelia Huck to work)
> >>
> >> v3:
> >>   - remove blank line after a comment
> >>   - forbid memory dump when there is no CPU
> >>
> > 
> > So in the end, we would forbid dump on aarch64 and
> > ppc, while it is allowed on i386... I don't really
> > care about which behavior is more appropriate but
> > I guess they should be consistent at least.
> 
> It's kind of consistent: Allow it on architectures with fixed endianess,
> but disallow it on architectures without fixed endianess ;-)

Another way to put it is that you can dump unless you need
information about the CPU.

It also makes me wonder what happens on those CPUs that can
change their endianness dynamically.

(I'm not fussed either way as long as it doesn't crash;
'none' is full of corner cases)

Dave

> Honestly, it should not matter - we're talking here about the "none"
> machine without a CPU ... as long as it does not crash, there is no need
> for a working "dump-guest-memory" function here.
> 
>  Thomas
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
