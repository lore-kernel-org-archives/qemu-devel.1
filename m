Received: from eggs.gnu.org ([2001:4830:134:3::10]:56520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjmi-0001vS-CS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjmf-00082L-6V
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:17:20 -0500
Date: Tue, 11 Dec 2018 15:16:36 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181211151636.GQ18875@perard.uk.xensource.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-4-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544525238-3527-4-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/18] xen: introduce 'xen-block',
 'xen-disk' and 'xen-cdrom'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Dec 11, 2018 at 10:47:03AM +0000, Paul Durrant wrote:
> This patch adds new XenDevice-s: 'xen-disk' and 'xen-cdrom', both derived
> from a common 'xen-block' parent type. These will eventually replace the
> 'xen_disk' (note the underscore rather than hyphen) legacy PV backend but
> it is illustrative to build up the implementation incrementally, along with
> the XenBus/XenDevice framework. Subsequent patches will therefore add to
> these devices' implementation as new features are added to the framework.
> 
> After this patch has been applied it is possible to instantiate new
> 'xen-disk' or 'xen-cdrom' devices with a single 'vdev' parameter, which
> accepts values adhering to the Xen VBD naming scheme [1]. For example, a
> command-line instantiation of a xen-disk can be done with an argument
> similar to the following:
> 
> -device xen-disk,vdev=hda
> 
> The implementation of the vdev parameter formulates the appropriate VBD
> number for use in the PV protocol.
> 
> [1] https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Now we can add a xen-disk with vdev=xvdbgqcv :)

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
