Received: from eggs.gnu.org ([2001:4830:134:3::10]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSJg2-0006pl-LW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSJg2-00062W-1r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:59:22 -0400
Date: Tue, 4 Jul 2017 16:59:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704085910.GJ10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-10-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/15] block: Switch
 bdrv_co_get_block_status() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Mon, 07/03 17:14, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change), and as with its public counterpart,
> rename to bdrv_co_block_status() to make the compiler enforce that
> we catch all uses.  For now, we assert that callers still pass
> aligned data, but ultimately, this will be the function where we
> hand off to a byte-based driver callback, and will eventually need
> to add logic to ensure we round calls according to the driver's
> request_alignment then touch up the result handed back to the
> caller, to start permitting a caller to pass unaligned offsets.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
