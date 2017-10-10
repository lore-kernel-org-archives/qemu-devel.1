Received: from eggs.gnu.org ([2001:4830:134:3::10]:41941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1pB6-0004aB-Rt
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1pB3-0007OR-MN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:42:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28489
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1pB3-0007Mn-Ae
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:42:09 -0400
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
	<CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <4479e30f-801d-0d8e-712d-06f2dd987528@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 15:41:56 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Eduardo,

I couldn't reproduce the failure too. But, I have some concern below.

At 10/06/2017 11:37 PM, Peter Maydell wrote:
> On 6 October 2017 at 16:27, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> On Fri, Oct 06, 2017 at 01:17:42PM +0100, Peter Maydell wrote:
>>> This fails tests, I'm afraid:
>> [...]
>>> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-6QYK7Y.dsl,
>>> aml:/tmp/aml-E8YK7Y], Expected [asl:/tmp/asl-1H1I7Y.dsl,
>>> aml:tests/acpi-test-data/pc/DSDT.memhp].

This warning is about memory hot-plug tests. DSDT mismatch is too
strange, I hope to see their difference.

>>> acpi-test: Warning. not showing difference since no diff utility is
>>> specified. Set 'DIFF' environment variable to a preferred diff utility
>>> and run 'make V=1 check' again to see ASL difference.OK
>>>
>>> and same for /i386/acpi/piix4/numamem and for the
>>> equivalent q35 tests.
>>>
>>> Fails on s390, netbsd, freebsd, aarch32, x86-64.
>>>
>>
>> Oops, sorry!
>>
>> I need to find out why it didn't fail on travis-ci:
>> https://travis-ci.org/ehabkost/qemu/builds/283884670
>
> My guess is that one of {iasl installed, iasl not installed}
> is broken, but the travis environments don't test both.
>
If we want do the "bios-tables-test", we need iasl support.

otherwise, when I run "make V=1 check" without iasl, the test
will report error:

...
TEST: tests/bios-tables-test... (pid=1006)
   /i386/acpi/piix4:
Looking for expected file 'tests/acpi-test-data/pc/DSDT'

Using expected file 'tests/acpi-test-data/pc/DSDT'

Looking for expected file 'tests/acpi-test-data/pc/APIC'

Using expected file 'tests/acpi-test-data/pc/APIC'

Looking for expected file 'tests/acpi-test-data/pc/HPET'

Using expected file 'tests/acpi-test-data/pc/HPET'
**
ERROR:tests/bios-tables-test.c:328:load_asl: assertion failed (error == 
NULL): Failed to execute child process "iasl" (No such file or 
directory) (g-exec-error-quark, 8)
FAIL
...

Thanks,
	dou.
> thanks
> -- PMM
>
>
>
>
