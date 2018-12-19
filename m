Received: from eggs.gnu.org ([2001:4830:134:3::10]:58200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884673768=anthony.perard@citrix.com>)
	id 1gZb9p-0000N6-6A
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884673768=anthony.perard@citrix.com>)
	id 1gZb9o-0005ab-DI
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:41:01 -0500
Date: Wed, 19 Dec 2018 12:40:49 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181219124049.GB1288@perard.uk.xensource.com>
References: <20181217133011.31433-1-paul.durrant@citrix.com>
	<20181217133011.31433-16-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217133011.31433-16-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v6 15/18] xen: add a mechanism to
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

On Mon, Dec 17, 2018 at 01:30:08PM +0000, Paul Durrant wrote:
> ...that maintains compatibility with existing Xen toolstacks.
> 
> Xen toolstacks instantiate PV backends by simply writing information into
> xenstore and expecting a backend implementation to be watching for this.
> 
> This patch adds a new 'xen-backend' module to allow individual XenDevice
> implementations to register create and destroy functions. The creator
> will be called when a tool-stack instantiates a new backend in this way,
> and the destructor will then be called after the resulting XenDevice
> object is unrealized.
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

-- 
Anthony PERARD
