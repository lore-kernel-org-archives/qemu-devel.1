Received: from eggs.gnu.org ([2001:4830:134:3::10]:53624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVJK3-0000Cg-4d
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVJJz-00012s-8s
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:49:51 -0500
Date: Fri, 7 Dec 2018 16:48:10 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207164810.GK18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-11-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-11-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/18] xen: add header and build
 dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 03:08:36PM +0000, Paul Durrant wrote:
> This patch adds the transformations necessary to get dataplane/xen-block.c
> to build against the new XenBus/XenDevice framework. MAINTAINERS is also
> updated due to the introduction of dataplane/xen-block.h.
> 
> NOTE: Existing data structure names are retained for the moment. These will
>       be modified by subsequent patches. A typedef for XenBlockDataPlane
>       has been added to the header (based on the old struct XenBlkDev name
>       for the moment) so that the old names don't need to leak out of the
>       dataplane code.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
