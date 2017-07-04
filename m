Received: from eggs.gnu.org ([2001:4830:134:3::10]:40467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSKTy-0007VC-6X
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSKTx-0007RT-Fy
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:50:58 -0400
Date: Tue, 4 Jul 2017 17:50:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704095047.GP10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-16-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-16-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/15] qemu-io: Relax 'alloc' now that
 block-status doesn't assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr

On Mon, 07/03 17:14, Eric Blake wrote:
> Previously, the alloc command required that input parameters be
> sector-aligned and clamped to 32 bits, because the underlying
> bdrv_is_allocated used a 32-bit parameter and asserted aligned
> inputs.  But now that we have fixed block status to report a
> 64-bit bytes value, and to properly round requests on behalf of
> guests, we can pass any values, and can use qemu-io to add
> coverage that our rounding is correct regardless of the guest
> alignment constraints.
> 
> Update iotest 177 to intentionally probe block status at
> unaligned boundaries, which also required tweaking the image
> prep to leave an unallocated portion to the image under test.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
