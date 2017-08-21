Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djhIy-0007hD-7T
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djhIu-0002Ug-5T
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:39:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64665
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djhIt-0002UH-P8
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:39:20 -0400
References: <1502967483-4090-1-git-send-email-wang.yong155@zte.com.cn>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <2474c9bc-641a-ba44-fd4b-2649cf65fcfe@cn.fujitsu.com>
Date: Mon, 21 Aug 2017 15:41:05 +0800
MIME-Version: 1.0
In-Reply-To: <1502967483-4090-1-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCHv3 00/03] Replace the COLO comparing thread
 with IOThread
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

Hi~ Wang Yong.

I have rebased this series to colo-for-qemu-2.10-2017-4-22 
<https://github.com/coloft/qemu/tree/colo-for-qemu-2.10-2017-4-22>,

But with this patch set COLO can't start normally, something I missed?

Can you give me a github branch based on colo-for-qemu-2.10-2017-4-22 
<https://github.com/coloft/qemu/tree/colo-for-qemu-2.10-2017-4-22>that 
we can test?


Thanks

Zhang Chen


On 08/17/2017 06:58 PM, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> It's a good idea to use IOThread instead of COLO comparing thread.
> comparing thread can be completely replaced by IOThread, so this idea came.
>
> This series of updates mainly include IOThread supports the GMainContext
> event loop, then the old packet regularly check and primary/secondary network
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
>   iothread.c                | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>   net/colo-compare.c | 75 ++++++++++++++++++++++++++++--------------------------
>   docs/colo-proxy.txt | 3 ++-
>   4 file changed, 86 insertions(+), 37 deletions(-)
>
> --
> 1.8.3.1
>
>
>
> .
>

-- 
Thanks
Zhang Chen
