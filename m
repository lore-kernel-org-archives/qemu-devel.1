Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1g9MZK-0001Gs-0C
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1g9MZG-0003Lf-Qq
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:50:53 -0400
Date: Sun, 7 Oct 2018 23:50:46 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <658847701.19033442.1538970646251.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181008020411.GS7004@umbus.fritz.box>
References: <20180920103243.28474-1-david@redhat.com>
	<20180920103243.28474-18-david@redhat.com>
	<20180924054522.GY30868@umbus.fritz.box>
	<bff1cdbc-8a7c-8d53-47ff-cf17120a4af5@redhat.com>
	<1420151307.15516367.1537782494919.JavaMail.zimbra@redhat.com>
	<20181008020411.GS7004@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 17/22] virtio-pmem: prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hello David,

Thanks for the review.

> > 
> > > On 24/09/2018 07:45, David Gibson wrote:
> > > > On Thu, Sep 20, 2018 at 12:32:38PM +0200, David Hildenbrand wrote:
> > > >> From: Pankaj Gupta <pagupta@redhat.com>
> > > >>
> > > >> This is the current protoype of virtio-pmem. Support will require
> > > >> machine changes for the architectures that will support it, so it will
> > > >> not yet be compiled.
> > > >>
> > > >> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > >> [ MemoryDevice/MemoryRegion changes, cleanups, addr property
> > > >> "memaddr",
> > > >>   split up patches ]
> > > >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > > > 
> > > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > > 
> > > > Seems generally sane.  Is there a (craft?) virtio-pmem spec around to
> > > > see what this is actually trying to implement?
> > > 
> > > I am not aware of any. The first goal is to get something implemented
> > > that works and doesn't break important concepts. E.g. hotplugging memory
> > > devices was one of these concepts that Igor saw as a potential problem
> > > for getting virtio-pmem upstream.
> > > 
> > > But maybe Pankaj already has some draft version of a spec lying around.
> > 
> > I have created document but no official spec. Project idea is shared here
> > [1]
> > and kernel part of series [2]. I will create a spec and share.
> > 
> > [1] https://www.spinics.net/lists/kvm/msg153095.html
> > [2] https://marc.info/?l=kvm&m=153572224719212&w=2
> 
> Ok.  Because this creates a new interface we could be working with for
> a while, I think we do need at least a semi-formal spec - and to get
> some review of that spec - before we merge.

Sure, Will create one and try to send for review this week.

Thanks,
Pankaj

> 
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> 
