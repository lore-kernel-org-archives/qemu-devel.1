Received: from eggs.gnu.org ([2001:4830:134:3::10]:44376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fNg6C-00080b-5E
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fNg67-0002Ul-7A
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:59:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fNg67-0002UE-2m
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:59:39 -0400
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525005839.11556-4-crosa@redhat.com>
	<20180525053718.GB28589@lemon.usersys.redhat.com>
	<65f0262a-20ff-f243-7434-a48daf7e5225@redhat.com>
	<20180529143257.GA8988@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <1c9b3429-3e19-63f5-cbab-4d777c03cd8c@redhat.com>
Date: Tue, 29 May 2018 10:59:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180529143257.GA8988@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] Acceptance tests: add quick VNC tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 05/29/2018 10:32 AM, Eduardo Habkost wrote:
> On Fri, May 25, 2018 at 12:27:46PM -0400, Cleber Rosa wrote:
>>
>>
>> On 05/25/2018 01:37 AM, Fam Zheng wrote:
>>> On Thu, 05/24 20:58, Cleber Rosa wrote:
>>>> This patch adds a few simple behavior tests for VNC.  These tests
>>>> introduce manipulation of the QEMUMachine arguments, by setting
>>>> the arguments, instead of adding to the existing ones.
>>>
>>> I'm confused by this. The code uses 'add_args', so it does add to the arguments,
>>> no?
>>>
>>
>> And you should be.  I changed the code to just add args, and forgot to
>> update the commit message.  If a better example comes up that requires
>> setting arguments, I'll get back to this.
>>
>>>>
>>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>>  tests/acceptance/test_vnc.py | 50 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 50 insertions(+)
>>>>  create mode 100644 tests/acceptance/test_vnc.py
>>>>
>>>> diff --git a/tests/acceptance/test_vnc.py b/tests/acceptance/test_vnc.py
>>>> new file mode 100644
>>>> index 0000000000..9d9a35cf55
>>>> --- /dev/null
>>>> +++ b/tests/acceptance/test_vnc.py
>>>> @@ -0,0 +1,50 @@
>>>
>>> Copyright header is missing here too.
>>>
>>
>> Indeed.
>>
>>> Fam
>>>
>>>> +from avocado_qemu import Test
>>>> +
>>>> +
>>>> +class Vnc(Test):
>>>
>>> Should VncTest be a better class name?
>>>
>>
>> I'm favoring simpler names.  If you think about the complete test names,
>> it's already too verbose IMO: "test_vnc.Vnc.test_no_vnc".
>>
>> That's actually an interesting point: how would you feel about dropping
>> the "test_" prefix from the file names?
> 
> I would like this.  The file is already inside a tests/acceptance
> directory.
> 
> About the class name, I would be less surprised when reading the
> code if it was called "VncTest", but I won't object to "Vnc" if
> you prefer it.
> 

We already gained one simplification by dropping the "test_" file
prefix, so I wouldn't mind adding the "Test" suffix to the test classes.

Now, before I do, consider that when reading the code you'll find:

   class Vnc(Test):
      ...

Which IMO makes it pretty clear that this is a test class.  And as you
said it yourself, those files are already in a tests/acceptance directory.

So back to you (for the last time, I promise): would you like me to add
the Test suffix to all test classes?

- Cleber.
