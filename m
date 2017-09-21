Received: from eggs.gnu.org ([2001:4830:134:3::10]:59509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv1Z7-0002ag-NG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv1Z6-0001tk-Ud
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:30:53 -0400
Date: Thu, 21 Sep 2017 21:30:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170921133037.GF13703@lemon.lan>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
	<20170921131707.17364-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921131707.17364-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: add bdrv_co_drain_end
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 09/21 16:17, Manos Pitsidianakis wrote:
> BlockDriverState has a bdrv_do_drain() callback but no equivalent for the end
> of the drain. The throttle driver (block/throttle.c) needs a way to mark the
> end of the drain in order to toggle io_limits_disabled correctly, thus
> bdrv_co_drain_end is needed.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Fam Zheng <famz@redhat.com>
