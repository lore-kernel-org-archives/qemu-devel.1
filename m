Received: from eggs.gnu.org ([2001:4830:134:3::10]:48595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq89e-0004i2-Lj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 21:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq89Z-0003xK-Kq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 21:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq89Z-0003vP-FY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 21:32:17 -0400
References: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <99e96941-cd9f-3c6c-e4dc-b64762cd329a@redhat.com>
Date: Fri, 8 Sep 2017 09:32:01 +0800
MIME-Version: 1.0
In-Reply-To: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv5 00/03] Replace the COLO comparing thread
 with IOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>, pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com
Cc: wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org



On 2017=E5=B9=B408=E6=9C=8829=E6=97=A5 15:22, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> It's a good idea to use IOThread instead of COLO comparing thread.
> comparing thread can be completely replaced by IOThread, so this idea c=
ame.
>
> This series of updates mainly include IOThread supports the GMainContex=
t
> event loop, then the old packet regularly check and primary/secondary n=
etwork
> packets compare all into the IOThread processing.
>
> Please review,thanks.
>
> wangyong(3):
> qemu-iothread: IOThread supports the GMainContext event loop
> colo-compare: Use IOThread to Check old packet regularly and
>   Process pactkets of the primary
> colo-compare: Update the COLO document to add the IOThread
>   configuration
>
>   include/sysemu/iothread.h | 10 +++++++++
>   iothread.c                | 54 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>   net/colo-compare.c | 75 ++++++++++++++++++++++++++++-----------------=
---------
>   docs/colo-proxy.txt | 3 ++-
>   4 file changed, 97 insertions(+), 39 deletions(-)
>
> --
> 1.8.3.1
>

Applied.

Thanks
