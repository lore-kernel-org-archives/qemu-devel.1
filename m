Received: from eggs.gnu.org ([2001:4830:134:3::10]:41850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZlFa-0007hi-N5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dZlFZ-0008Lf-S2
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:50:50 -0400
References: <20170721093416.17816-1-stefanha@redhat.com>
	<fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
	<20170721155146.GN18014@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <7be2a582-c926-7c89-412b-f74285564a1a@redhat.com>
Date: Mon, 24 Jul 2017 17:50:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170721155146.GN18014@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 07/21/2017 11:51 AM, Stefan Hajnoczi wrote:
> On Fri, Jul 21, 2017 at 07:16:34AM -0500, Eric Blake wrote:
>> On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
>>> There is not much getting started documentation for qemu-iotests.  This
>>> patch explains how to create a new test and covers the overall testing
>>> approach.
>>>
>>> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>
>>> +3. Assign groups to the test
>>> +
>>> +Add your test to the ./group file.  This file is the index of tests and assigns
>>> +them to functional groups like "rw" for read-write tests.  Most tests belong to
>>> +the "rw" and "auto" groups.  "auto" means the test runs when ./check is invoked
>>> +without a -g argument.
>>> +
>>> +Consider adding your test to the "quick" group if it executes quickly (<1s).
>>
>> We have several tests going up to 5s (and I have a patch pending to
>> remove two tests that took longer) - I think 1s is a bit on the short
>> end for still classifying a test as quick.
> 
> I'm happy to accept any number blessed by Kevin.  I do think that 1
> second is a safe maximum and no one should get in trouble for adding a
> test that takes 1 second to the "quick" group.
> 
>>> +This group is run by "make check-block" and is often included as part of build
>>> +tests in continuous integration systems.
>>
>> It would still be nice to have 'make check' run 'make check-block'...
>> but that's independent of this patch.
> 
> Yes, there is a separate discussion about that on the list right now.
> Hopefully it will be added back.
> 

If we do, it'd be nice to have a `make check-block-alt` or something 
else that checks the exact set of tests not covered by `make check-block`.
