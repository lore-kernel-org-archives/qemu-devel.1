Received: from eggs.gnu.org ([2001:4830:134:3::10]:49445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWfDh-0004Mj-8i
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWfDd-0008RS-UL
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:24:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWfDd-0008Q8-Lf
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:24:49 -0500
Date: Tue, 11 Dec 2018 10:24:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181211102440.GD2734@work-vm>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181210173151.16629-2-dgilbert@redhat.com>
	<ad65a93f-9b0e-39c3-97ad-9204b30da630@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad65a93f-9b0e-39c3-97ad-9204b30da630@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/7] virtio: Add shared memory
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

* Eric Blake (eblake@redhat.com) wrote:
> On 12/10/18 11:31 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Define a new capability type 'VIRTIO_PCI_CAP_SHARED_MEMORY_CFG'
> > and the data structure 'virtio_pci_shm_cap' to go with it.
> > They allow defining shared memory regions with sizes and offsets
> > of 2^32 and more.
> > Multiple instances of the capability are allowed and distinguished
> > by a device-specific 'id'.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   hw/virtio/virtio-pci.c                      | 20 ++++++++++++++++++++
> >   include/standard-headers/linux/virtio_pci.h |  9 +++++++++
> >   2 files changed, 29 insertions(+)
> > 
> 
> > +++ b/include/standard-headers/linux/virtio_pci.h
> > @@ -113,6 +113,8 @@
> >   #define VIRTIO_PCI_CAP_DEVICE_CFG	4
> >   /* PCI configuration access */
> >   #define VIRTIO_PCI_CAP_PCI_CFG		5
> > +/* Additional shared memory capability */
> > +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> >   /* This is the PCI capability header: */
> >   struct virtio_pci_cap {
> > @@ -163,6 +165,13 @@ struct virtio_pci_cfg_cap {
> >   	uint8_t pci_cfg_data[4]; /* Data for BAR access. */
> >   };
> > +struct virtio_pci_shm_cap {
> > +	struct virtio_pci_cap cap;
> > +	uint32_t offset_hi;             /* Most sig 32 bits of offset */
> > +	uint32_t length_hi;             /* Most sig 32 bits of length */
> > +        uint8_t  id;                    /* To distinguish shm chunks */
> 
> TAB damage.

Thanks, fixed.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
