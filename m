Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkWez-00018v-1e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkWey-0004Z1-7Z
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:29:33 -0400
Date: Wed, 23 Aug 2017 15:29:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170823142917.GC2100@work-vm>
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

* Fam Zheng (famz@redhat.com) wrote:
> This fixes the issue reported as https://bugs.launchpad.net/bugs/1711602

Yep, that fixes it in my test setup (1 of 1 passes!)

Dave
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
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
