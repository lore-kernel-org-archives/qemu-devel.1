Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1egzCA-0007yo-1z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1egzC6-0005ly-5j
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:41:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1egzC6-0005lb-0I
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:41:22 -0500
Date: Wed, 31 Jan 2018 18:40:59 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180131204059.GG21702@localhost.localdomain>
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-2-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117095421.124787-2-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V8 1/4] mem: add share parameter to
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
Cc: qemu-devel@nongnu.org, mst@redhat.com, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Wed, Jan 17, 2018 at 11:54:18AM +0200, Marcel Apfelbaum wrote:
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

Why do we need to make this configurable?  Would anything break
if MAP_SHARED was always used if possible?


> Moved the "share" flag to the Host Memory base class,
> modified phys_mem_alloc to include the new parameter
> and a new interface memory_region_init_ram_shared_nomigrate.
> 
> There are no functional changes if the new flag is not used.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
[...]

-- 
Eduardo
