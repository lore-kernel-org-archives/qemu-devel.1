Received: from eggs.gnu.org ([2001:4830:134:3::10]:60950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv1dv-0005hP-7m
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv1du-0005HK-B8
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:35:51 -0400
Date: Thu, 21 Sep 2017 21:35:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170921133535.GI13703@lemon.lan>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921131707.17364-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add bdrv_co_drain_begin/end
 BlockDriver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, 09/21 16:17, Manos Pitsidianakis wrote:
> This patch series renames bdrv_co_drain to bdrv_co_drain_begin and adds a new 
> bdrv_co_drain_end callback to match bdrv_drained_begin/end and 
> drained_begin/end of BdrvChild. This is needed because the throttle driver 
> (block/throttle.c) needs a way to mark the end of the drain in order to toggle 
> io_limits_disabled correctly.

Is this a bug fix? I.e. do we need to Cc qemu-stable@?

Fam
