Received: from eggs.gnu.org ([209.51.188.92]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkAfn-0004WV-2Q
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkAfm-0008TH-AJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:37:43 -0500
Date: Thu, 17 Jan 2019 17:37:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190117173733.47e6e0d5.cohuck@redhat.com>
In-Reply-To: <1546969050-8884-2-git-send-email-pmorel@linux.ibm.com>
References: <1546969050-8884-1-git-send-email-pmorel@linux.ibm.com>
	<1546969050-8884-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7] s390x/pci: add common function
 measurement block
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

On Tue,  8 Jan 2019 18:37:30 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.ibm.com>
> 
> Common function measurement block is used to report zPCI internal
> counters of successful pcilg/stg/stb and rpcit instructions to
> a memory location provided by the program.
> 
> This patch introduces a new ZpciFmb structure and schedules a timer
> callback to copy the zPCI measures to the FMB in the guest memory
> at an interval time set to 4s.
> 
> An error while attemping to update the FMB, would generate an error
> event to the guest.
> 
> The pcilg/stg/stb and rpcit interception handlers increase the
> related counter on a successful call.
> The guest shall pass a null FMBA (FMB address) in the FIB (Function
> Information Block) when it issues a Modify PCI Function Control
> instruction to switch off FMB and stop the corresponding timer.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  |   4 +-
>  hw/s390x/s390-pci-bus.h  |  29 +++++++++++
>  hw/s390x/s390-pci-inst.c | 133 +++++++++++++++++++++++++++++++++++++++++++++--
>  hw/s390x/s390-pci-inst.h |   1 +
>  4 files changed, 163 insertions(+), 4 deletions(-)

Thanks, applied.
