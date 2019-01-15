Received: from eggs.gnu.org ([209.51.188.92]:34334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjL0V-0002GV-Ph
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjL0V-0002IM-5L
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:27:39 -0500
Date: Tue, 15 Jan 2019 10:27:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115102720.3310b094.cohuck@redhat.com>
In-Reply-To: <20190110210358.24035-1-david@redhat.com>
References: <20190110210358.24035-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/pci: Send correct event on
 hotplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Thu, 10 Jan 2019 22:03:58 +0100
David Hildenbrand <david@redhat.com> wrote:

> Comit 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
> changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
> ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
> HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
> state.
> 
> Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actual
> state the device is in.
> 
> This fixes hotplugged devices having to be enabled explicitly in the
> guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.
> 
> Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured mode")
> Report-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.
