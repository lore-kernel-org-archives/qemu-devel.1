Received: from eggs.gnu.org ([2001:4830:134:3::10]:56174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5Nkr-0000uI-QL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5Nkn-0008AI-0T
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:13:49 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:53540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5Nkm-0008A1-SA
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:13:44 -0400
Received: by mail-qk0-x243.google.com with SMTP id y23so12841077qkb.10
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 20:13:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508468326-18354-1-git-send-email-lu.zhipeng@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4dc0f3f-ac14-eebe-9408-73d54c4584c4@amsat.org>
Date: Fri, 20 Oct 2017 00:13:34 -0300
MIME-Version: 1.0
In-Reply-To: <1508468326-18354-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] net: add print link status of nics in
 print_net_client function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, jasowang@redhat.com
Cc: qemu-devel@nongnu.org

On 10/19/2017 11:58 PM, ZhiPeng Lu wrote:
> We can directly know the information of vm by executing "info network" command,
>  including the link state of nics, without excuting other commands again.

"executing"

> 
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> Reviewed-by: Jiyun Fan <fan.jiyun@zte.com.cn>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  net/net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index 39ef546..9e349cb 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1298,10 +1298,14 @@ void print_net_client(Monitor *mon, NetClientState *nc)
>  {
>      NetFilterState *nf;
>  
> -    monitor_printf(mon, "%s: index=%d,type=%s,%s\n", nc->name,
> +    monitor_printf(mon, "%s: index=%d,type=%s,%s", nc->name,
>                     nc->queue_index,
>                     NetClientDriver_str(nc->info->type),
>                     nc->info_str);
> +    if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
> +        monitor_printf(mon, ",link status:%s", nc->link_down ? "down" : "up");
> +    }
> +    monitor_printf(mon, "\n");
>      if (!QTAILQ_EMPTY(&nc->filters)) {
>          monitor_printf(mon, "filters:\n");
>      }
> 
