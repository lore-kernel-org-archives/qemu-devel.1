Received: from eggs.gnu.org ([2001:4830:134:3::10]:53369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRGv8-0002iq-Nl
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRGv4-0001js-S3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:55:10 -0400
Date: Fri, 8 Jun 2018 15:55:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608155432-mutt-send-email-mst@kernel.org>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-5-david@redhat.com>
	<20180530150806.061c26b9@redhat.com>
	<5dcb16e5-b9b9-d07d-dfe3-98724e911f83@redhat.com>
	<20180531161310.52ea9507@redhat.com>
	<e451e0d6-a181-b027-cdb7-f44beb11b37c@redhat.com>
	<20180607154455.6eab4e24@redhat.com>
	<5dda6237-88d8-f0f8-58d2-af996368cea4@redhat.com>
	<20180608142442.0d97b7c6@redhat.com>
	<397d37ee-b3a8-dae0-37d1-fd3c942448c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397d37ee-b3a8-dae0-37d1-fd3c942448c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/14] pc: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Fri, Jun 08, 2018 at 02:32:09PM +0200, David Hildenbrand wrote:
> 
> >>> if (TYPE_PC_DIMM) {
> >>>     pc_dimm_plug()
> >>>     /* do here additional concrete machine specific things */
> >>> } else if (TYPE_VIRTIO_MEM) {
> >>>     virtio_mem_plug() <- do forwarding in there
> >>>     /* and do here additional concrete machine specific things */
> >>> } else if (TYPE_CPU) {
> >>>     cpu_plug()
> >>>     /* do here additional concrete machine specific things */
> >>> }  
> >>
> >> That will result in a lot of duplicate code - for every machine we
> >> support (dimm/virtio-mem/virtio-pmem/*add more memory devices here*) -
> >> virtio-mem and virtio-pmem could most probably share the code.
> > maybe or maybe not, depending on if pmem endups as memory device or
> > separate controller. And even with duplication, machine code would
> > be easy to follow just down one explicit call chain.
> 
> Not 100% convinced but I am now going into that direction.

Can this go into DeviceClass? Failover has the same need to
allocate/free resources for vfio without a full realize/unrealize.

> -- 
> 
> Thanks,
> 
> David / dhildenb
