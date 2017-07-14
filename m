Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dW2W4-0006nT-VD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dW2W1-00016S-Pf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:28:28 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:17922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dW2W1-00015x-Ep
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:28:25 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170714122221.pyx2pwubtaylqdu6@postretch>
	<e059cf44-53df-4d5f-3257-cc9b6be775df@huawei.com>
	<20170714142639.ycu6b7qeeb7akxkb@postretch>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <3f128771-3400-ac00-7556-a99193bf604a@huawei.com>
Date: Fri, 14 Jul 2017 17:27:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170714142639.ycu6b7qeeb7akxkb@postretch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>

On 7/14/2017 4:26 PM, Manos Pitsidianakis wrote:
> On Fri, Jul 14, 2017 at 03:15:06PM +0200, Pradeep Jagadeesh wrote:
>> Hi Manos,
>>
>> Thanks for sharing the link to your code patch.
>>
>> On 7/14/2017 2:22 PM, Manos Pitsidianakis wrote:
>>> Hello Pradeep, you might be interested in my work on refactoring the
>>> block layer's throttling interface in my series:
>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04191.html
>> Sure will have a look.
>>> In this series you copy the existing legacy interface we want to get rid
>>> of. I think it will be easier work for you to use the changes introduced
>>> in my patches when they are merged.
>> So, should I wait till they are in?. Actually my throttle patches for
>> fsdev are already upstream (2.9). Now I am just introducing the
>> qmp/hmp interfaces for the same.
>
> If you plan on using ThrottleGroups, probably yes, I think, because we'd
> have duplicate interfaces afterwards instead of a unified one. You'd
> have to introduce a qmp/hmp command to set fsdev throttle now and after
> you use throttle groups it will become obsolete.
I am not using ThrottleGroups in near future.

-Pradeep

>
>>> Have you thought about using throttle groups? It'd mean many devices
>>> sharing the same limits. This way the interfaces can be unified.  Please
>>> read docs/throttle.txt and see if it would be useful for you.
>>
>> I have read about the throttle group, last year when I was
>> implementing the throttle feature for fsdev.My open source work
>> depends on the projects I/my group work on. So, when I have more
>> bandwidth work on those, I will surely take it up. Throttle group
>> option may be useful feature even in case of fsdev devices.
>>
>> Regards,
>> Pradeep
>>
>>
