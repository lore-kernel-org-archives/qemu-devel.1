Received: from eggs.gnu.org ([2001:4830:134:3::10]:41558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCubg-0003El-7E
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCubb-0003ut-H4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCuba-0003ti-Az
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:47:55 -0400
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<20181017190951.GG31060@habkost.net>
	<20181017204618.GB18379@kermit-br-ibm-com>
	<46beb9dd-d3b7-de7a-313c-523ce036949e@redhat.com>
	<20181017221546.GR31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <ce3f2032-5c23-b48e-c5f2-16318070d55d@redhat.com>
Date: Wed, 17 Oct 2018 18:47:41 -0400
MIME-Version: 1.0
In-Reply-To: <20181017221546.GR31060@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>



On 10/17/18 6:15 PM, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 04:59:25PM -0400, Cleber Rosa wrote:
>> On 10/17/18 4:46 PM, Murilo Opsfelder Araujo wrote:
> [...]
>>> Then avocado could multiplex these variants file and call ./tests/acceptance/run
>>> for each value of qemu_bin.  `run` script could skip and return if $qemu_bin
>>> doesn't exist.  This approach also allows user forcing a value of qemu_bin when
>>> calling `run` manually, for example:
>>>
>>>     ./tests/acceptance/run --qemu_bin=/path/to/your/qemu-system-blah ...
>>>
>>> This ./tests/acceptance/run can serve as an entry point to run all the tests.
>>> If more parameters are considered mandatory in the future, the logic can be
>>> placed there.
>>>
>>
>> I'm completely favorable to having extra scripts or make rules that
>> define a standard "job" behavior.  In fact, I think we'll end up having
>> many of those.  "make check-acceptance" is just the first one.
>>
>> But being able to running individual tests should still be possible, and
>> easy IMO.
> 
> Agreed.  But is there anything that requires "running an
> individual test" to be synonymous to "running a test against only
> one QEMU binary"?
> 

I consider, generally speaking:

 * the test: the (parameterizable) code
 * running an individual test: the execution of that code, once, with
one parameter

There may be tests in which the logic of *one test* may require
executing different QEMU binaries, but that is the exception, not the
rule IMO.

Given that the acceptance tests are Avocado tests, I think it'd be a
mistake (or very hard) to try to make "an individual (Avocado) test" use
all the built QEMU binaries.  Variants (one for each unique set of
parameters) is the natural thing to use here.

> We seem to have a terminology problem here: "I'm running one
> individual test" may mean something to an user, but mean
> something completely different to somebody thinking about Avocado
> test cases.  Is this the source of our disagreement?
> 

It could be, I'm certainly biased by the Avocado definition of tests and
my limited understanding what others here may mean when they say "a
test".  For instance, it may be that, to some, "make check" is
considered "a test", and consequently, needs to run with all built QEMU
binaries.

Regards,
- Cleber.
