Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djbl8-00063C-5Y
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djbl5-0008Ez-1p
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:44:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40415
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1djbl4-0008EY-N3
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 21:44:02 -0400
References: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e41d36bc-ed32-8d0d-7fff-bf68fb78707c@cn.fujitsu.com>
Date: Mon, 21 Aug 2017 09:45:55 +0800
MIME-Version: 1.0
In-Reply-To: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V3 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi~~ All~

No one review this series for a long time.

Ping...


Thanks

Zhang Chen


On 07/19/2017 03:29 PM, Zhang Chen wrote:
> In this serise, we do a lot of job to optimize COLO net performance.
> Mainly focus on TCP protocol.
>
> V3:
>   - Rebase on upstream.
>   - Remove origin p2.
>   - Move the "checkpoint_time_ms" to CompareState,
>     in order to aviod multi colo-compare instance conflict.
>   - Add "TODO comments" for reset s->checkpoint_time_ms.
>   - Add a new patch fix comments and scheme.
>
> V2:
>   - Rename p2's subject.
>
>
> Zhang Chen (4):
>    net/colo-compare.c: Add checkpoint min period to optimize performance
>    net/colo-compare.c: Optimize unpredictable tcp options  comparison
>    net/colo-compare.c: Adjust net queue pop order for performance
>    net/colo-compare.c: Fix comments and scheme
>
>   net/colo-compare.c | 83 +++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 60 insertions(+), 23 deletions(-)
>

-- 
Thanks
Zhang Chen
