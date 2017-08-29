Received: from eggs.gnu.org ([2001:4830:134:3::10]:56153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dmZ8F-0003dQ-4x
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 01:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dmZ8B-0007nY-6r
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 01:32:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6255
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dmZ8A-0007n6-RU
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 01:32:07 -0400
References: <1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <41fd3a0c-8c7c-2e7d-75df-0f509c031f5a@cn.fujitsu.com>
Date: Tue, 29 Aug 2017 13:34:06 +0800
MIME-Version: 1.0
In-Reply-To: <1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V4 0/3] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

Hi~ Jason.

Have any comments for this series?

Thanks

Zhang Chen


On 08/21/2017 04:55 PM, Zhang Chen wrote:
> In this serise, we do a lot of job to optimize COLO net performance.
> Mainly focus on TCP protocol.
>
> V4:
>   - Remove the old patch1.
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
> Zhang Chen (3):
>    net/colo-compare.c: Optimize unpredictable tcp options comparison
>    net/colo-compare.c: Adjust net queue pop order for performance
>    net/colo-compare.c: Fix comments and scheme
>
>   net/colo-compare.c | 62 +++++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 22 deletions(-)
>

-- 
Thanks
Zhang Chen
