Received: from eggs.gnu.org ([2001:4830:134:3::10]:40141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clB4y-0000hZ-HR
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clB4x-0002eS-Nx
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:06:48 -0500
Date: Tue, 7 Mar 2017 17:06:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170307090639.GD29283@lemon.lan>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] block: Op blocker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Mon, 03/06 17:21, Kevin Wolf wrote:
> This series fixes a few problems introduced recently with the op blocker
> series. It includes mainly fix for cases where qemu would abort()
> instead of doing proper error handling previously. These changes also
> happen to result in more complete and correct permission checking.
> 
> Kevin Wolf (10):
>   commit: Fix error handling
>   mirror: Fix permission problem with 'replaces'
>   mirror: Fix permissions for removing mirror_top_bs
>   mirror: Fix error path for dirty bitmap creation
>   block: Fix blockdev-snapshot error handling
>   block: Factor out should_update_child()
>   block: Factor out bdrv_replace_child_noperm()
>   block: Ignore multiple children in bdrv_check_update_perm()
>   block: Handle permission errors in change_parent_backing_link()
>   block: Fix error handling in bdrv_replace_in_backing_chain()
> 
>  block.c                   | 182 ++++++++++++++++++++++++++++++----------------
>  block/commit.c            |   2 +-
>  block/mirror.c            |  35 +++++----
>  blockdev.c                |   6 +-
>  include/block/block.h     |   4 +-
>  include/block/block_int.h |   6 +-
>  6 files changed, 152 insertions(+), 83 deletions(-)
> 
> -- 
> 1.8.3.1
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
