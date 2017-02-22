Received: from eggs.gnu.org ([2001:4830:134:3::10]:57060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgM2V-0005Hg-00
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgM2S-0003bQ-F8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:48:19 -0500
Received: from [45.249.212.187] (port=2537 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgM2R-0003aA-Q1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:48:16 -0500
References: <1487645041-28919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58ACEDCA.3070404@huawei.com>
Date: Wed, 22 Feb 2017 09:47:54 +0800
MIME-Version: 1.0
In-Reply-To: <1487645041-28919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare: Fix memory free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: xuquan8@huawei.com, Jason Wang <jasowang@redhat.com>

On 2017/2/21 10:44, Zhang Chen wrote:
> We use g_queue_init() to init s->conn_list, so we should use g_queue_clear()
> to instead of g_queue_free().
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> ---
>   net/colo-compare.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 162fd6a..cf8c4c9 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -715,7 +715,7 @@ static void colo_compare_finalize(Object *obj)
>       qemu_chr_fe_deinit(&s->chr_sec_in);
>       qemu_chr_fe_deinit(&s->chr_out);
>
> -    g_queue_free(&s->conn_list);
> +    g_queue_clear(&s->conn_list);
>
>       if (qemu_thread_is_self(&s->thread)) {
>           /* compare connection */
>
