Received: from eggs.gnu.org ([2001:4830:134:3::10]:34969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eGmyH-0008Ka-5J
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eGmyG-00016C-A3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:22:49 -0500
Date: Mon, 20 Nov 2017 22:22:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171120142238.GA6828@lemon.lan>
References: <20171120141141.24626-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120141141.24626-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/2] Fix 'qemu-img info' on mirror
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Mon, 11/20 15:11, Kevin Wolf wrote:
> There is no reason to forbid 'qemu-img info' for an image that is used
> as a mirror target (or intermediate image of a commit job) at the same
> time.
> 
> This fixes the problem reported on qemu-discuss:
> https://lists.gnu.org/archive/html/qemu-discuss/2017-11/msg00039.html
> 
> Kevin Wolf (2):
>   block: Don't use BLK_PERM_CONSISTENT_READ for format probing
>   block: Don't request I/O permission with BDRV_O_NO_IO
> 
>  block.c               |  5 ++++-
>  block/block-backend.c | 10 ++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> -- 
> 2.13.6
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
