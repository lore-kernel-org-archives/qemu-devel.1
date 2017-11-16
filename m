Received: from eggs.gnu.org ([2001:4830:134:3::10]:33388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFLx4-0004es-Kd
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFLx0-0002eB-FQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:19:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eFLx0-0002cr-9R
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:19:34 -0500
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
	<CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf624dcc-c0f7-1ebe-d706-20a65550e2dd@redhat.com>
Date: Thu, 16 Nov 2017 16:19:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 16.11.2017 15:41, Peter Maydell wrote:
> On 15 November 2017 at 18:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>> The following changes since commit 1fa0f627d03cd0d0755924247cafeb42969016bf:
>>
>>   Update version for v2.11.0-rc1 release (2017-11-14 18:37:49 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>> for you to fetch changes up to 6ed0c1c3ab0925009d15cffb944d9ccb04718846:
>>
>>   build-sys: restrict vmcoreinfo to fw_cfg+dma capable targets (2017-11-15 20:13:13 +0200)
>>
>> ----------------------------------------------------------------
>> pc, pci, virtio: fixes for rc1
>>
>> A bunch of fixes all over the place.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi. This failed tests on a couple of machines:
> 
> s390x:
> 
> TEST: tests/bios-tables-test... (pid=58925)
>   /i386/acpi/piix4:
> Looking for expected file 'tests/acpi-test-data/pc/DSDT'
> 
> Using expected file 'tests/acpi-test-data/pc/DSDT'
> 
> Looking for expected file 'tests/acpi-test-data/pc/APIC'
> 
> Using expected file 'tests/acpi-test-data/pc/APIC'
> 
> Looking for expected file 'tests/acpi-test-data/pc/HPET'
> 
> Using expected file 'tests/acpi-test-data/pc/HPET'
> 'iasl -p /tmp/asl-CHIM9Y.dsl -d tests/acpi-test-data/pc/DSDT' exited
> with status 65280
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler version 20160108-64
> Copyright (c) 2000 - 2016 Intel Corporation
> 
> Could not get ACPI tables from tests/acpi-test-data/pc/DSDT, AE_BAD_HEADER
> Input file tests/acpi-test-data/pc/DSDT, Length 0x1418 (5144) bytes
> Table [DSDT] is too long for file - needs: 0x18140000, remaining in file: 0x1418
> **
> ERROR:/home/linux1/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
> assertion failed: (!err && !exp_err)

That likely means that either iasl does not contain the right endianess
fixes yet (which OS are you using there?), or you need my patch here:

 https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03007.html

No clue about the arm issue, though.

 Thomas
