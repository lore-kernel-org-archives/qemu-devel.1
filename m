Received: from eggs.gnu.org ([2001:4830:134:3::10]:46379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWlF2-0000zo-DS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWlEz-0003PU-Fy
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:50:40 -0500
Date: Tue, 11 Dec 2018 16:50:19 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181211165019.GV18875@perard.uk.xensource.com>
References: <1544543862-9997-1-git-send-email-paul.durrant@citrix.com>
	<1544543862-9997-15-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544543862-9997-15-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v4 14/18] xen: add implementations of
 xen-block connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Dec 11, 2018 at 03:57:38PM +0000, Paul Durrant wrote:
> ...and wire in the dataplane.
> 
> This patch adds the remaining code to make the xen-block XenDevice
> functional. The parameters that a block frontend expects to find are
> populated in the backend xenstore area, and the 'ring-ref' and
> 'event-channel' values specified in the frontend xenstore area are
> mapped/bound and used to set up the dataplane.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
