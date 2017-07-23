Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHim-0003lP-FA
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZHil-0006YF-CI
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:19:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
	<20170721155146.GN18014@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0fd1f1b7-12e8-fc0b-96ce-4b3eee5b08af@amsat.org>
Date: Sun, 23 Jul 2017 11:18:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170721155146.GN18014@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
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

On 07/21/2017 12:51 PM, Stefan Hajnoczi wrote:
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
>>> +Once you are happy with the test output it can be used as the golden master
>>> +with "mv <test-number>.out.bad <test-number>.out".  Rerun the test to verify
>>> +that it passes.
>>> +
>>> +Congratulations, you've created a new test!
>>
>> Maybe a reminder to 'git add' the new files, then submit the patch?
> 
> I thought about this too but decided not to get into the git and patch
> submission business.  I carefully worded it to be about "creating" tests
> rather than "adding" them to qemu.git because I wanted to limit the
> scope of this README :).

Maybe something tiny like:

   Congratulations, you've created a new test!

   To share your test to upstream QEMU (highly recommended!) just follow
   these recommendations: http://wiki.qemu.org/Contribute/SubmitAPatch

> 
> Stefan
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
