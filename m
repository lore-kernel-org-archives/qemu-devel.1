Received: from eggs.gnu.org ([2001:4830:134:3::10]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d3I7L-0003JJ-Nd
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d3I7I-0007rI-GV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:16:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3528
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d3I7H-0007mB-TI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:16:04 -0400
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<5e7f11a4-83d4-e363-6f80-a749c206c190@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <590056FC.1020105@huawei.com>
Date: Wed, 26 Apr 2017 16:14:52 +0800
MIME-Version: 1.0
In-Reply-To: <5e7f11a4-83d4-e363-6f80-a749c206c190@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: xuquan8@huawei.com, quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On 2017/4/25 19:40, Jason Wang wrote:
>
> On 2017年04月22日 16:35, zhanghailiang wrote:
>> We will use this notifier to help COLO to notify filter object
>> to do something, like do checkpoint, or process failover event.
>>
>> Cc: Jason Wang<jasowang@redhat.com>
>> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Li Zhijian<lizhijian@cn.fujitsu.com>
>> ---
>>    net/colo.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>    net/colo.h |  19 +++++++++++
>>    2 files changed, 124 insertions(+)
> Went through this series and I feel that the code duplicates (at least
> part) functionality of IOThread (iothread.c) . So I come to an idea that,
> switch to use IOThread for COLO comparing thread then you can use aio bh
> to do the inter process communication.
>
> Thoughts?

Interesting idea, but after investigation, we found it will make things quite complex
if we use iothread for net compare (Actually, i don't think we can use it directly for COLO),
It seems to be special for block, you can see some codes call block helpers.
Besides, we still have to realize a way to communicate with COLO frame for filters  (I mean patch 16/17/18),
even we use it after reconstruct those iothread part. ;)

Thanks,
Hailiang

> Thanks
>
> .
>
