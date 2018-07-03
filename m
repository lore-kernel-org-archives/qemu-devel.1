Received: from eggs.gnu.org ([2001:4830:134:3::10]:44977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1faBwM-0007ex-BT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1faBwL-0007I4-IL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:25:18 -0400
Date: Mon, 2 Jul 2018 23:25:06 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180703032506.GB4184563@localhost.localdomain>
References: <20180703023758.14422-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703023758.14422-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Jul 03, 2018 at 10:37:55AM +0800, Fam Zheng wrote:
> v4: Rebase to master.
>     Pick up Stefan's rev-bys.
>     Include a block/io.c fix to fix a new issue caused by recent block/io.c
>     change - our drive-backup cases in iotests exposes the bug loudly.
> 
> This enhances the backup job to make use of the copy offloading API. It
> eliminates the necessity to use the bounce buffer as well as speeding up the
> copy operation when the backend supports it.
> 
> v3: Don't forget coroutine_fn. [Stefan]
>     Don't reset job->use_copy_range redundantly. [Stefan]
> 
> v2: Use helper functions. [Stefan]
> 
> Fam Zheng (3):
>   block: Fix parameter checking in bdrv_co_copy_range_internal
>   block: Honour BDRV_REQ_NO_SERIALISING in copy range
>   backup: Use copy offloading
> 
>  block/backup.c        | 150 ++++++++++++++++++++++++++++++------------
>  block/io.c            |  35 +++++-----
>  block/trace-events    |   1 +
>  include/block/block.h |   5 +-
>  4 files changed, 132 insertions(+), 59 deletions(-)
> 
> -- 
> 2.17.1
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
