Received: from eggs.gnu.org ([2001:4830:134:3::10]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4OHf-0005iB-OL
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4OHZ-000743-1Z
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:35:35 -0400
Date: Tue, 17 Oct 2017 11:35:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017113519.1eb78f7c.cohuck@redhat.com>
In-Reply-To: <07afc056-4a03-3644-d665-c165830776ba@redhat.com>
References: <20171016202358.3633-1-david@redhat.com>
	<20171017104725.14971395.cohuck@redhat.com>
	<07afc056-4a03-3644-d665-c165830776ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x/tcg: LAP support using
 immediate TLB invalidation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

On Tue, 17 Oct 2017 11:22:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 17.10.2017 10:47, Cornelia Huck wrote:
> > On Mon, 16 Oct 2017 22:23:56 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Details about Low-Address Protection can be found in description of
> >> patch 1 and 2. It is basically a subpage protection of the first two
> >> pages of every address space (for which it is enabled).
> >>
> >> We can achieve this by simply directly invalidating the TLB entry and
> >> therefore forcing every write accesses onto these two pages into the slow
> >> path.
> >>
> >> With this patch, I can boot Linux just fine (which uses LAP). This also
> >> makes all related kvm-unit-tests that we have pass.  
> > 
> > Tested with a kernel based on the s390/features branch (4.14-rc2 + s390
> > patches) and the initrd from the debian installer, had udevd shot down
> > by the oomkiller. That happened only once, so it was probably an
> > unrelated fluke, but that combination worked well before.
> >   
> 
> Very unlikely, on invalid programming exceptions you would get a kernel
> panic, not run oom. (not saying it isn't possible, rather that it is
> very unlikely).

That's what I thought as well.

> 
> Can you reproduce with more memory? Have you enabled SMP? (little higher
> memory consumption)

SMP is on. I could not reproduce it again...

> 
> I am running (almost) the same setup with 500M and haven't observed any
> such thing.

...so I think it really is an unrelated fluke (and I'll simply make the
machine a bit larger).
