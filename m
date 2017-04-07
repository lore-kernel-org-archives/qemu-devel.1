Received: from eggs.gnu.org ([2001:4830:134:3::10]:51523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwO6i-0007OS-0q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwO6h-0003vE-C4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:14:56 -0400
Date: Fri, 7 Apr 2017 15:14:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170407071444.GF4618@lemon>
References: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] commit: Fix commit_top_bs
 problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Thu, 04/06 19:14, Kevin Wolf wrote:
> The same problem that Fam's patch "mirror: Fix aio context of
> mirror_top_bs" fixes for the mirror block job also exists for the
> commit block job and the 'commit' HMP command. While comparing the
> respective places in mirror.c and commit.c, I also noticed that
> commit neglects to set an image size.
> 
> This series fixes both problems.
> 
> Kevin Wolf (2):
>   commit: Set commit_top_bs->aio_context
>   commit: Set commit_top_bs->total_sectors
> 
>  block/commit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> -- 
> 1.8.3.1
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
