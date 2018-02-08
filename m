Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejtJN-0007UR-Se
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejtJJ-0004rD-30
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:00:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejtJI-0004qt-So
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:00:49 -0500
Date: Thu, 8 Feb 2018 19:00:35 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180208210035.GK13301@localhost.localdomain>
References: <20180201205511.19198-1-marcel@redhat.com>
	<20180201205511.19198-2-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201205511.19198-2-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V9 1/4] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, cohuck@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, dotanb75@yahoo.com

On Thu, Feb 01, 2018 at 10:55:08PM +0200, Marcel Apfelbaum wrote:
> Currently only file backed memory backend can
> be created with a "share" flag in order to allow
> sharing guest RAM with other processes in the host.
> 
> Add the "share" flag also to RAM Memory Backend
> in order to allow remapping parts of the guest RAM
> to different host virtual addresses. This is needed
> by the RDMA devices in order to remap non-contiguous
> QEMU virtual addresses to a contiguous virtual address range.
> 
> Moved the "share" flag to the Host Memory base class,
> modified phys_mem_alloc to include the new parameter
> and a new interface memory_region_init_ram_shared_nomigrate.
> 
> There are no functional changes if the new flag is not used.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Code looks correct, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

But later can we please stop the explosion of memory_init_ram*()
functions and replace them with a single function with a flags
parameter?

-- 
Eduardo
