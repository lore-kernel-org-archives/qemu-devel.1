Received: from eggs.gnu.org ([208.118.235.92]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90051d582=anthony.perard@citrix.com>)
	id 1gfRzd-0004q6-FB
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90051d582=anthony.perard@citrix.com>)
	id 1gfRza-0002bk-Aj
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:06:41 -0500
Date: Fri, 4 Jan 2019 15:56:15 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190104155615.GD1508@perard.uk.xensource.com>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-10-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181220171439.11159-10-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/18] xen: remove unnecessary code from
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 20, 2018 at 05:14:30PM +0000, Paul Durrant wrote:
> Not all of the code duplicated from xen_disk.c is required as the basis for
> the new dataplane implementation so this patch removes extraneous code,
> along with the legacy #includes and calls to the legacy xen_pv_printf()
> function. Error messages are changed to be reported using error_report().
> 
> NOTE: The code is still not yet built. Further transformations will be
>       required to make it correctly interface to the new XenBus/XenDevice
>       framework. They will be delivered in a subsequent patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
