Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJGBn-0006R2-Kz
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJGBj-0001w3-Nm
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:31:15 -0400
Date: Thu, 17 May 2018 11:31:05 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180517103105.GJ2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-6-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-6-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/8] xen_disk: remove use of grant
 map/unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, May 04, 2018 at 08:26:04PM +0100, Paul Durrant wrote:
> Now that the (native or emulated) xen_be_copy_grant_refs() helper is
> always available, the xen_disk code can be significantly simplified by
> removing direct use of grant map and unmap operations.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
