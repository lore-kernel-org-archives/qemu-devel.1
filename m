Received: from eggs.gnu.org ([209.51.188.92]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gzPTD-0000dU-Op
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gzPJk-0004FJ-Dq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:17:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gzPJb-0004AL-Tt
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:17:49 -0500
Date: Thu, 28 Feb 2019 14:17:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190228171741.GD4925@habkost.net>
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, imammedo@redhat.com, pmorel@linux.ibm.com

On Mon, Dec 17, 2018 at 10:57:30AM -0500, Tony Krowiak wrote:
> The qbus_is_full(BusState *bus) function (qdev_monitor.c) compares the max_index
> value of the BusState structure with the max_dev value of the BusClass structure
> to determine whether the maximum number of children has been reached for the
> bus. The problem is, the max_index field of the BusState structure does not
> necessarily reflect the number of devices that have been plugged into
> the bus.
> 
> Whenever a child device is plugged into the bus, the bus's max_index value is
> assigned to the child device and then incremented. If the child is subsequently
> unplugged, the value of the max_index does not change and no longer reflects the
> number of children.
> 
> When the bus's max_index value reaches the maximum number of devices
> allowed for the bus (i.e., the max_dev field in the BusClass structure),
> attempts to plug another device will be rejected claiming that the bus is
> full -- even if the bus is actually empty.
> 
> To resolve the problem, a new 'num_children' field is being added to the
> BusState structure to keep track of the number of children plugged into the
> bus. It will be incremented when a child is plugged, and decremented when a
> child is unplugged.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Queued on machine-next, thanks!

-- 
Eduardo
