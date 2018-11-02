Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=837fd5125=anthony.perard@citrix.com>)
	id 1gIZtL-0008KE-2q
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=837fd5125=anthony.perard@citrix.com>)
	id 1gIZtG-0005Og-2U
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:53:38 -0400
Date: Fri, 2 Nov 2018 13:53:26 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181102135326.GH6481@perard.uk.xensource.com>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<154115286450.11300.208978412106583040.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154115286450.11300.208978412106583040.stgit@dhcp-3-135.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] Improve xen_disk response latency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tim Smith <tim.smith@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 02, 2018 at 10:01:04AM +0000, Tim Smith wrote:
> If the I/O ring is full, the guest cannot send any more requests
> until some responses are sent. Only sending all available responses
> just before checking for new work does not leave much time for the
> guest to supply new work, so this will cause stalls if the ring gets
> full. Also, not completing reads as soon as possible adds latency
> to the guest.
> 
> To alleviate that, complete IO requests as soon as they come back.
> blk_send_response() already returns a value indicating whether
> a notify should be sent, which is all the batching we need.
> 
> Signed-off-by: Tim Smith <tim.smith@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
