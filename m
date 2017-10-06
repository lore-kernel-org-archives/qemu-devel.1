Received: from eggs.gnu.org ([2001:4830:134:3::10]:44094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0RZu-0005ET-0D
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0RZs-0005Kv-UH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:18:05 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:51931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0RZs-0005Jj-Mh
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:18:04 -0400
Received: by mail-wm0-x235.google.com with SMTP id f4so7589327wme.0
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 05:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005203638.19255-1-ehabkost@redhat.com>
References: <20171005203638.19255-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 13:17:42 +0100
Message-ID: <CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
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

On 5 October 2017 at 21:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit d8f932cc696250cb740240d668b39df5fbb2d5a0:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-10-05 16:54:29 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to 7d7e9c4fd6873d9624956cbe0a5cbfae59b7f8af:
>
>   x86: Correct translation of some rdgsbase and wrgsbase encodings (2017-10-05 17:30:06 -0300)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2017-10-05
>
> Includes x86, NUMA, ACPI, QOM, CPU, and option/config parsing
> patches.
>
> Highlights:
> * Deprecation of -nodefconfig option;
> * MachineClass::valid_cpu_types field.
>
> ----------------------------------------------------------------

This fails tests, I'm afraid:

TEST: tests/bios-tables-test... (pid=5565)
  /i386/acpi/piix4:
Looking for expected file 'tests/acpi-test-data/pc/DSDT'

Using expected file 'tests/acpi-test-data/pc/DSDT'

Looking for expected file 'tests/acpi-test-data/pc/APIC'

Using expected file 'tests/acpi-test-data/pc/APIC'

Looking for expected file 'tests/acpi-test-data/pc/HPET'

Using expected file 'tests/acpi-test-data/pc/HPET'
OK
  /i386/acpi/q35:
[snip]
  /i386/acpi/piix4/memhp:
Looking for expected file 'tests/acpi-test-data/pc/DSDT.memhp'

Using expected file 'tests/acpi-test-data/pc/DSDT.memhp'

Looking for expected file 'tests/acpi-test-data/pc/APIC.memhp'

Looking for expected file 'tests/acpi-test-data/pc/APIC'

Using expected file 'tests/acpi-test-data/pc/APIC'

Looking for expected file 'tests/acpi-test-data/pc/HPET.memhp'

Looking for expected file 'tests/acpi-test-data/pc/HPET'

Using expected file 'tests/acpi-test-data/pc/HPET'

Looking for expected file 'tests/acpi-test-data/pc/SRAT.memhp'

Using expected file 'tests/acpi-test-data/pc/SRAT.memhp'

Looking for expected file 'tests/acpi-test-data/pc/SLIT.memhp'

Using expected file 'tests/acpi-test-data/pc/SLIT.memhp'
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-6QYK7Y.dsl,
aml:/tmp/aml-E8YK7Y], Expected [asl:/tmp/asl-1H1I7Y.dsl,
aml:tests/acpi-test-data/pc/DSDT.memhp].
acpi-test: Warning. not showing difference since no diff utility is
specified. Set 'DIFF' environment variable to a preferred diff utility
and run 'make V=1 check' again to see ASL difference.OK

and same for /i386/acpi/piix4/numamem and for the
equivalent q35 tests.

Fails on s390, netbsd, freebsd, aarch32, x86-64.

As an aside, these acpi tests are a bit noisy with
V=1, especially the extra blank lines.

thanks
-- PMM
