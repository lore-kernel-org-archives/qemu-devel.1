Received: from eggs.gnu.org ([2001:4830:134:3::10]:37616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRCHm-0001TD-QC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRCHj-0001QI-Nq
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:58:14 -0400
References: <20180607165218.9558-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <df3c285e-8f7d-6e24-7d8e-2a2738556b1d@redhat.com>
Date: Fri, 8 Jun 2018 09:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/8] pc/spapr/s390x: machine hotplug
 handler cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

On 07.06.2018 18:52, David Hildenbrand wrote:
> I'll be messing with machine hotplug handlers of pc/spapr/s390x in the
> context of
>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
> 
> So this is a spin-off of the cleanup patches produced so far.
> 
> David Hildenbrand (8):
>   pc: local error handling in hotplug handler functions
>   spapr: no need to verify the node
>   spapr: move all DIMM checks into spapr_memory_plug
>   spapr: local error handling in hotplug handler functions
>   spapr: introduce machine unplug handler
>   spapr: handle pc-dimm unplug via hotplug handler chain
>   spapr: handle cpu core unplug via hotplug handler chain
>   s390x: local error handling in hotplug handler functions
> 
>  hw/i386/pc.c               | 32 +++++++++-----
>  hw/ppc/spapr.c             | 89 +++++++++++++++++++++++++-------------
>  hw/s390x/s390-virtio-ccw.c | 11 +++--
>  3 files changed, 89 insertions(+), 43 deletions(-)
> 

I might be dropping the "local error handling" patches (as Conny and
Christian properly asked for the reason). Although they are not wrong,
they are only useful if performing checks on error pointers (*errp) or
when relying on the error to indicate the "return value" of a function.

And as I might be handling plugging of memory devices in subfunctions
(to keep the handler short as requested by Igor), this might not be
needed on this level.

-- 

Thanks,

David / dhildenb
