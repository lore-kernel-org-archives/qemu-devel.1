Received: from eggs.gnu.org ([2001:4830:134:3::10]:57755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuExI-000597-CS
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuExF-0005m0-4Y
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:41:08 -0400
Date: Mon, 27 Aug 2018 12:40:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180827124058.36aa13ee.cohuck@redhat.com>
In-Reply-To: <a29f4cdd-8012-d46e-8984-b4e223f1957f@redhat.com>
References: <20180824133757.1cbdba75.cohuck@redhat.com>
	<a29f4cdd-8012-d46e-8984-b4e223f1957f@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 27 Aug 2018 11:26:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 24.08.2018 13:37, Cornelia Huck wrote:
> > So, here are some ideas I had on how to improve things:
> > 
> > * Split up maintainership a bit more. For example, split out areas like
> >   pci for which no public documentation is available; these need to
> >   have at least one IBM maintainer. Another candidate would maybe be
> >   the cpu model.  
> 
> I could take care of the latter. But it usually goes hand in hand with
> KVM changes (or core s390x changes for migration), so I am not sure if
> splitting the cpu model out makes that much sense after all. To me, it
> somehow feels "s390x core".

I'll defer to your judgment here :)

> 
> > * On a related note, more maintainers from IBM would be nice :) For
> >   example, for vfio-ccw, where I'm the only maintainer... Some R:
> >   entries would not hurt, either.
> > * More trees to pull from. Of course, not every area needs a dedicated
> >   tree (that would become silly pretty quickly), but for example a tcg
> >   tree would be nice. I can still pick individual patches if a pull
> >   request would be overkill.  
> 
> I can take care of that for TCG (including picking + sending pull requests).

Cool, thank you. I'll do a pull request before my vacation with the
current model, so we could switch after that.

> 
> > * I'd also like to have a designated backup for the overall
> >   maintainership, especially for when I'm on vacation (like the first
> >   two weeks of September, just to let you know :) or otherwise
> >   unavailable, but also for sanity. Likely needs to be a non-IBMer due
> >   to the tcg problem.  
> 
> Either Thomas or I could do that. I will be on vacation the first two
> weeks of September, too ;) Thomas, interested?

Maybe both of you? I doubt we'll be on vacation during the same time
period every time ;)

> 
> > * A more predictable s390-next would be nice. Maybe have it
> >   (semi-)automatically created out of the different trees, on top of
> >   current master? I would start to apply patches on a new branch that
> >   feeds into s390-next rather than on s390-next directly, then.  
> 
> Is there any fancy mechanism out there with which we can easily build
> something like that (automatic merging like e.g. linux-next does)?

I can dig around whether there are some published scripts for that.
What we probably need is:

- a list of branches to merge
- a script that tries to merge them one by one and then pushes the
  result out

We'll probably be able to semi-automate this, but I doubt that it is
possible to do that fully automatically (conflict resolution etc.)
AFAIK, linux-next is also done semi-automatically (but also on a way
different scale :)

> 
> > * Do something about (semi-)consolidated, (semi-)automatic testing.
> >   Like hooking into Travis (or something similar), sharing test setups,
> >   and enabling tests to be run on a range of platforms (including very
> >   recent ones). Testing is probably a large topic on its own, though.  
> 
> Sounds interesting to me. Especially building all different kinds of
> combinations + e.g. running kvm-unit-tests / booting a simple distro.

Yes, something like that. Especially on different hardware.
