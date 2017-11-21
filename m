Received: from eggs.gnu.org ([2001:4830:134:3::10]:39367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH6Al-0000TQ-Ac
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH6Ag-0006fO-Cg
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eH6Ag-0006f6-49
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:52:54 -0500
Date: Tue, 21 Nov 2017 11:52:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121115249.5709c8c9.cohuck@redhat.com>
In-Reply-To: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] s390x/pci: Improve zPCI to cover
 more cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Thu, 16 Nov 2017 18:51:48 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> This patch fixes the following BUG:
> Even a guest is able to detect virtio_pci device, the init function
> the Linux virtio_pci driver will hang because zPCI does not support
> the subregions used by virtio_pci.
> 
> It follows that right now the PCI support is very limited
> (e.g. pass through of a host vfio device)
> To enable features like virtio-pci several modifications needs to be
> done.
> 
> As already stated above, Virtio-PCI uses subregions, which may eventually
> be discontinuous inside bars instead of a single flat region often used
> by real devices.
> The address offset being formerly calculated from the BAR base address
> must be adapted to the subregions instead of to the single region.
> 
> This patch provides the new calculation for the three kind of BAR
> access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK done by zPCI.
> 
> We use the opportunity to
>  - enhance the fault detection for zPCI STORE and LOAD,
>  - enhance the fault detection and to provide the maximum STORE BLOCK
>    block size, maxstbl, for zPCI STORE BLOCK
>  - factor out part of the code used to calculate the offset and
>    access the BARs,
>  - factor out the code for endianess conversion.

I'll play with this a bit, but I think this is good for s390-next.

[I'd still like to play with this under tcg as well to make sure we are
endian-clean, but I'm making slower progress there than I hoped.]
