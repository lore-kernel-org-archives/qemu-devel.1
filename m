Received: from eggs.gnu.org ([2001:4830:134:3::10]:55298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1caeQy-0001wi-CJ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 03:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1caeQv-0003V7-6O
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 03:14:00 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:20395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1caeQu-0003TI-K5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 03:13:57 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58983015.40300@huawei.com>
Date: Mon, 6 Feb 2017 16:13:09 +0800
MIME-Version: 1.0
In-Reply-To: <4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: reconstruct the mutex
 lock usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, lizhijian@cn.fujitsu.com

On 2017/2/3 11:47, Jason Wang wrote:
>
>
> On 2017年01月24日 22:05, zhanghailiang wrote:
>> The original 'timer_check_lock' mutex lock of struct CompareState
>> is used to protect the 'conn_list' queue and its child queues which
>> are 'primary_list' and 'secondary_list', which is a little abused
>> and confusing
>>
>> To make it clearer, we rename 'timer_check_lock' to 'conn_list_lock'
>> which is used to protect 'conn_list' queue, use another 'conn_lock'
>> to protect 'primary_list' and 'secondary_list'.
>>
>> Besides, fix some missing places which need these mutex lock.
>>
>> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
>
> Instead of sticking to such kind of mutex, I think it's time to make
> colo timer run in colo thread (there's a TODO in the code).
>

Er, it seems that, we still need these mutex locks even we make colo
timer and colo thread run in the same thread, because we may access
the connect/primary/secondary list from colo (migratioin) thread
concurrently.

Besides, it seems to be a little complex to make colo timer run in colo
compare thread, and it is not this series' goal. This series is preparing
work for integrating COLO compare with COLO frame and it is prerequisite.

So, we may consider implementing it later in another series.
Zhang Chen, what's your opinion ?


Thanks,
Hailiang

> Thought?
>
> Thanks
>
> .
>
