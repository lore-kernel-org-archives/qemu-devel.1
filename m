Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJGlM-0002mc-Nk
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJGlH-0004l6-SI
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:08:00 -0400
Date: Thu, 17 May 2018 12:07:50 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180517110750.GM2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-9-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-9-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/8] xen_disk: be consistent with use of
 xendev and blkdev->xendev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, May 04, 2018 at 08:26:07PM +0100, Paul Durrant wrote:
> Certain functions in xen_disk are called with a pointer to xendev
> (struct XenDevice *). They then use continer_of() to acces the surrounding

                                      ^ container_of

> blkdev (struct XenBlkDev) but then in various places use &blkdev->xendev
> when use of the original xendev pointer is shorter to express and clearly
> equivalent.
> 
> This patch is a purely cosmetic patch which makes sure there is a xendev
> pointer on stack for any function where the pointer is need on multiple
> occasions modified those functions to use it consistently.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
