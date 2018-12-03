Received: from eggs.gnu.org ([2001:4830:134:3::10]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTrCI-0003Ur-Ls
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTrCH-0007W9-T5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:35:50 -0500
Date: Mon, 3 Dec 2018 16:35:39 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181203163539.GN14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-9-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-9-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 08/18] xen: duplicate xen_disk.c as basis
 of dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:12:01PM +0000, Paul Durrant wrote:
> The new xen-qdisk XenDevice implementation requires the same core dataplane
> as the legacy xen_disk implementation it will eventually replace. This
> patch therefore copies the legacy xen_disk.c source module into a new
> dataplane/xen-qdisk.c source module as the basis for the new dataplane and
> adjusts the MAINTAINERS file accordingly.
> 
> NOTE: The duplicated code is not yet built. It is simply put into place by
>       this patch (just fixing style violations) such that the
>       modifications that will need to be made to the code are not
>       conflated with code movement, thus making review harder.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
