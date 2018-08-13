Received: from eggs.gnu.org ([2001:4830:134:3::10]:37163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fpBLY-0002eg-Mi
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fpBLX-0004eh-R1
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:49:16 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-6-lbloch@janustech.com>
	<w51sh3m70ca.fsf@maestria.local.igalia.com>
	<1475efc2-86af-48d1-5887-bb8a1a3997a7@janustech.com>
	<20180813113331.GE4323@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <fe213e7a-48a9-2d70-758c-9ed352294d97@janustech.com>
Date: Mon, 13 Aug 2018 14:48:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180813113331.GE4323@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 5/9] qcow2: Assign the L2 cache
 relatively to the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 8/13/18 2:33 PM, Kevin Wolf wrote:
> Am 11.08.2018 um 21:19 hat Leonid Bloch geschrieben:
>>>>    @item refcount-cache-size
>>>>    The maximum size of the refcount block cache in bytes
>>>> diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
>>>> index 87965625d8..e3fb078588 100755
>>>> --- a/tests/qemu-iotests/137
>>>> +++ b/tests/qemu-iotests/137
>>>> @@ -109,7 +109,6 @@ $QEMU_IO \
>>>>        -c "reopen -o cache-size=1M,l2-cache-size=64k,refcount-cache-size=64k" \
>>>>        -c "reopen -o cache-size=1M,l2-cache-size=2M" \
>>>>        -c "reopen -o cache-size=1M,refcount-cache-size=2M" \
>>>> -    -c "reopen -o l2-cache-size=256T" \
>>>
>>> The "L2 cache size too big" error can still be tested, but you will need
>>> to create an image large enough to allow such a big cache.
>>>
>>> $ qemu-img create -f qcow2 -o cluster_size=256k hd.qcow2 32P
>>> $ $QEMU -drive file=hd.qcow2,l2-cache-entry-size=512,l2-cache-size=1T
>>
>> * 32P qcow2 will take 33M - is it OK to create it just for a test?
>> * Is it worth to create a special test scenario, with a separate image
>> creation, just for that case?
> 
> We're creating larger images than that during tests, so I think this is
> fine. You don't have to create a new separate test file or anything,
> just increase the size of the used test image from 64M to 32P or
> whatever is necessary.

OK, sure, will do in v9.

Leonid.

> 
> Kevin
> 
