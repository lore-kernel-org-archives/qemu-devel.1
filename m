Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZulB-0008Ix-13
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZul4-0005JX-Ia
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:04:36 -0400
Date: Mon, 2 Jul 2018 17:04:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180702090420.GO26002@lemon.usersys.redhat.com>
References: <20180605140631.4696-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605140631.4696-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Jeff: ping? Can we have this in 3.0?

On Tue, 06/05 22:06, Fam Zheng wrote:
> Based-on: <20180529055959.32002-1-famz@redhat.com>
> ([PATCH v7 00/10] qemu-img convert with copy offloading)
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
> Fam Zheng (2):
>   block: Honour BDRV_REQ_NO_SERIALISING in copy range
>   backup: Use copy offloading
> 
>  block/backup.c        | 150 ++++++++++++++++++++++++++++++------------
>  block/io.c            |   6 +-
>  block/trace-events    |   1 +
>  include/block/block.h |   5 +-
>  4 files changed, 117 insertions(+), 45 deletions(-)
> 
> -- 
> 2.17.0
> 
