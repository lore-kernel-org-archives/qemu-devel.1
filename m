Received: from eggs.gnu.org ([2001:4830:134:3::10]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjpF-0003Ne-Qq
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjpA-00011V-Vu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:19:57 -0500
Date: Tue, 11 Dec 2018 15:19:47 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181211151947.GR18875@perard.uk.xensource.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-5-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544525238-3527-5-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/18] xen: create xenstore areas for
 XenDevice-s
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

On Tue, Dec 11, 2018 at 10:47:04AM +0000, Paul Durrant wrote:
> This patch adds a new source module, xen-bus-helper.c, which builds on
> basic libxenstore primitives to provide functions to create (setting
> permissions appropriately) and destroy xenstore areas, and functions to
> 'printf' and 'scanf' nodes therein. The main xen-bus code then uses
> these primitives [1] to initialize and destroy the frontend and backend
> areas for a XenDevice during realize and unrealize respectively.
> 
> The 'xen-block' implementation is extended with a 'get_name' method that
> returns the VBD number. This number is required to 'name' the xenstore
> areas.
> 
> NOTE: An exit handler is also added to make sure the xenstore areas are
>       cleaned up if QEMU terminates without devices being unrealized.
> 
> [1] The 'scanf' functions are actually not yet needed, but they will be
>     needed by code delivered in subsequent patches.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> 
> v3:
>  - Add transaction id parameters to xen-bus-helper functions
>  - Not added Anthony's R-b because of change
> 

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
