Received: from eggs.gnu.org ([2001:4830:134:3::10]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSNlP-00042R-FC
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSNlO-0000C7-Ey
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:53:27 -0500
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
	<20171212160450.17510-4-vsementsov@virtuozzo.com>
	<20171222134344.GH3763@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <488b8547-9042-81e4-8e85-9867385c9c79@virtuozzo.com>
Date: Fri, 22 Dec 2017 16:53:14 +0300
MIME-Version: 1.0
In-Reply-To: <20171222134344.GH3763@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/3] iotests: add dirty bitmap migration
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, den@openvz.org, jsnow@redhat.com

22.12.2017 16:43, Kevin Wolf wrote:
> Am 12.12.2017 um 17:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> The test creates two vms (vm_a, vm_b), create dirty bitmap in
>> the first one, do several writes to corresponding device and
>> then migrate vm_a to vm_b with dirty bitmaps.
>>
>> For now, only migration through shared storage for persistent
>> bitmaps is available, so it is tested here. Only offline variant
>> is tested for now (a kind of suspend-resume), as it is needed
>> to test that this case is successfully fixed by recent patch.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> [...]
>> +        self.vm_b.launch()
>> +        self.vm_b.event_wait("RESUME", timeout=10.0)
> Wasn't this racy because the RESUME event may be sent before we connect
> to the socket?

Didn't know (and didn't faced) it. If it is so, it should be changed 
like you've changed similar place in my previous iotest.

>
> Kevin


-- 
Best regards,
Vladimir
