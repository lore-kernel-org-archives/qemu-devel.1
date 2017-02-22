Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgTHU-0002Y0-AZ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgTHQ-0006x9-D8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:32:16 -0500
Received: from [59.151.112.132] (port=39745 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgTHP-0006vj-VO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:32:12 -0500
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
Date: Wed, 22 Feb 2017 17:31:24 +0800
MIME-Version: 1.0
In-Reply-To: <1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/15] colo-compare: implement the process
 of checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com



On 02/22/2017 11:42 AM, zhanghailiang wrote:
> While do checkpoint, we need to flush all the unhandled packets,
> By using the filter notifier mechanism, we can easily to notify
> every compare object to do this process, which runs inside
> of compare threads as a coroutine.

Hi~ Jason and Hailiang.

I will send a patch set later about colo-compare notify mechanism for 
Xen like this patch.
I want to add a new chardev socket way in colo-comapre connect to Xen 
colo, for notify
checkpoint or failover, Because We have no choice to use this way 
communicate with Xen codes.
That's means we will have two notify mechanism.
What do you think about this?


Thanks
Zhang Chen

>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   net/colo-compare.h | 20 +++++++++++++++
>   2 files changed, 92 insertions(+)
>   create mode 100644 net/colo-compare.h
>

-- 
Thanks
Zhang Chen
