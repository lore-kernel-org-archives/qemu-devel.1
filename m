Received: from eggs.gnu.org ([2001:4830:134:3::10]:34595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duJje-0000QG-FB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duJja-0006It-OM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:42:50 -0400
Date: Tue, 19 Sep 2017 22:42:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170919144229.GA18491@lemon>
References: <20170918185819.5984-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918185819.5984-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/20] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

On Mon, 09/18 13:57, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
> 
> Now that 2.11 is open, I'm rebasing/reposting the remaining patches.
> 
> The overall conversion currently looks like:
> part 1: bdrv_is_allocated (merged in 2.10, commit 51b0a488)
> part 2: dirty-bitmap (this series, v7 was here [1])
> part 3: bdrv_get_block_status (v4 is posted [2] and is mostly reviewed)
> part 4: .bdrv_co_block_status (v3 is posted [3], but needs review)

Patches 1-4, 6-20:

Reviewed-by: Fam Zheng <famz@redhat.com>
