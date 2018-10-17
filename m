Received: from eggs.gnu.org ([2001:4830:134:3::10]:40284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCrS5-0001NT-Bj
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCrRw-0001YH-P8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCrRu-0001R9-Nb
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:25:44 -0400
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<20181017190951.GG31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b6cff33b-79af-f7b2-2a08-a098135304e0@redhat.com>
Date: Wed, 17 Oct 2018 15:25:34 -0400
MIME-Version: 1.0
In-Reply-To: <20181017190951.GG31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>



On 10/17/18 3:09 PM, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 07:40:51PM +0100, Peter Maydell wrote:
>> On 17 October 2018 at 18:38, Cleber Rosa <crosa@redhat.com> wrote:
>>>
>>>
>>> On 10/17/18 12:29 PM, Eduardo Habkost wrote:
>>>> On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
>>>>> So, why does the test code need to care? It's not clear
>>>>> from the patch... My expectation would be that you'd
>>>>> just test all the testable target architectures,
>>>>> regardless of what the host architecture is.
>>>>
>>>> I tend to agree.  Maybe the right solution is to get rid of the
>>>> os.uname().  I think the default should be testing all QEMU
>>>> binaries that were built, and the host architecture shouldn't
>>>> matter.
>>
>> Yes, looking at os.uname() also seems like an odd thing
>> for the tests to be doing here. The test framework
>> should be as far as possible host-architecture agnostic.
>> (For some of the KVM cases there probably is a need to
>> care, but those are exceptions, not the rule.)
>>
>>> I'm in favor of exercising all built targets, but that seems to me to be
>>> on another layer, above the test themselves. This change is about the
>>> behavior of a test when not told about the target arch (and thus binary)
>>> it should use.
>>
>> At that level, I think the right answer is "tell the user
>> they need to specify the qemu executable they are trying to test".
>> In particular, there is no guarantee that the user has actually
>> built the executable for the target that corresponds to the
>> host, so it doesn't work to try to default to that anyway.
> 
> Agreed.  However, I don't see when exactly this message would be
> triggered.  Cleber, on which use cases do you expect
> pick_default_qemu_bin() to be called?
> 

When a test is run ad-hoc.  You even suggested that tests could/should
be executable.

> In an ideal world, any testing runner/tool should be able to
> automatically test all binaries by default.  Can Avocado help us
> do that?  (If not, we could just do it inside a
> ./tests/acceptance/run script).
> 

Avocado can do that indeed.  But I'm afraid that's not the main issue.
Think of the qemu-iotests: do we want a "check" command to run  all
tests with all binaries?

- Cleber.
