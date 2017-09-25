Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQHL-0007ES-NC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQHH-0004FI-Dk
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:06:19 -0400
Date: Mon, 25 Sep 2017 11:06:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925100612.GI14140@stefanha-x1.localdomain>
References: <20170923111411.18626-1-el13635@mail.ntua.gr>
	<20170923111411.18626-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170923111411.18626-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_co_drain_end callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Sat, Sep 23, 2017 at 02:14:09PM +0300, Manos Pitsidianakis wrote:
> BlockDriverState has a bdrv_co_drain() callback but no equivalent for
> the end of the drain. The throttle driver (block/throttle.c) needs a way
> to mark the end of the drain in order to toggle io_limits_disabled
> correctly, thus bdrv_co_drain_end is needed.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  include/block/block_int.h | 11 +++++++++--
>  block/io.c                | 48 +++++++++++++++++++++++++++++++++--------------
>  2 files changed, 43 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
