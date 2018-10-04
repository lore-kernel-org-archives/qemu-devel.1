Received: from eggs.gnu.org ([2001:4830:134:3::10]:60177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84d1-0006SR-Mc
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84cz-0004Ui-7p
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:29:23 -0400
References: <20181003144738.70670-1-vsementsov@virtuozzo.com>
	<121a81ed-7932-b96c-cc84-60b82725d8e1@redhat.com>
	<eb157eaa-b55d-3044-3c25-46a7d8e998f9@virtuozzo.com>
	<20181004130225.GE6009@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bbf2ffe2-048a-ab0b-9a7d-eff754b783dc@redhat.com>
Date: Thu, 4 Oct 2018 09:29:09 -0500
MIME-Version: 1.0
In-Reply-To: <20181004130225.GE6009@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd/server: fix NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>, qemu-stable <qemu-stable@nongnu.org>

On 10/4/18 8:02 AM, Kevin Wolf wrote:
> Am 03.10.2018 um 17:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 03.10.2018 17:57, Eric Blake wrote:
>>> On 10/3/18 9:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> We should not go to structured-read branch on CACHE command, fix that.
>>>>
>>>> Bug intoroduced in bc37b06a5cde24 "nbd/server: introduce NBD_CMD_CACHE"
>>>
>>> s/intoroduced/introduced/
>>>
>>>> with the whole feature and affects 3.0.0 release.
>>>
>>> Ouch. It's because I don't have an NBD client that can issue the
>>> command, so the server side got released without sufficient testing.
>>> Is there some way we could enhance qemu-io as NBD client to issue such
>>> a command?
>>
>> may be, just add qemu-io command, like x-debug-nbd-cmd, which will just
>> send any nbd command? and prints all server replies? Then we'll be able
>> to write any unit tests on nbd-server. It's not the first time the
>> problem arise..
> 
> Shouldn't it be easy to write a simple NBD client in Python and then use
> that for test cases? I don't see why this needs to be in qemu-io, and
> testing illegal requests is certainly easier with a custom client.

Indeed, and we already have tests/qemu-iotests/nbd-fault-injector.py 
which implements a custom server (unfortunately, it has not been updated 
to use newstyle yet!), as a reference for implementing a similar custom 
client.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
