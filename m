Received: from eggs.gnu.org ([2001:4830:134:3::10]:60756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWOF-0007lj-P2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWOE-0001C8-QL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:12:15 -0400
Date: Wed, 23 Aug 2017 15:12:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170823141201.GB16760@stefanha-x1.localdomain>
References: <20170823134242.12080-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823134242.12080-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/4] block: Fix non-shared storage
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, Aug 23, 2017 at 09:42:38PM +0800, Fam Zheng wrote:
> This fixes the issue reported as https://bugs.launchpad.net/bugs/1711602
> 
> Fam Zheng (3):
>   block-backend: Refactor inactivate check
>   block-backend: Allow more "can inactivate" cases
>   mirror: Mark target BB as "force allow inactivate"
> 
> Stefan Hajnoczi (1):
>   block: Update open_flags after ->inactivate() callback
> 
>  block.c                        |  7 +++----
>  block/block-backend.c          | 30 +++++++++++++++++++++++++-----
>  block/mirror.c                 | 14 ++++++++++++--
>  include/sysemu/block-backend.h |  1 +
>  4 files changed, 41 insertions(+), 11 deletions(-)
> 
> -- 
> 2.13.5
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
