Received: from eggs.gnu.org ([2001:4830:134:3::10]:46836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cooEZ-0003Na-Vz
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cooEW-0005pY-SN
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:31:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170317015630.30396-1-famz@redhat.com>
References: <20170317015630.30396-1-famz@redhat.com>
Date: Fri, 17 Mar 2017 10:31:37 +0100
Message-ID: <w51d1dg45c6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9] block: Propagate
 error in bdrv_open_backing_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 17 Mar 2017 02:56:30 AM CET, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block.c b/block.c
> index cb57370..6621167 100644
> --- a/block.c
> +++ b/block.c
> @@ -2025,6 +2025,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>      bdrv_set_backing_hd(bs, backing_hd, &local_err);
>      bdrv_unref(backing_hd);
>      if (local_err) {
> +        error_propagate(errp, local_err);
>          ret = -EINVAL;
>          goto free_exit;
>      }

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
