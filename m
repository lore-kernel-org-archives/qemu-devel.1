Received: from eggs.gnu.org ([2001:4830:134:3::10]:54918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cgRyO-0005Lx-SH
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cgRyN-0000S9-Tw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:08:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cgRyN-0000S5-OP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:08:27 -0500
References: <1487740566-15302-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c55de8f3-8abd-01a1-76be-d7464366f145@redhat.com>
Date: Wed, 22 Feb 2017 16:08:22 +0800
MIME-Version: 1.0
In-Reply-To: <1487740566-15302-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] net/colo-compare: Fix memory free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>



On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 13:16, Zhang Chen wrote:
> We use g_queue_init() to init s->conn_list, so we should use g_queue_cl=
ear()
> to instead of g_queue_free().
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a6fc2ff..300f017 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -729,7 +729,7 @@ static void colo_compare_finalize(Object *obj)
>       /* Release all unhandled packets after compare thead exited */
>       g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>  =20
> -    g_queue_free(&s->conn_list);
> +    g_queue_clear(&s->conn_list);
>  =20
>       g_hash_table_destroy(s->connection_track_table);
>       g_free(s->pri_indev);
