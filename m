Received: from eggs.gnu.org ([2001:4830:134:3::10]:46154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2xH-0007ht-PW
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2xG-0001Ji-UR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:08:35 -0400
References: <20180319215335.1119213-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <831cddaa-3803-10b1-8d6a-e878c97cca73@redhat.com>
Date: Mon, 19 Mar 2018 17:08:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180319215335.1119213-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>

On 03/19/2018 04:53 PM, Eric Blake wrote:
> Use the correct printf formats, so that a 32-bit compile doesn't
> spit out lots of warnings about %lx being incompatible with uint64_t.
> Broken since initial commit ef6d4ccd.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I don't know if 'make vm-build-ubuntu.i368' would catch this (it failed
> for me for other reasons); I found it via a 32-bit rawhide VM.

That fixes most of the warnings, but not:

/home/dummy/qemu/hw/rdma/rdma_backend.c: In function 
'rdma_backend_create_mr':
/home/dummy/qemu/hw/rdma/rdma_backend.c:409:37: error: cast to pointer 
from integer of different size [-Werror=int-to-pointer-cast]
      m4->ibmr = ibv_reg_m4(pd->ibpd, (void *)addr, length, access);
                                      ^

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
