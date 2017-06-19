Received: from eggs.gnu.org ([2001:4830:134:3::10]:45492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dMxsm-0002Aj-Ce
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dMxsi-0002it-C4
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:42:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:53054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <keith.busch@intel.com>)
	id 1dMxsi-0002gm-3V
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:42:20 -0400
Date: Mon, 19 Jun 2017 10:50:50 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170619145049.GF13399@localhost.localdomain>
References: <20170528130649.28168-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528130649.28168-1-dan@kernelim.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Fix get/set number of queues feature, again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Aloni <dan@kernelim.com>
Cc: qemu-devel@nongnu.org, Alex Friedman <alex@e8storage.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Sun, May 28, 2017 at 04:06:49PM +0300, Dan Aloni wrote:
> The number of queues that should be return by the admin command should:
> 
>   1) Only mention the number of non-admin queues.
>   2) It is zero-based, meaning that '0 == one non-admin queue',
>      '1 == two non-admin queues', and so forth.
> 
> Because our `num_queues` means the number of queues _plus_ the admin
> queue, then the right calculation for the number returned from the admin
> command is `num_queues - 2`, combining the two requirements mentioned.
> 
> The issue was discovered by reducing num_queues from 64 to 8 and running
> a Linux VM with an SMP parameter larger than that (e.g. 22). It tries to
> utilize all queues, and therefore fails with an invalid queue number
> when trying to queue I/Os on the last queue.
> 
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> CC: Alex Friedman <alex@e8storage.com>
> CC: Keith Busch <keith.busch@intel.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>

Looks good, thanks for the fix.

Reviewed-by: Keith Busch <keith.busch@intel.com>
