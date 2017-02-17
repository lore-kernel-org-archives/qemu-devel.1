Received: from eggs.gnu.org ([2001:4830:134:3::10]:39097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceZYo-00011l-Cw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceZYl-0007Td-CH
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:50:18 -0500
Received: from [59.151.112.132] (port=13423 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceZYl-0007Cr-0b
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:50:15 -0500
References: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487299994-98348-3-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <4fc4488e-eecc-a15e-aa91-031388b8fc95@cn.fujitsu.com>
Date: Fri, 17 Feb 2017 11:50:15 +0800
MIME-Version: 1.0
In-Reply-To: <1487299994-98348-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] colo-compare: kick compare thread
 to exit after some cleanup in finalization
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
> We should call g_main_loop_quit() to notify colo compare thread to
> exit, Or it will run in g_main_loop_run() forever.
>
> Besides, the finalizing process can't happen in context of colo thread,
> it is reasonable to remove the 'if (qemu_thread_is_self(&s->thread))'
> branch.
>
> Before compare thead exits, some cleanup works need to be
> done,  All unhandled packets need to be released and connection_track_table
> needs to be freed, or there will be memory leak.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

> ---
>   net/colo-compare.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)

-- 
Thanks
Zhang Chen
