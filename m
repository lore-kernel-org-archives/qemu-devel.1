Received: from eggs.gnu.org ([2001:4830:134:3::10]:42780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehKFX-0000UV-RS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehKFU-00057o-LA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ehKFU-00056r-Et
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:10:16 -0500
Date: Thu, 1 Feb 2018 21:10:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201210547-mutt-send-email-mst@kernel.org>
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-4-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117095421.124787-4-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V8 3/4] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, f4bug@amsat.org

> diff --git a/hw/rdma/vmw/vmw_pvrdma-abi.h b/hw/rdma/vmw/vmw_pvrdma-abi.h
> new file mode 100644
> index 0000000000..8cfb9d7745
> --- /dev/null
> +++ b/hw/rdma/vmw/vmw_pvrdma-abi.h

Why do you copy this here? Why not import it
from include/uapi/rdma/vmw_pvrdma-abi.h in Linux into
standard headers?

-- 
MST
