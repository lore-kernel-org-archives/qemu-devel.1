Received: from eggs.gnu.org ([2001:4830:134:3::10]:40442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2ypq-0000QJ-NH
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2ypm-0000VX-K0
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2ypm-0000Ur-E2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:40:42 -0400
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-2-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5e7f11a4-83d4-e363-6f80-a749c206c190@redhat.com>
Date: Tue, 25 Apr 2017 19:40:34 +0800
MIME-Version: 1.0
In-Reply-To: <1492850128-17472-2-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v2 01/18] net/colo: Add
 notifier/callback related helpers for filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B404=E6=9C=8822=E6=97=A5 16:35, zhanghailiang wrote:
> We will use this notifier to help COLO to notify filter object
> to do something, like do checkpoint, or process failover event.
>
> Cc: Jason Wang<jasowang@redhat.com>
> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian<lizhijian@cn.fujitsu.com>
> ---
>   net/colo.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   net/colo.h |  19 +++++++++++
>   2 files changed, 124 insertions(+)

Went through this series and I feel that the code duplicates (at least=20
part) functionality of IOThread (iothread.c) . So I come to an idea that=20
switch to use IOThread for COLO comparing thread then you can use aio bh=20
to do the inter process communication.

Thoughts?

Thanks
