Received: from eggs.gnu.org ([2001:4830:134:3::10]:38790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH692-0007bW-NC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH68x-0005io-Pd
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:51:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eH68x-0005hh-Jl
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:51:07 -0500
Date: Tue, 21 Nov 2017 11:51:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121115104.77bb4637.cohuck@redhat.com>
In-Reply-To: <1510854715-7081-8-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-8-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] s390x/pci: search for subregion
 inside the BARs
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

On Thu, 16 Nov 2017 18:51:55 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> When dispatching memory access to PCI BAR region, we must
> look for possible subregions, used by the PCI device to map
> different memory areas inside the same PCI BAR.
> 
> Since the data offset we received is calculated starting at the
> region start address we need to adjust the offset for the subregion.
> 
> The data offset inside the subregion is calculated by substracting
> the subregion's starting address from the data offset in the region.
> 
> The access to the MSIX region is now handled in a generic way,
> we do not need the specific trap_msix() function anymore.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)

This one also looks fine.
