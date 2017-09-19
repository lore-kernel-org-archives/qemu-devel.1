Received: from eggs.gnu.org ([2001:4830:134:3::10]:42590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duHut-0000xK-Ar
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duHus-00087f-JB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:46:19 -0400
Date: Tue, 19 Sep 2017 14:46:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170919124608.GE3789@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Am 18.09.2017 um 20:57 hat Eric Blake geschrieben:
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

I agree with Fam's comment on patch 5 and had a question on patch 18.

Everything else is
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
