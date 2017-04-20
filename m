Received: from eggs.gnu.org ([2001:4830:134:3::10]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1DuK-0006SZ-O6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1DuJ-0007vw-P8
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:22:08 -0400
Date: Thu, 20 Apr 2017 11:21:59 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170420152159.GA3676@localhost.localdomain>
References: <20170420040003.31074-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420040003.31074-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On Thu, Apr 20, 2017 at 12:00:03PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/sheepdog.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index fb9203e..7e889ee 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
>          qemu_set_nonblock(fd);
>      } else {
>          fd = -EIO;
> +        error_setg(errp, "Failed to connect to sheepdog server");
>      }

A bit odd that we don't just return right away in this function after a
failed called to socket_connect(), but that has nothing to do with your
patch.

Reviewed-by: Jeff Cody <jcody@redhat.com>


>  
>      return fd;
> -- 
> 2.9.3
> 
