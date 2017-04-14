Received: from eggs.gnu.org ([2001:4830:134:3::10]:34449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyudn-0000vN-Ik
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyudk-0004eb-Ef
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:23:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3038
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyudj-0004dh-PX
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:23:28 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
	<d33b0150-5ed2-56cc-9261-da7deb1d0bfb@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58F06AA1.2010301@huawei.com>
Date: Fri, 14 Apr 2017 14:22:25 +0800
MIME-Version: 1.0
In-Reply-To: <d33b0150-5ed2-56cc-9261-da7deb1d0bfb@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, dgilbert@redhat.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com

Hi Jason,

On 2017/4/14 13:57, Jason Wang wrote:
>
> On 2017年02月22日 17:31, Zhang Chen wrote:
>>
>> On 02/22/2017 11:42 AM, zhanghailiang wrote:
>>> While do checkpoint, we need to flush all the unhandled packets,
>>> By using the filter notifier mechanism, we can easily to notify
>>> every compare object to do this process, which runs inside
>>> of compare threads as a coroutine.
>> Hi~ Jason and Hailiang.
>>
>> I will send a patch set later about colo-compare notify mechanism for
>> Xen like this patch.
>> I want to add a new chardev socket way in colo-comapre connect to Xen
>> colo, for notify
>> checkpoint or failover, Because We have no choice to use this way
>> communicate with Xen codes.
>> That's means we will have two notify mechanism.
>> What do you think about this?
>>
>>
>> Thanks
>> Zhang Chen
> I was thinking the possibility of using similar way to for colo compare.
> E.g can we use socket? This can saves duplicated codes more or less.

Since there are too many sockets used by filter and COLO, (Two unix sockets and two
  tcp sockets for each vNIC), I don't want to introduce more ;) , but i'm not sure if it is
possible to make it more flexible and optional, abstract these duplicated codes,
pass the opened fd (No matter eventfd or socket fd ) as parameter, for example.
Is this way acceptable ?

Thanks,
Hailiang

> Thanks
>
>
> .
>
