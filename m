Received: from eggs.gnu.org ([2001:4830:134:3::10]:43451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIxRw-0005nD-4g
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIxRt-0001YE-1G
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:30:40 -0400
Date: Wed, 16 May 2018 15:30:32 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180516143032.GI2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-5-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-5-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/8] xen_backend: add an emulation of
 grant copy
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

On Fri, May 04, 2018 at 08:26:03PM +0100, Paul Durrant wrote:
> Not all Xen environments support the xengnttab_grant_copy() operation.
> E.g. where the OS is FreeBSD or Xen is older than 4.8.0.
> 
> This patch introduces an emulation of that operation using
> xengnttab_map_domain_grant_refs() and memcpy() for those environments.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---

The patch looks ok, but since patch 1 is going to be change, this one is
going to need to be change as well.

-- 
Anthony PERARD
