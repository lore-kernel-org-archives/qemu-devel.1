Received: from eggs.gnu.org ([209.51.188.92]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEEwB-0002Bn-0d
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEEqw-0001mu-0p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:09:31 -0400
Date: Wed, 10 Apr 2019 16:09:18 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190410150918.GF1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190408151617.13025-4-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] xen-bus / xen-block: add support for
 event channel polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 08, 2019 at 04:16:17PM +0100, Paul Durrant wrote:
> This patch introduces a poll callback for event channel fd-s and uses
> this to invoke the channel callback function.
> 
> To properly support polling, it is necessary for the event channel callback
> function to return a boolean saying whether it has done any useful work or
> not. Thus xen_block_dataplane_event() is modified to directly invoke
> xen_block_handle_requests() and the latter only returns true if it actually
> processes any requests. This also means that the call to qemu_bh_schedule()
> is moved into xen_block_complete_aio(), which is more intuitive since the
> only reason for doing a deferred poll of the shared ring should be because
> there were previously insufficient resources to fully complete a previous
> poll.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
