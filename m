Received: from eggs.gnu.org ([2001:4830:134:3::10]:52478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dIEva-0006C6-LO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dIEvW-0002MH-PL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:53:46 -0400
References: <1496732599-7977-1-git-send-email-sochin.jiang@huawei.com>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <70170168-958d-d4fa-9580-9445ce173f91@huawei.com>
Date: Tue, 6 Jun 2017 21:53:18 +0800
MIME-Version: 1.0
In-Reply-To: <1496732599-7977-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: supplement the omitted 'disk
 size' bytes info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

Please ignore this patch, I realize that there are some unfixed problems,
like iotest, etc.

On 2017/6/6 15:03, sochin.jiang wrote:
> From: "sochin.jiang" <sochin.jiang@huawei.com>
>
>  Supplement the omitted 'disk size' bytes information when using
>
>  'qemu-img info',it is useful in some occasion. Anyhow, it looks
>
>  strange that 'virtual size' has bytes while actual 'disk size'
>
>  does not.
>
> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
> ---
>  block/qapi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/qapi.c b/block/qapi.c
> index a40922e..9bb5956 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -703,10 +703,11 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
>                   "image: %s\n"
>                   "file format: %s\n"
>                   "virtual size: %s (%" PRId64 " bytes)\n"
> -                 "disk size: %s\n",
> +                 "disk size: %s (%" PRId64 " bytes)\n",
>                   info->filename, info->format, size_buf,
>                   info->virtual_size,
> -                 dsize_buf);
> +                 dsize_buf,
> +                 info->actual_size);
>  
>      if (info->has_encrypted && info->encrypted) {
>          func_fprintf(f, "encrypted: yes\n");
