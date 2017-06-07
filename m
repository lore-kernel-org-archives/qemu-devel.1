Received: from eggs.gnu.org ([2001:4830:134:3::10]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWM5-0000VY-G8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWM4-0007Sp-EN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIWM4-0007Sb-9N
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:30:16 -0400
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
	<1496659493-1105-2-git-send-email-wang.yong155@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cb49290e-9dcf-6ee0-2824-f283659f87e2@redhat.com>
Date: Wed, 7 Jun 2017 16:30:07 +0800
MIME-Version: 1.0
In-Reply-To: <1496659493-1105-2-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2 01/04] colo-compare: Use IOThread context
 timer to Check old packet regularly
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
> From: Wang Yong<wang.yong155@zte.com.cn>
>
> Remove the task which check old packet in the comparing thread,
> then use IOthread context timer to handle it.
>
> Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
> ---
>   net/colo-compare.c | 62 +++++++++++++++++++++++++++++++++++++++++++--=
---------
>   1 file changed, 50 insertions(+), 12 deletions(-)

I suggest to squash this into patch 2, since we will have 2 threads now.

Thanks
