Received: from eggs.gnu.org ([2001:4830:134:3::10]:55207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elhKZ-0008EL-Ul
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elhKW-0006pu-Sv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:37:35 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elhKW-0006pd-N7
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:37:32 -0500
Received: by mail-qt0-x244.google.com with SMTP id g14so5164065qti.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:37:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180213050837.40964-1-linzhecheng@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91ad0c10-646f-2c03-46eb-504d6606956a@amsat.org>
Date: Tue, 13 Feb 2018 17:37:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180213050837.40964-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, wangxinxin.wang@huawei.com, lidonglin@huawei.com, pbonzini@redhat.com

On 02/13/2018 02:08 AM, linzhecheng wrote:
> g_free() was moved from vhost_net_cleanup in commit e6bcb1b, so we should
> free net after vhost_net_cleanup
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index cb45512506..d024573e45 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -109,6 +109,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
>  err:
>      if (net) {
>          vhost_net_cleanup(net);
> +        g_free(net);
>      }
>      vhost_user_stop(i, ncs);
>      return -1;
> 
