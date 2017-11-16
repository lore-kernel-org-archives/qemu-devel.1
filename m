Received: from eggs.gnu.org ([2001:4830:134:3::10]:45765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMXI-0001uG-J4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMXE-0007OZ-Lp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFMXE-0007OE-CG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:57:00 -0500
Date: Thu, 16 Nov 2017 17:56:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171116175149-mutt-send-email-mst@kernel.org>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
	<CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
	<20171116173033-mutt-send-email-mst@kernel.org>
	<20171116154534.GR16461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116154534.GR16461@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 16, 2017 at 03:45:34PM +0000, Daniel P. Berrange wrote:
> On Thu, Nov 16, 2017 at 05:38:18PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Nov 16, 2017 at 02:41:09PM +0000, Peter Maydell wrote:
> > > On 15 November 2017 at 18:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > The following changes since commit 1fa0f627d03cd0d0755924247cafeb42969016bf:
> > > >
> > > >   Update version for v2.11.0-rc1 release (2017-11-14 18:37:49 +0000)
> > > >
> > > > are available in the git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > > >
> > > > for you to fetch changes up to 6ed0c1c3ab0925009d15cffb944d9ccb04718846:
> > > >
> > > >   build-sys: restrict vmcoreinfo to fw_cfg+dma capable targets (2017-11-15 20:13:13 +0200)
> > > >
> > > > ----------------------------------------------------------------
> > > > pc, pci, virtio: fixes for rc1
> > > >
> > > > A bunch of fixes all over the place.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > Hi. This failed tests on a couple of machines:
> > > 
> > > s390x:
> > > 
> > > TEST: tests/bios-tables-test... (pid=58925)
> > >   /i386/acpi/piix4:
> > > Looking for expected file 'tests/acpi-test-data/pc/DSDT'
> > > 
> > > Using expected file 'tests/acpi-test-data/pc/DSDT'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/pc/APIC'
> > > 
> > > Using expected file 'tests/acpi-test-data/pc/APIC'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/pc/HPET'
> > > 
> > > Using expected file 'tests/acpi-test-data/pc/HPET'
> > > 'iasl -p /tmp/asl-CHIM9Y.dsl -d tests/acpi-test-data/pc/DSDT' exited
> > > with status 65280
> > > Intel ACPI Component Architecture
> > > ASL+ Optimizing Compiler version 20160108-64
> > > Copyright (c) 2000 - 2016 Intel Corporation
> > > 
> > > Could not get ACPI tables from tests/acpi-test-data/pc/DSDT, AE_BAD_HEADER
> > > Input file tests/acpi-test-data/pc/DSDT, Length 0x1418 (5144) bytes
> > > Table [DSDT] is too long for file - needs: 0x18140000, remaining in file: 0x1418
> > > **
> > > ERROR:/home/linux1/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
> > > assertion failed: (!err && !exp_err)
> > > FAIL
> > > GTester: last random seed: R02S7430f83941b25a926c586492b2745d2c
> > > (pid=58933)
> > >   /i386/acpi/q35:
> > 
> > 
> > 
> > > Looking for expected file 'tests/acpi-test-data/q35/DSDT'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/DSDT'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/q35/APIC'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/APIC'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/q35/HPET'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/HPET'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/q35/MCFG'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/MCFG'
> > > 'iasl -p /tmp/asl-NRWT9Y.dsl -d tests/acpi-test-data/q35/DSDT' exited
> > > with status 65280
> > > Intel ACPI Component Architecture
> > > ASL+ Optimizing Compiler version 20160108-64
> > > Copyright (c) 2000 - 2016 Intel Corporation
> > > 
> > > Could not get ACPI tables from tests/acpi-test-data/q35/DSDT, AE_BAD_HEADER
> > > Input file tests/acpi-test-data/q35/DSDT, Length 0x1E94 (7828) bytes
> > > Table [DSDT] is too long for file - needs: 0x941E0000, remaining in file: 0x1E94
> > > **
> > > ERROR:/home/linux1/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
> > > assertion failed: (!err && !exp_err)
> > > FAIL
> > > 
> > > & similarly for a bunch of other tests. Looks like an
> > > endianness issue.
> > > 
> > > and on 32-bit arm:
> > > 
> > > TEST: tests/bios-tables-test... (pid=30809)
> > >   /i386/acpi/piix4:
> > > Looking for expected file 'tests/acpi-test-data/pc/DSDT'
> > > 
> > > Using expected file 'tests/acpi-test-data/pc/DSDT'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/pc/APIC'
> > > 
> > > Using expected file 'tests/acpi-test-data/pc/APIC'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/pc/HPET'
> > > 
> > > Using expected file 'tests/acpi-test-data/pc/HPET'
> > > 'iasl -p /tmp/asl-6T2N9Y.dsl -e /tmp/aml-TV2N9Y -d /tmp/aml-TV2N9Y'
> > > exited with status 11Input file /tmp/aml-TV2N9Y, Length 0x1418 (5144)
> > > bytes
> > > ACPI: DSDT 0x0000000000000000 001418 (v01 BOCHS  BXPCDSDT 00000001
> > > BXPC 00000001)
> > > Pass 1 parse of [DSDT]
> > > Pass 2 parse of [DSDT]
> > > Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > > 
> > > Parsing completed
> > > 'iasl -p /tmp/asl-PKDO9Y.dsl -e tests/acpi-test-data/pc/DSDT -d
> > > tests/acpi-test-data/pc/DSDT' exited with status 11Input file
> > > tests/acpi-test-data/pc/DSDT, Length 0x1418 (5144) bytes
> > > ACPI: DSDT 0x0000000000000000 001418 (v01 BOCHS  BXPCDSDT 00000001
> > > BXPC 00000001)
> > > Pass 1 parse of [DSDT]
> > > Pass 2 parse of [DSDT]
> > > Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> > > 
> > > Parsing completed
> > > **
> > > ERROR:/home/peter.maydell/qemu/tests/bios-tables-test.c:461:test_acpi_asl:
> > > assertion failed: (!err && !exp_err)
> > > FAIL
> > > GTester: last random seed: R02S5d06952865b5a6ffb8443ae4d324e880
> > > (pid=30816)
> > >   /i386/acpi/q35:
> > > Looking for expected file 'tests/acpi-test-data/q35/DSDT'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/DSDT'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/q35/APIC'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/APIC'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/q35/HPET'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/HPET'
> > > 
> > > Looking for expected file 'tests/acpi-test-data/q35/MCFG'
> > > 
> > > Using expected file 'tests/acpi-test-data/q35/MCFG'
> > > OK
> > > 
> > > (and similar fails in other tests)
> > > 
> > > 
> > > thanks
> > > -- PMM
> > 
> > I think it's     test: fix detection of errors from iasl
> > I'll drop it for now.
> 
> I think that patch is merely exposing a failure that has always
> happened, but which we've never noticed before. So dropping that
> patch just hides the error again, doesn't fix the error.
> 
> Regards,
> Daniel

We shouldn't fail test if system can't load expected files.
This just will trip up people trying to build qemu.

Maybe at this point we shouldn't run iasl unconditionally.

It used to be very important when we had parts of the tables
generated by iasl, so different versions would introduce
trivial changes.

Maybe now we should compare binaries first, run iasl to help debugging
only if they differ.

Will save writing out files too.

And maybe show the diff in rebuild-expected-aml too - add it to
.git/COMMIT_EDITMSG so people remember to include it in the commit log?




> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
