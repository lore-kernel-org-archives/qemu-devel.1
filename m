Received: from eggs.gnu.org ([209.51.188.92]:47713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyGtL-0004xR-Q5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyGtI-0008DD-Hi
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:05:57 -0500
Date: Mon, 25 Feb 2019 15:05:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190225140544.GD6320@linux.fritz.box>
References: <20190208154453.25602-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208154453.25602-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Assert that L2 table offsets fit in
 the L1 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 08.02.2019 um 16:44 hat Alberto Garcia geschrieben:
> L1 table entries have a field to store the offset of an L2 table.
> The rest of the bits of the entry are currently reserved except from
> bit 63, which stores the COPIED flag.
> 
> The offset is always taken from the entry using L1E_OFFSET_MASK to
> ensure that we only use the bits that belong to that field.
> 
> While that mask is used every time we read from the L1 table, it is
> never used when we write to it. Due to the limits set elsewhere in the
> code QEMU can never produce L2 table offsets that don't fit in that
> field so any such offset when allocating an L2 table would indicate a
> bug in QEMU.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
