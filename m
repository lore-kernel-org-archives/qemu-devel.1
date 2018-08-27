Received: from eggs.gnu.org ([2001:4830:134:3::10]:35008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuGm4-0002gu-KU
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuGm1-0005Jl-FV
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:37:40 -0400
Date: Mon, 27 Aug 2018 14:37:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180827143731.26a5c0f6.cohuck@redhat.com>
In-Reply-To: <de80a3a0-7fd7-783c-3d3b-b8c4a481a893@de.ibm.com>
References: <20180824133757.1cbdba75.cohuck@redhat.com>
	<de80a3a0-7fd7-783c-3d3b-b8c4a481a893@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFD] [s390x] Tweaking the s390x maintainership
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 27 Aug 2018 14:02:49 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 08/24/2018 01:37 PM, Cornelia Huck wrote:

> > So, here are some ideas I had on how to improve things:
> > 
> > * Split up maintainership a bit more. For example, split out areas like
> >   pci for which no public documentation is available; these need to
> >   have at least one IBM maintainer. Another candidate would maybe be
> >   the cpu model.
> > * On a related note, more maintainers from IBM would be nice :) For
> >   example, for vfio-ccw, where I'm the only maintainer... Some R:
> >   entries would not hurt, either.  
> 
> Yes, we (IBM) should take care of vfio-ccw (and probably also pci and ap)

Just to note: I'm happy to continue taking care of vfio-ccw (especially
as I also have some code changes for it under development), but it
would be great if someone would join me. The others (pci and the
upcoming ap) should be handled by IBM, agreed.

> Give me some more days to sort things out a bit. 

Thanks for looking into this. No hurry, I'm out on vacation soon
anyway :)

> 
> > * More trees to pull from. Of course, not every area needs a dedicated
> >   tree (that would become silly pretty quickly), but for example a tcg
> >   tree would be nice. I can still pick individual patches if a pull
> >   request would be overkill.
> > * I'd also like to have a designated backup for the overall
> >   maintainership, especially for when I'm on vacation (like the first
> >   two weeks of September, just to let you know :) or otherwise
> >   unavailable, but also for sanity. Likely needs to be a non-IBMer due
> >   to the tcg problem.  
> 
> Is the current setup with Richard (TCG) and myself (KVM) not good enough?

It's mostly "I'm uncomfortable that it's only me". Having the tcg
maintainers resp. you handle things is absolutely fine for the usual
run of things. The only time where there might be problems is if e.g.
tcg and kvm changes interact in a non-trivial way, but I expect these
to be very rare.

> 
> 
> > * A more predictable s390-next would be nice. Maybe have it
> >   (semi-)automatically created out of the different trees, on top of
> >   current master? I would start to apply patches on a new branch that
> >   feeds into s390-next rather than on s390-next directly, then.
> > * Do something about (semi-)consolidated, (semi-)automatic testing.
> >   Like hooking into Travis (or something similar), sharing test setups,
> >   and enabling tests to be run on a range of platforms (including very
> >   recent ones). Testing is probably a large topic on its own, though.
> > 
> > Thoughts?
> >   
> 
