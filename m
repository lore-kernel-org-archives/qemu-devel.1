Received: from eggs.gnu.org ([2001:4830:134:3::10]:48965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0Uhb-0003uG-UD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UhW-0007ga-8c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:38:15 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:47585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0UhW-0007ft-22
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:38:10 -0400
Received: by mail-wr0-x229.google.com with SMTP id y44so7980419wrd.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 08:38:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171006152751.GR4015@localhost.localdomain>
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 16:37:48 +0100
Message-ID: <CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 October 2017 at 16:27, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Oct 06, 2017 at 01:17:42PM +0100, Peter Maydell wrote:
>> This fails tests, I'm afraid:
> [...]
>> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-6QYK7Y.dsl,
>> aml:/tmp/aml-E8YK7Y], Expected [asl:/tmp/asl-1H1I7Y.dsl,
>> aml:tests/acpi-test-data/pc/DSDT.memhp].
>> acpi-test: Warning. not showing difference since no diff utility is
>> specified. Set 'DIFF' environment variable to a preferred diff utility
>> and run 'make V=1 check' again to see ASL difference.OK
>>
>> and same for /i386/acpi/piix4/numamem and for the
>> equivalent q35 tests.
>>
>> Fails on s390, netbsd, freebsd, aarch32, x86-64.
>>
>
> Oops, sorry!
>
> I need to find out why it didn't fail on travis-ci:
> https://travis-ci.org/ehabkost/qemu/builds/283884670

My guess is that one of {iasl installed, iasl not installed}
is broken, but the travis environments don't test both.

thanks
-- PMM
