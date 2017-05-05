Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1d6aC7-0000vt-QD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1d6aC1-0004Y6-V5
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:10:39 -0400
Date: Fri, 5 May 2017 12:10:26 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20170505101026.GA7095@lst.de>
References: <20170505090044.28754-1-hch@lst.de>
	<f282c1fb-6c8b-a16d-8ce0-5ce244ec4fb2@redhat.com>
	<20170505095105.GA6630@lst.de>
	<f8a6ae1b-fc48-4c15-1b15-bd966b00c00e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a6ae1b-fc48-4c15-1b15-bd966b00c00e@redhat.com>
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

On Fri, May 05, 2017 at 12:03:40PM +0200, Paolo Bonzini wrote:
> While that's allowed and it makes sense indeed on SSDs, for QEMU's
> typical usage it can lead to fragmentation and worse performance.  On
> extent-based file systems, write zeroes without deallocate can be
> implemented very efficiently with FALLOC_FL_ZERO_RANGE, and there's no
> reason not to do it.

Ok..

> Is there anything backwards-incompatible in 1.3 that would make it hard
> to just bump the supported version?

1.2.1 requires a valid NQN in Identify Controller, and 1.3 requires
the new Identify CNS 03h for controller identification.  Otherwise
it's mostly fine tuning corner conditions for which I'd have to audit
the code.
