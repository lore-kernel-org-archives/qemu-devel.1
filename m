Received: from eggs.gnu.org ([2001:4830:134:3::10]:39096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceZYo-00011k-Cg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceZYm-0007Ug-5f
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:50:18 -0500
Received: from [59.151.112.132] (port=30529 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceZYl-0007RG-Oh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:50:16 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
References: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487299994-98348-5-git-send-email-zhang.zhanghailiang@huawei.com>
Message-ID: <2e65f456-223d-1923-3493-e469961c37fd@cn.fujitsu.com>
Date: Fri, 17 Feb 2017 11:50:28 +0800
MIME-Version: 1.0
In-Reply-To: <1487299994-98348-5-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] colo-compare: Fix removing fds been
 watched incorrectly in finalization
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
> We will catch the bellow error report while try to delete compare object
> by qmp command:
> chardev/char-io.c:91: io_watch_poll_finalize: Assertion `iwp->src == ((void *)0)' failed.
>
> This is caused by failing to remove the right fd been watched while
> call qemu_chr_fe_set_handlers();
>
> Fix it by pass the worker_context parameter to qemu_chr_fe_set_handlers().
>
> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

> ---
>   net/colo-compare.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)

-- 
Thanks
Zhang Chen
