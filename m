Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dTAck-00046A-7B
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dTAcf-0003zg-8b
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:31:30 -0400
Date: Thu, 6 Jul 2017 13:38:02 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170706173801.GB27975@localhost.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, Jul 05, 2017 at 09:36:31PM +0800, Fam Zheng wrote:
> This is a new protocol driver that exclusively opens a host NVMe
> controller through VFIO. It achieves better latency than linux-aio by
> completely bypassing host kernel vfs/block layer.
> 
>     $rw-$bs-$iodepth  linux-aio     nvme://
>     ----------------------------------------
>     randread-4k-1     8269          8851
>     randread-512k-1   584           610
>     randwrite-4k-1    28601         34649
>     randwrite-512k-1  1809          1975
> 
> The driver also integrates with the polling mechanism of iothread.
> 
> This patch is co-authored by Paolo and me.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

I haven't much time to do a thorough review, but in the brief time so
far the implementation looks fine to me.

I am wondering, though, if an NVMe vfio driver can be done as its own
program that qemu can link to. The SPDK driver comes to mind as such an
example, but it may create undesirable dependencies.
