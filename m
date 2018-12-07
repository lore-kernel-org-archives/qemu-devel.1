Received: from eggs.gnu.org ([2001:4830:134:3::10]:57101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVKte-0006u9-BT
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVKtd-0006aK-GS
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:30:42 -0500
Date: Fri, 7 Dec 2018 18:30:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207183031.GN18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-16-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-16-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/18] xen: add a mechanism to
 automatically create XenDevice-s...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 03:08:41PM +0000, Paul Durrant wrote:
> ...that maintains compatibility with existing Xen toolstacks.
> 
> Xen toolstacks instantiate PV backends by simply writing information into
> xenstore and expecting a backend implementation to be watching for this.
> 
> This patch adds a new 'xen-backend' module to allow individual XenDevice
> implementations to register a creator function to be called when a tool-
> stack instantiates a new backend in this way.
> 
> To support this it is also necessary to add new watchers into the XenBus
> implementation to handle enumeration of new backends and also destruction
> of XenDevice-s when the toolstack sets the backend 'online' key to 0.
> 
> NOTE: This patch only adds the framework. A subsequent patch will add a
>       creator function for xen-block devices.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
