Received: from eggs.gnu.org ([2001:4830:134:3::10]:55558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcqc-0007Cf-A8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcqY-0001Dn-Cw
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:42:54 -0400
Date: Fri, 18 May 2018 11:42:46 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180518104246.GT2057@perard.uk.xensource.com>
References: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
	<1526571358-26685-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1526571358-26685-3-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/9] xen_backend: add grant table helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, May 17, 2018 at 04:35:51PM +0100, Paul Durrant wrote:
> This patch adds grant table helper functions to the xen_backend code to
> localize error reporting and use of xen_domid.
> 
> The patch also defers the call to xengnttab_open() until just before the
> initialise method in XenDevOps is invoked. This method is responsible for
> mapping the shared ring. No prior method requires access to the grant table.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
