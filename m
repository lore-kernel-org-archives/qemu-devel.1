Received: from eggs.gnu.org ([2001:4830:134:3::10]:39940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1qpF-0000pL-SW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1qpF-0006mO-21
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:27:45 -0400
Date: Tue, 10 Oct 2017 11:27:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010092727.GE4177@dhcp-200-186.str.redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-9-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-9-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/18] block/mirror: Use source as a
 BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Am 13.09.2017 um 20:19 hat Max Reitz geschrieben:
> With this, the mirror_top_bs is no longer just a technically required
> node in the BDS graph but actually represents the block job operation.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/mirror.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 2ece38094d..9df4157511 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -43,8 +43,8 @@ typedef struct MirrorBlockJob {
>      RateLimit limit;
>      BlockBackend *target;
>      BlockDriverState *mirror_top_bs;
> -    BlockDriverState *source;
>      BlockDriverState *base;
> +    BdrvChild *source;

Is it actually useful to store source seperately when we already have
mirror_top_bs->backing?

Kevin
