Received: from eggs.gnu.org ([2001:4830:134:3::10]:51319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fAiNa-0005Ua-Vu
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fAiNX-0004o5-UN
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 16:48:07 -0400
Date: Mon, 23 Apr 2018 17:47:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180423204753.GS29865@localhost.localdomain>
References: <20180423165126.15441-1-david@redhat.com>
	<20180423204018-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423204018-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>

On Mon, Apr 23, 2018 at 08:40:59PM +0300, Michael S. Tsirkin wrote:
> On Mon, Apr 23, 2018 at 06:51:15PM +0200, David Hildenbrand wrote:
> > Right now we can only map PCDIMM/NVDIMM into guest address space. In the
> > future, we might want to do the same for virtio devices - e.g.
> > virtio-pmem or virtio-mem. Especially, they should be able to live side
> > by side to each other.
> > 
> > E.g. the virto based memory devices regions will not be exposed via ACPI
> > and friends. They will be detected just like other virtio devices and
> > indicate the applicable memory region. This makes it possible to also use
> > them on architectures without memory device detection support (e.g. s390x).
> > 
> > Let's factor out the memory device code into a MemoryDevice interface.
> > 
> > Please note that the "slots" assignment code is not relevant for memory
> > devices that will not be exposed via ACPI or similar. That's why that
> > part won't be exposed. KVM/vhost "slots" for memory regions are still
> > necessary but don't have to be manually specified (e.g. the slot number
> > doesn't mather).
> > 
> > So we are basically converting the hotplug memory region to a memory device
> > region. I have patches that also set up such a region for s390x.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Who's merging this? Eduardo?

I just queued it.  Thanks!

-- 
Eduardo
