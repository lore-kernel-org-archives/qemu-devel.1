Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fwOSF-0004vT-8X
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 05:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fwOSA-0006O3-Az
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 05:13:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fwOSA-0006NG-1n
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 05:13:54 -0400
Date: Sun, 2 Sep 2018 12:13:07 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180902091306.GA7037@lap1>
References: <20180902084813.12230-1-yuval.shaia@oracl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902084813.12230-1-yuval.shaia@oracl.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] pvrdma: Extend device state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracl.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On Sun, Sep 02, 2018 at 11:48:11AM +0300, Yuval Shaia wrote:
> pvrdma device state is compose of the state of the following:
> - rdma backend device
> - vmxnet3 device on PCI function 0
> - pvrdma device on PCI function 1
> 
> This patch-set aim to make it.
> 
> Patch 1: Make vmxnet3 accessible from other devices
> Patch 2: Take vnmxnet3 state into account
> 
> 
> Yuval Shaia (2):
>   vmxnet3: Move some definitions to header file
>   hw/pvrdma: Add support for port state
> 
>  hw/net/vmxnet3.c          | 116 +--------------------------------
>  hw/net/vmxnet3_defs.h     | 133 ++++++++++++++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma.h      |   3 +
>  hw/rdma/vmw/pvrdma_cmd.c  |  12 +++-
>  hw/rdma/vmw/pvrdma_main.c |  14 +++-
>  5 files changed, 160 insertions(+), 118 deletions(-)
>  create mode 100644 hw/net/vmxnet3_defs.h

Please ignore this patch-set, i will send v2 with a missing functionality.

> 
> -- 
> 2.17.1
> 
