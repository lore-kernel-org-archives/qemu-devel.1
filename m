Received: from eggs.gnu.org ([2001:4830:134:3::10]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cuw45-00059C-O2
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cuw40-00054j-PN
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:06:13 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c0c7176-dd02-720c-11c7-493526cec6d5@redhat.com>
Date: Mon, 3 Apr 2017 09:06:02 +0200
MIME-Version: 1.0
In-Reply-To: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: fix memory leak on socket_connect
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yaolujing <yaolujing@huawei.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, zhangshuai13@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com, sochin.jiang@huawei.com



On 01/04/2017 02:15, yaolujing wrote:
> From: y00357587 <yaolujing@huawei.com>
> 
> When TCP connection fails between nbd server and client,
> the local var, sioc, memory leak.
> 
> This patch fixes the memory leak.
> 
> Signed-off-by: y00357587 <yaolujing@huawei.com>
> ---
>  block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 35f24be..102285e 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -313,6 +313,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
>                                      saddr,
>                                      &local_err);
>      if (local_err) {
> +        object_unref(OBJECT(sioc));
>          error_propagate(errp, local_err);
>          return NULL;
>      }
> 

Queued, thanks.

Paolo
