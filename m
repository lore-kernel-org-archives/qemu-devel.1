Received: from eggs.gnu.org ([2001:4830:134:3::10]:49078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceeFZ-0006wG-8N
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceeFV-0007Ss-Cr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:50:45 -0500
Received: from [59.151.112.132] (port=38709 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceeFV-0007R2-0L
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:50:41 -0500
References: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487299994-98348-2-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <a1b61a11-ce57-a785-4f37-960d0edb94b1@cn.fujitsu.com>
Date: Fri, 17 Feb 2017 16:50:46 +0800
MIME-Version: 1.0
In-Reply-To: <1487299994-98348-2-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] colo-compare: use
 g_timeout_source_new() to process the stale packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 02/17/2017 10:53 AM, zhanghailiang wrote:
> Instead of using qemu timer to process the stale packets,
> We re-use the colo compare thread to process these packets
> by creating a new timeout coroutine.
>
> Besides, since we process all the same vNIC's net connection/packets
> in one thread, it is safe to remove the timer_check_lock.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

> ---
>   net/colo-compare.c | 62 +++++++++++++++++++-----------------------------------
>   1 file changed, 22 insertions(+), 40 deletions(-)
>
>
-- 
Thanks
Zhang Chen
