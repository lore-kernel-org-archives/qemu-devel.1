Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWT8-00047F-Fj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWT0-0001Gc-Gl
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIWT0-0001GS-9L
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:37:26 -0400
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
	<1496659493-1105-5-git-send-email-wang.yong155@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ba2f1089-add7-63ca-8406-fde640cc02bf@redhat.com>
Date: Wed, 7 Jun 2017 16:37:18 +0800
MIME-Version: 1.0
In-Reply-To: <1496659493-1105-5-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2 04/04] colo-compare: Update the COLO
 document to fix the processing of secondary packets in the main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yong Wang <wang.yong155@zte.com.cn>, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn



On 2017=E5=B9=B406=E6=9C=8805=E6=97=A5 18:44, Yong Wang wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> In my test, secondary does not process the packets comparing in the IOT=
hread
> but in the qemu main thread processing.
> secondary's configuration " -chardev socket,id=3Dcompare1,host=3D3.3.3.=
3,port=3D9004,server,nowait"
> here,we should use 'wait' instead of 'nowait' configuration .
> after use  'wait' configuration ,packets can be process in the IOThread=
 from the secondary,
> not in the qemu main thread.
>
> Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
> ---

This is a hint probably for something wrong in the code. Need to figure=20
out the root cause.

Thanks

>   docs/colo-proxy.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
> index ce3f783..567cc8b 100644
> --- a/docs/colo-proxy.txt
> +++ b/docs/colo-proxy.txt
> @@ -165,7 +165,7 @@ Primary(ip:3.3.3.3):
>   -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D=
/etc/qemu-ifdown
>   -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>   -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,server,nowait
> --chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server,nowait
> +-chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server,wait
>   -chardev socket,id=3Dcompare0,host=3D3.3.3.3,port=3D9001,server,nowai=
t
>   -chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
>   -chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,server,no=
wait
