Received: from eggs.gnu.org ([2001:4830:134:3::10]:42875)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1d6ZtI-0002KC-GY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1d6ZtH-0008DO-Qz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:51:12 -0400
Date: Fri, 5 May 2017 11:51:05 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20170505095105.GA6630@lst.de>
References: <20170505090044.28754-1-hch@lst.de>
	<f282c1fb-6c8b-a16d-8ce0-5ce244ec4fb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f282c1fb-6c8b-a16d-8ce0-5ce244ec4fb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Implement Write Zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, May 05, 2017 at 11:30:11AM +0200, Paolo Bonzini wrote:
> could you pass BDRV_REQ_MAY_UNMAP for the flags here if the deallocate
> bit (dword 12 bit 25) is set?

In fact we should do that unconditonally.  The deallocate bit is new
in 1.3 (which we don't claim to support) and forces deallocating, but
NVMe already allows for this behavior without the flag (we in fact
explicitly clarified this in an ECN for 1.2.1).
