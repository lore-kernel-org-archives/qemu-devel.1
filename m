Received: from eggs.gnu.org ([2001:4830:134:3::10]:35236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1diADb-0003FB-La
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1diADW-0007aP-Rc
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:07:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54186
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1diADW-0007Ye-G8
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 22:07:26 -0400
References: <1502874842-4191-1-git-send-email-wang.yong155@zte.com.cn>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <4011db1b-0ceb-e025-e8df-cdd4059a8640@cn.fujitsu.com>
Date: Thu, 17 Aug 2017 10:09:04 +0800
MIME-Version: 1.0
In-Reply-To: <1502874842-4191-1-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCHv3 00/02] Replace the COLO comparing thread
 with IOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>, zhang.zhanghailiang@huawei.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org



On 08/16/2017 05:14 PM, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> Note: This series is based on the patch of "qemu-iothread:
> IOThread supports theGMainContext event loop".

You'd better put the patch on this patch set, make it easy to review.

Thanks
Zhang Chen

>
> It's a good idea to use IOThread instead of COLO comparing thread.
> comparing thread can be completely replaced by IOThread, so this idea came.
>
> This series of updates mainly include the old packet regularly check and
> primary/secondary network packets compare all into the IOThread processing.
>
> Please review,thanks.
>
> wangyong(2):
> colo-compare: Use IOThread to Check old packet regularly and
>   Process pactkets of the primary
> colo-compare: Update the COLO document to add the IOThread
>   configuration
>
>   docs/colo-proxy.txt |   5 +-
>   net/colo-compare.c | 75 ++++++++++++++++++++++++++++--------------------------
>   2 file changed, 39 insertions(+), 36 deletions(-)
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
