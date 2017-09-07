Received: from eggs.gnu.org ([2001:4830:134:3::10]:53949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dpnOA-0000C2-P8
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dpnO7-00083T-Gw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:21:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47430
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dpnO7-00081a-6X
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:21:55 -0400
References: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
	<1503991359-3353-4-git-send-email-wang.yong155@zte.com.cn>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <bdbcecf3-af7a-3cae-7e8b-ded4eadbc604@cn.fujitsu.com>
Date: Thu, 7 Sep 2017 11:23:26 +0800
MIME-Version: 1.0
In-Reply-To: <1503991359-3353-4-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCHv5 03/03] colo-compare: Update the COLO
 document to add the IOThread configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>, pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org



On 08/29/2017 03:22 PM, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> Update colo-proxy.txt,add IOThread configuration.
> Later we have to configure IOThread,if not COLO can not work.
>
> Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

> ---
>   docs/colo-proxy.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
> index c4941de..ce3f783 100644
> --- a/docs/colo-proxy.txt
> +++ b/docs/colo-proxy.txt
> @@ -170,10 +170,11 @@ Primary(ip:3.3.3.3):
>   -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
>   -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
>   -chardev socket,id=compare_out0,host=3.3.3.3,port=9005
> +-object iothread,id=iothread1
>   -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
>   -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
>   -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
> --object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0
> +-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1
>   
>   Secondary(ip:3.3.3.8):
>   -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown

-- 
Thanks
Zhang Chen
