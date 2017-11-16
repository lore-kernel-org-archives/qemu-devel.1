Received: from eggs.gnu.org ([2001:4830:134:3::10]:47866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFLMD-0007Fx-Lu
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFLMB-0007qO-65
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:41:33 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFLMA-0007nC-Sa
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:41:31 -0500
Received: by mail-wm0-x242.google.com with SMTP id g130so43716wme.0
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 06:41:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2017 14:41:09 +0000
Message-ID: <CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 November 2017 at 18:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 1fa0f627d03cd0d0755924247cafeb42969016bf:
>
>   Update version for v2.11.0-rc1 release (2017-11-14 18:37:49 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 6ed0c1c3ab0925009d15cffb944d9ccb04718846:
>
>   build-sys: restrict vmcoreinfo to fw_cfg+dma capable targets (2017-11-15 20:13:13 +0200)
>
> ----------------------------------------------------------------
> pc, pci, virtio: fixes for rc1
>
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi. This failed tests on a couple of machines:

s390x:

TEST: tests/bios-tables-test... (pid=58925)
  /i386/acpi/piix4:
Looking for expected file 'tests/acpi-test-data/pc/DSDT'

Using expected file 'tests/acpi-test-data/pc/DSDT'

Looking for expected file 'tests/acpi-test-data/pc/APIC'

Using expected file 'tests/acpi-test-data/pc/APIC'

Looking for expected file 'tests/acpi-test-data/pc/HPET'

Using expected file 'tests/acpi-test-data/pc/HPET'
'iasl -p /tmp/asl-CHIM9Y.dsl -d tests/acpi-test-data/pc/DSDT' exited
with status 65280
Intel ACPI Component Architecture
ASL+ Optimizing Compiler version 20160108-64
Copyright (c) 2000 - 2016 Intel Corporation

Could not get ACPI tables from tests/acpi-test-data/pc/DSDT, AE_BAD_HEADER
Input file tests/acpi-test-data/pc/DSDT, Length 0x1418 (5144) bytes
Table [DSDT] is too long for file - needs: 0x18140000, remaining in file: 0x1418
**
ERROR:/home/linux1/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
assertion failed: (!err && !exp_err)
FAIL
GTester: last random seed: R02S7430f83941b25a926c586492b2745d2c
(pid=58933)
  /i386/acpi/q35:
Looking for expected file 'tests/acpi-test-data/q35/DSDT'

Using expected file 'tests/acpi-test-data/q35/DSDT'

Looking for expected file 'tests/acpi-test-data/q35/APIC'

Using expected file 'tests/acpi-test-data/q35/APIC'

Looking for expected file 'tests/acpi-test-data/q35/HPET'

Using expected file 'tests/acpi-test-data/q35/HPET'

Looking for expected file 'tests/acpi-test-data/q35/MCFG'

Using expected file 'tests/acpi-test-data/q35/MCFG'
'iasl -p /tmp/asl-NRWT9Y.dsl -d tests/acpi-test-data/q35/DSDT' exited
with status 65280
Intel ACPI Component Architecture
ASL+ Optimizing Compiler version 20160108-64
Copyright (c) 2000 - 2016 Intel Corporation

Could not get ACPI tables from tests/acpi-test-data/q35/DSDT, AE_BAD_HEADER
Input file tests/acpi-test-data/q35/DSDT, Length 0x1E94 (7828) bytes
Table [DSDT] is too long for file - needs: 0x941E0000, remaining in file: 0x1E94
**
ERROR:/home/linux1/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
assertion failed: (!err && !exp_err)
FAIL

& similarly for a bunch of other tests. Looks like an
endianness issue.

and on 32-bit arm:

TEST: tests/bios-tables-test... (pid=30809)
  /i386/acpi/piix4:
Looking for expected file 'tests/acpi-test-data/pc/DSDT'

Using expected file 'tests/acpi-test-data/pc/DSDT'

Looking for expected file 'tests/acpi-test-data/pc/APIC'

Using expected file 'tests/acpi-test-data/pc/APIC'

Looking for expected file 'tests/acpi-test-data/pc/HPET'

Using expected file 'tests/acpi-test-data/pc/HPET'
'iasl -p /tmp/asl-6T2N9Y.dsl -e /tmp/aml-TV2N9Y -d /tmp/aml-TV2N9Y'
exited with status 11Input file /tmp/aml-TV2N9Y, Length 0x1418 (5144)
bytes
ACPI: DSDT 0x0000000000000000 001418 (v01 BOCHS  BXPCDSDT 00000001
BXPC 00000001)
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)

Parsing completed
'iasl -p /tmp/asl-PKDO9Y.dsl -e tests/acpi-test-data/pc/DSDT -d
tests/acpi-test-data/pc/DSDT' exited with status 11Input file
tests/acpi-test-data/pc/DSDT, Length 0x1418 (5144) bytes
ACPI: DSDT 0x0000000000000000 001418 (v01 BOCHS  BXPCDSDT 00000001
BXPC 00000001)
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)

Parsing completed
**
ERROR:/home/peter.maydell/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
assertion failed: (!err && !exp_err)
FAIL
GTester: last random seed: R02S5d06952865b5a6ffb8443ae4d324e880
(pid=30816)
  /i386/acpi/q35:
Looking for expected file 'tests/acpi-test-data/q35/DSDT'

Using expected file 'tests/acpi-test-data/q35/DSDT'

Looking for expected file 'tests/acpi-test-data/q35/APIC'

Using expected file 'tests/acpi-test-data/q35/APIC'

Looking for expected file 'tests/acpi-test-data/q35/HPET'

Using expected file 'tests/acpi-test-data/q35/HPET'

Looking for expected file 'tests/acpi-test-data/q35/MCFG'

Using expected file 'tests/acpi-test-data/q35/MCFG'
OK

(and similar fails in other tests)


thanks
-- PMM
