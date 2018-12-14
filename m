Received: from eggs.gnu.org ([2001:4830:134:3::10]:58587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXoKj-0005rl-65
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXoKf-0005et-85
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:20:53 -0500
Date: Fri, 14 Dec 2018 15:20:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181214152041.0ba093a0.cohuck@redhat.com>
In-Reply-To: <1544796678-12736-1-git-send-email-pmorel@linux.ibm.com>
References: <1544796678-12736-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/pci: add common function
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

On Fri, 14 Dec 2018 15:11:18 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.ibm.com>
> 
> Common function measurement block is used to report zPCI internal
> counters of successful pcilg/stg/stb and rpcit instructions to
> a memory location provided by the program.
> 
> This patch introduces a new ZpciFmb structure and schedules a timer
> callback to copy the zPCI measures to the FMB in the guest memory
> at an interval time set to 4s by default.
> 
> An error while attemping to update the FMB, would generated an error
> event to the guest.
> 
> The pcilg/stg/stb and rpcit interception handlers issue, increase
> the related counter on success.
> The guest shall pass a null FMBA (FMB address) in the FIB (Function
> Information Block) when it issues a Modify PCI Function Control
> instrcuction to switch off FMB and stop the corresponding timer.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  |   4 +-
>  hw/s390x/s390-pci-bus.h  |  29 ++++++++++
>  hw/s390x/s390-pci-inst.c | 138 +++++++++++++++++++++++++++++++++++++++++++++--
>  hw/s390x/s390-pci-inst.h |   1 +
>  4 files changed, 168 insertions(+), 4 deletions(-)

Are there any changes in there other than the endianness handling?
