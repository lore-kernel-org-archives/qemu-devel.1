Received: from eggs.gnu.org ([2001:4830:134:3::10]:34635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e2z3t-0004G8-1D
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 08:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e2z3o-00017V-W6
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 08:27:33 -0400
Date: Fri, 13 Oct 2017 13:27:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171013122725.GG27308@stefanha-x1.localdomain>
References: <20170923111411.18626-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170923111411.18626-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] add
 bdrv_co_drain_begin/end BlockDriver callbacks
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

On Sat, Sep 23, 2017 at 02:14:08PM +0300, Manos Pitsidianakis wrote:
> This patch series renames bdrv_co_drain to bdrv_co_drain_begin and adds a new 
> bdrv_co_drain_end callback to match bdrv_drained_begin/end and 
> drained_begin/end of BdrvChild. This is needed because the throttle driver 
> (block/throttle.c) needs a way to mark the end of the drain in order to toggle 
> io_limits_disabled correctly.
> 
> Based-on: <20170918202529.28379-1-el13635@mail.ntua.gr>
>     "block/throttle-groups.c: allocate RestartData on the heap"
>     Which fixes a coroutine crash in block/throttle-groups.c
> 
> v3:
>   fixed commit message typo in first patch [Fam]
>   rephrased doc comment based on mailing discussion
> v2: 
>   add doc for callbacks and change order of request polling for completion 
>   [Stefan]
> 
> Manos Pitsidianakis (3):
>   block: add bdrv_co_drain_end callback
>   block: rename bdrv_co_drain to bdrv_co_drain_begin
>   block/throttle.c: add bdrv_co_drain_begin/end callbacks
> 
>  include/block/block_int.h | 13 ++++++++++---
>  block/io.c                | 48 +++++++++++++++++++++++++++++++++--------------
>  block/qed.c               |  6 +++---
>  block/throttle.c          | 18 ++++++++++++++++++
>  4 files changed, 65 insertions(+), 20 deletions(-)
> 
> -- 
> 2.11.0
> 
> 

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan
