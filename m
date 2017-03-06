Received: from eggs.gnu.org ([2001:4830:134:3::10]:33852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckvkd-000400-FY
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckvkY-0007ns-Jz
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:44:47 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-2-git-send-email-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a252e75-f310-52ca-e87e-00178dec8a9c@amsat.org>
Date: Mon, 6 Mar 2017 13:44:37 -0300
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] commit: Fix error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 03/06/2017 01:21 PM, Kevin Wolf wrote:
> Apparently some kind of mismerge happened in commit 8dfba279, which
> broke the error handling without any real reason by removing the
> assignment of the return value to ret in a blk_insert_bs() call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/commit.c b/block/commit.c
> index 22a0a4d..e57c1cf 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -364,7 +364,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>
>      /* Required permissions are already taken with block_job_add_bdrv() */
>      s->top = blk_new(0, BLK_PERM_ALL);
> -    blk_insert_bs(s->top, top, errp);
> +    ret = blk_insert_bs(s->top, top, errp);
>      if (ret < 0) {
>          goto fail;
>      }
>
