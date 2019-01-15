Received: from eggs.gnu.org ([209.51.188.92]:60562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjQwJ-0006zt-Ui
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjQwJ-0003uZ-Al
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:47:43 -0500
Date: Tue, 15 Jan 2019 16:47:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115164735.3732b9d8.cohuck@redhat.com>
In-Reply-To: <1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On Thu, 10 Jan 2019 14:00:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The size of the accessible iommu memory region in the guest
> is given to the IOMMU by the guest through the mpcifc request
> specifying the PCI Base Address and the PCI Address Limit.
> 
> Let set the size of the IOMMU region to:
>     (PCI Address Limit) - (PCI Base Address) + 1.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.
