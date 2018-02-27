Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqdjC-0004N5-2H
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqdjB-0004J6-6W
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:47:26 -0500
Date: Tue, 27 Feb 2018 12:47:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180227114702.GA5269@localhost.localdomain>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222155922.9833-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berto@igalia.com, Max Reitz <mreitz@redhat.com>

Am 22.02.2018 um 16:59 hat Eric Blake geschrieben:
> Although off_t permits up to 63 bits (8EB) of file offsets, in
> practice, we're going to hit other limits first.  Document some
> of those limits in the qcow2 spec, and how choice of cluster size
> can influence some of the limits.
> 
> While at it, notice that since we cannot map any virtual cluster
> to any address higher than 64 PB (56 bits) (due to the L1/L2 field
> encoding), it makes little sense to require the refcount table to
> access host offsets beyond that point.  Mark the upper bits of
> the refcount table entries as reserved, with no ill effects, since
> it is unlikely that there are any existing images larger than 64PB
> in the first place, and thus all existing images already have those
> bits as 0.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

I think it would be good to mention the exact reason for the 56 bits in
the spec. Even this commit message is rather vague ('L1/L2 field
encoding'), so if at some point someone wonders, if we couldn't simply
extend the allowed range, they won't easily see that it's related to
compressed clusters.

Kevin
