Received: from eggs.gnu.org ([2001:4830:134:3::10]:49591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcRj-0003C5-Q5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcRg-0003Jn-5x
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:17:11 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:9753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcRf-0003Hq-Op
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:17:07 -0400
Date: Fri, 18 May 2018 11:17:03 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180518101703.GQ2057@perard.uk.xensource.com>
References: <20180515164053.14604-1-paul.durrant@citrix.com>
	<20180515164053.14604-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180515164053.14604-4-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] xen-hvm: try to use
 xenforeignmemory_map_resource() to map ioreq pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Tue, May 15, 2018 at 05:40:53PM +0100, Paul Durrant wrote:
> Xen 4.11 has a new API to directly map guest resources. Among the resources
> that can be mapped using this API are ioreq pages.
> 
> This patch modifies QEMU to attempt to use the new API should it exist,
> falling back to the previous mechanism if it is unavailable.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
