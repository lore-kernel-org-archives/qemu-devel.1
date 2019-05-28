Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97149C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5048020989
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgbz-0005DZ-JG
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:14:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVgb9-0004tR-9j
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVgb4-0007Yr-HM
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVgay-0007ME-UN
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E2AB307E040;
	Tue, 28 May 2019 18:12:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5CFA5D9DC;
	Tue, 28 May 2019 18:12:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3E75C1138648; Tue, 28 May 2019 20:12:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 20:12:24 +0200
Message-ID: <87lfyqla7r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 18:12:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a bunch of headers without multiple inclusion guards.  Some are
clearly intentional, some look accidental.  Too many for me to find out
by examining each of them, so I'm asking their maintainers.

Why do I ask?  I'd like to mark the intentional ones and fix the
accidental ones, so they don't flunk "make check-headers" from "[RFC v4
0/7] Baby steps towards saner headers" just because they lack multiple
inclusion guards.

Just in case: what's a multiple inclusion guard?  It's

    #ifndef UNIQUE_GUARD_SYMBOL_H
    #define UNIQUE_GUARD_SYMBOL_H
    ...
    #endif

with nothing but comments outside the conditional, so that the header
can safely be included more than once.

I append the alphabetical list of headers without multiple inclusion
guards (as reported by scripts/clean-header-guards -nv), followed by the
same list sorted into maintainer buckets.  If you're cc'ed, please find
your bucket(s), and tell me which headers intentionally lack guards.


=3D Headers without inclusion guards =3D

accel/tcg/atomic_template.h
accel/tcg/tcg-runtime.h
audio/audio_template.h
audio/dsound_template.h
audio/mixeng_template.h
audio/rate_template.h
bsd-user/bsd-mman.h
bsd-user/errno_defs.h
bsd-user/freebsd/syscall_nr.h
bsd-user/netbsd/syscall_nr.h
bsd-user/openbsd/syscall_nr.h
bsd-user/syscall_defs.h
crypto/ivgen-essiv.h
crypto/ivgen-plain.h
crypto/ivgen-plain64.h
fpu/softfloat-specialize.h
hw/9pfs/xen-9pfs.h
hw/audio/hda-codec-common.h
hw/display/cirrus_vga_rop.h
hw/display/cirrus_vga_rop2.h
hw/display/milkymist-vgafb_template.h
hw/display/omap_lcd_template.h
hw/display/pl110_template.h
hw/display/pxa2xx_template.h
hw/display/sm501_template.h
hw/display/tc6393xb_template.h
hw/display/vga-helpers.h
hw/hppa/hppa_hardware.h
hw/input/adb-internal.h
hw/net/e1000e_core.h
hw/net/e1000x_common.h
hw/net/vmxnet3_defs.h
hw/usb/hcd-xhci.h
hw/usb/quirks-ftdi-ids.h
hw/usb/quirks-pl2303-ids.h
hw/usb/quirks.h
include/exec/cpu_ldst_template.h
include/exec/cpu_ldst_useronly_template.h
include/exec/memory_ldst.inc.h
include/exec/memory_ldst_cached.inc.h
include/exec/memory_ldst_phys.inc.h
include/fpu/softfloat-macros.h
include/hw/arm/allwinner-a10.h
include/hw/arm/omap.h
include/hw/arm/raspi_platform.h
include/hw/arm/xlnx-zynqmp.h
include/hw/char/cadence_uart.h
include/hw/display/xlnx_dp.h
include/hw/dma/xlnx-zynq-devcfg.h
include/hw/elf_ops.h
include/hw/kvm/clock.h
include/hw/m68k/mcf_fec.h
include/hw/mips/bios.h
include/hw/net/cadence_gem.h
include/hw/pci-bridge/simba.h
include/hw/pci/pci_regs.h
include/hw/qdev-dma.h
include/hw/sparc/sparc64.h
include/hw/timer/sun4v-rtc.h
include/hw/timer/xlnx-zynqmp-rtc.h
include/hw/xen/io/ring.h
include/libdecnumber/dconfig.h
include/libdecnumber/decDPD.h
include/libdecnumber/dpd/decimal128Local.h
include/ui/pixel_ops.h
include/ui/spice-display.h
linux-user/aarch64/sockbits.h
linux-user/aarch64/syscall_nr.h
linux-user/aarch64/termbits.h
linux-user/alpha/syscall_nr.h
linux-user/alpha/termbits.h
linux-user/arm/sockbits.h
linux-user/arm/syscall_nr.h
linux-user/arm/termbits.h
linux-user/cris/sockbits.h
linux-user/cris/syscall_nr.h
linux-user/cris/termbits.h
linux-user/errno_defs.h
linux-user/flat.h
linux-user/hppa/sockbits.h
linux-user/hppa/syscall_nr.h
linux-user/hppa/termbits.h
linux-user/i386/sockbits.h
linux-user/i386/syscall_nr.h
linux-user/i386/termbits.h
linux-user/ioctls.h
linux-user/m68k/sockbits.h
linux-user/m68k/syscall_nr.h
linux-user/m68k/termbits.h
linux-user/microblaze/sockbits.h
linux-user/microblaze/syscall_nr.h
linux-user/microblaze/termbits.h
linux-user/mips/syscall_nr.h
linux-user/mips/termbits.h
linux-user/mips64/sockbits.h
linux-user/mips64/syscall_nr.h
linux-user/mips64/target_cpu.h
linux-user/mips64/target_fcntl.h
linux-user/mips64/target_structs.h
linux-user/mips64/termbits.h
linux-user/nios2/sockbits.h
linux-user/nios2/syscall_nr.h
linux-user/nios2/termbits.h
linux-user/openrisc/sockbits.h
linux-user/openrisc/syscall_nr.h
linux-user/openrisc/termbits.h
linux-user/ppc/syscall_nr.h
linux-user/ppc/termbits.h
linux-user/riscv/sockbits.h
linux-user/riscv/syscall_nr.h
linux-user/riscv/target_syscall.h
linux-user/riscv/termbits.h
linux-user/s390x/sockbits.h
linux-user/s390x/syscall_nr.h
linux-user/s390x/termbits.h
linux-user/sh4/sockbits.h
linux-user/sh4/syscall_nr.h
linux-user/sh4/termbits.h
linux-user/socket.h
linux-user/sparc/syscall_nr.h
linux-user/sparc/termbits.h
linux-user/sparc64/sockbits.h
linux-user/sparc64/syscall_nr.h
linux-user/sparc64/target_cpu.h
linux-user/sparc64/target_fcntl.h
linux-user/sparc64/target_signal.h
linux-user/sparc64/termbits.h
linux-user/syscall_types.h
linux-user/target_flat.h
linux-user/tilegx/sockbits.h
linux-user/x86_64/sockbits.h
linux-user/x86_64/syscall_nr.h
linux-user/x86_64/target_cpu.h
linux-user/x86_64/termbits.h
linux-user/xtensa/sockbits.h
linux-user/xtensa/target_flat.h
qemu-options-wrapper.h
scripts/cocci-macro-file.h
target/alpha/helper.h
target/arm/helper-a64.h
target/arm/helper-sve.h
target/arm/helper.h
target/arm/op_addsub.h
target/cris/crisv10-decode.h
target/cris/helper.h
target/cris/mmu.h
target/cris/opcode-cris.h
target/hppa/helper.h
target/i386/cc_helper_template.h
target/i386/helper.h
target/i386/ops_sse.h
target/i386/ops_sse_header.h
target/i386/shift_helper_template.h
target/i386/whp-dispatch.h
target/lm32/helper.h
target/m68k/helper.h
target/microblaze/helper.h
target/microblaze/microblaze-decode.h
target/microblaze/mmu.h
target/mips/helper.h
target/moxie/helper.h
target/moxie/machine.h
target/moxie/mmu.h
target/nios2/helper.h
target/openrisc/helper.h
target/ppc/helper.h
target/riscv/cpu_bits.h
target/riscv/cpu_user.h
target/riscv/helper.h
target/riscv/instmap.h
target/s390x/helper.h
target/sh4/helper.h
target/sparc/helper.h
target/tilegx/helper.h
target/tilegx/spr_def_64.h
target/tricore/helper.h
target/tricore/tricore-opcodes.h
target/unicore32/helper.h
target/xtensa/helper.h
target/xtensa/overlay_tool.h
target/xtensa/xtensa-isa.h
tcg/aarch64/tcg-target.opc.h
tcg/i386/tcg-target.opc.h
tcg/tcg-gvec-desc.h
tcg/tcg-op-gvec.h
tcg/tcg-opc.h
tests/crypto-tls-psk-helpers.h
tests/crypto-tls-x509-helpers.h
tests/io-channel-helpers.h
tests/libqos/virtio-9p.h
tests/libqos/virtio-balloon.h
tests/libqos/virtio-blk.h
tests/libqos/virtio-net.h
tests/libqos/virtio-rng.h
tests/libqos/virtio-scsi.h
tests/libqos/virtio-serial.h
tests/migration/aarch64/a-b-kernel.h
tests/migration/i386/a-b-bootblock.h
tests/migration/s390x/a-b-bios.h
tests/socket-helpers.h
tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
ui/vgafont.h
ui/vnc-enc-hextile-template.h
ui/vnc_keysym.h


=3D Sorted into MAINTAINERS buckets =3D

Guest CPU cores (TCG):
----------------------
Overall
M: Richard Henderson <rth@twiddle.net>
R: Paolo Bonzini <pbonzini@redhat.com>
accel/tcg/atomic_template.h
accel/tcg/tcg-runtime.h
include/exec/cpu_ldst_template.h
include/exec/cpu_ldst_useronly_template.h

FPU emulation
M: Aurelien Jarno <aurelien@aurel32.net>
M: Peter Maydell <peter.maydell@linaro.org>
M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
fpu/softfloat-specialize.h
include/fpu/softfloat-macros.h

Alpha
M: Richard Henderson <rth@twiddle.net>

ARM
M: Peter Maydell <peter.maydell@linaro.org>
target/arm/helper-a64.h
target/arm/helper-sve.h
target/arm/helper.h
target/arm/op_addsub.h

ARM SMMU
M: Eric Auger <eric.auger@redhat.com>

CRIS
M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
target/cris/crisv10-decode.h
target/cris/helper.h
target/cris/mmu.h
target/cris/opcode-cris.h

HPPA (PA-RISC)
M: Richard Henderson <rth@twiddle.net>
target/hppa/helper.h

LM32
M: Michael Walle <michael@walle.cc>
hw/display/milkymist-vgafb_template.h
target/lm32/helper.h

M68K
M: Laurent Vivier <laurent@vivier.eu>
target/m68k/helper.h

MicroBlaze
M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
target/microblaze/helper.h
target/microblaze/microblaze-decode.h
target/microblaze/mmu.h

MIPS
M: Aurelien Jarno <aurelien@aurel32.net>
M: Aleksandar Markovic <amarkovic@wavecomp.com>
R: Aleksandar Rikalo <arikalo@wavecomp.com>
include/hw/mips/bios.h
target/mips/helper.h

Moxie
M: Anthony Green <green@moxielogic.com>
target/moxie/helper.h
target/moxie/machine.h
target/moxie/mmu.h

NiosII
M: Chris Wulff <crwulff@gmail.com>
M: Marek Vasut <marex@denx.de>
target/nios2/helper.h

OpenRISC
M: Stafford Horne <shorne@gmail.com>
target/openrisc/helper.h

PowerPC
M: David Gibson <david@gibson.dropbear.id.au>
target/ppc/helper.h

RISC-V
M: Palmer Dabbelt <palmer@sifive.com>
M: Alistair Francis <Alistair.Francis@wdc.com>
M: Sagar Karandikar <sagark@eecs.berkeley.edu>
M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
target/riscv/cpu_bits.h
target/riscv/cpu_user.h
target/riscv/helper.h
target/riscv/instmap.h

S390
M: Richard Henderson <rth@twiddle.net>
M: David Hildenbrand <david@redhat.com>
target/s390x/helper.h

SH4
M: Aurelien Jarno <aurelien@aurel32.net>
target/sh4/helper.h

SPARC
M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
M: Artyom Tarasenko <atar4qemu@gmail.com>
include/hw/sparc/sparc64.h
target/sparc/helper.h

UniCore32
M: Guan Xuetao <gxt@mprc.pku.edu.cn>
target/unicore32/helper.h

X86
M: Paolo Bonzini <pbonzini@redhat.com>
M: Richard Henderson <rth@twiddle.net>
M: Eduardo Habkost <ehabkost@redhat.com>
target/i386/cc_helper_template.h
target/i386/helper.h
target/i386/ops_sse.h
target/i386/ops_sse_header.h
target/i386/shift_helper_template.h
target/i386/whp-dispatch.h

Xtensa
M: Max Filippov <jcmvbkbc@gmail.com>
target/xtensa/helper.h
target/xtensa/overlay_tool.h
target/xtensa/xtensa-isa.h

TriCore
M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
target/tricore/helper.h
target/tricore/tricore-opcodes.h

Multiarch Linux User Tests
M: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Guest CPU Cores (KVM):
----------------------

Overall
M: Paolo Bonzini <pbonzini@redhat.com>
include/hw/kvm/clock.h

ARM
M: Peter Maydell <peter.maydell@linaro.org>

MIPS
M: James Hogan <jhogan@kernel.org>
R: Aleksandar Rikalo <arikalo@wavecomp.com>

PPC
M: David Gibson <david@gibson.dropbear.id.au>

S390
M: Halil Pasic <pasic@linux.ibm.com>
M: Cornelia Huck <cohuck@redhat.com>
M: Christian Borntraeger <borntraeger@de.ibm.com>

X86
M: Paolo Bonzini <pbonzini@redhat.com>
M: Marcelo Tosatti <mtosatti@redhat.com>

Guest CPU Cores (Xen):
----------------------

X86
M: Stefano Stabellini <sstabellini@kernel.org>
M: Anthony Perard <anthony.perard@citrix.com>
M: Paul Durrant <paul.durrant@citrix.com>
include/hw/xen/io/ring.h

ARM Machines
------------
Allwinner-a10
M: Beniamino Galvani <b.galvani@gmail.com>
M: Peter Maydell <peter.maydell@linaro.org>
include/hw/arm/allwinner-a10.h

ARM PrimeCell and CMSDK devices
M: Peter Maydell <peter.maydell@linaro.org>
hw/display/pl110_template.h

Raspberry Pi
M: Peter Maydell <peter.maydell@linaro.org>
R: Andrew Baumann <Andrew.Baumann@microsoft.com>
R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
include/hw/arm/raspi_platform.h

PXA2XX
M: Andrzej Zaborowski <balrogg@gmail.com>
M: Peter Maydell <peter.maydell@linaro.org>
hw/display/pxa2xx_template.h

Xilinx ZynqMP
M: Alistair Francis <alistair@alistair23.me>
M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
M: Peter Maydell <peter.maydell@linaro.org>
include/hw/arm/xlnx-zynqmp.h
include/hw/display/xlnx_dp.h
include/hw/dma/xlnx-zynq-devcfg.h
include/hw/timer/xlnx-zynqmp-rtc.h

HP-PARISC Machines
------------------
Dino
M: Richard Henderson <rth@twiddle.net>
R: Helge Deller <deller@gmx.de>
hw/hppa/hppa_hardware.h

PowerPC Machines
----------------
New World (mac99)
M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
R: David Gibson <david@gibson.dropbear.id.au>
hw/input/adb-internal.h

sam460ex
M: BALATON Zoltan <balaton@eik.bme.hu>
hw/display/sm501_template.h

SPARC Machines
--------------
Sun4u
M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
include/hw/pci-bridge/simba.h

Sun4v
M: Artyom Tarasenko <atar4qemu@gmail.com>
include/hw/timer/sun4v-rtc.h

Devices
-------

OMAP
M: Peter Maydell <peter.maydell@linaro.org>
hw/display/omap_lcd_template.h
include/hw/arm/omap.h

PCI
M: Michael S. Tsirkin <mst@redhat.com>
M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
include/hw/pci/pci_regs.h

Network devices
M: Jason Wang <jasowang@redhat.com>
hw/net/e1000e_core.h
hw/net/e1000x_common.h
hw/net/vmxnet3_defs.h
include/hw/net/cadence_gem.h

USB
M: Gerd Hoffmann <kraxel@redhat.com>
hw/usb/hcd-xhci.h
hw/usb/quirks-ftdi-ids.h
hw/usb/quirks-pl2303-ids.h
hw/usb/quirks.h

virtio-9p
M: Greg Kurz <groug@kaod.org>
hw/9pfs/xen-9pfs.h

Vmware
M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
hw/net/vmxnet3_defs.h

e1000x
M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
hw/net/e1000x_common.h

e1000e
M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
hw/net/e1000e_core.h

Cirrus VGA
M: Gerd Hoffmann <kraxel@redhat.com>
hw/display/cirrus_vga_rop.h
hw/display/cirrus_vga_rop2.h

Subsystems
----------
Audio
M: Gerd Hoffmann <kraxel@redhat.com>
audio/audio_template.h
audio/dsound_template.h
audio/mixeng_template.h
audio/rate_template.h
hw/audio/hda-codec-common.h

SPICE
M: Gerd Hoffmann <kraxel@redhat.com>
include/ui/spice-display.h

Graphics
M: Gerd Hoffmann <kraxel@redhat.com>
include/ui/pixel_ops.h
ui/vgafont.h
ui/vnc-enc-hextile-template.h
ui/vnc_keysym.h

qtest
M: Thomas Huth <thuth@redhat.com>
M: Laurent Vivier <lvivier@redhat.com>
R: Paolo Bonzini <pbonzini@redhat.com>
tests/libqos/virtio-9p.h
tests/libqos/virtio-balloon.h
tests/libqos/virtio-blk.h
tests/libqos/virtio-net.h
tests/libqos/virtio-rng.h
tests/libqos/virtio-scsi.h
tests/libqos/virtio-serial.h

Cryptography
M: Daniel P. Berrange <berrange@redhat.com>
crypto/ivgen-essiv.h
crypto/ivgen-plain.h
crypto/ivgen-plain64.h
tests/crypto-tls-psk-helpers.h
tests/crypto-tls-x509-helpers.h

EDK2 Firmware
M: Laszlo Ersek <lersek@redhat.com>
M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h

Usermode Emulation
------------------
BSD user
S: Orphan
bsd-user/bsd-mman.h
bsd-user/errno_defs.h
bsd-user/freebsd/syscall_nr.h
bsd-user/netbsd/syscall_nr.h
bsd-user/openbsd/syscall_nr.h
bsd-user/syscall_defs.h

Linux user
M: Riku Voipio <riku.voipio@iki.fi>
R: Laurent Vivier <laurent@vivier.eu>
linux-user/aarch64/sockbits.h
linux-user/aarch64/syscall_nr.h
linux-user/aarch64/termbits.h
linux-user/alpha/syscall_nr.h
linux-user/alpha/termbits.h
linux-user/arm/sockbits.h
linux-user/arm/syscall_nr.h
linux-user/arm/termbits.h
linux-user/cris/sockbits.h
linux-user/cris/syscall_nr.h
linux-user/cris/termbits.h
linux-user/errno_defs.h
linux-user/flat.h
linux-user/hppa/sockbits.h
linux-user/hppa/syscall_nr.h
linux-user/hppa/termbits.h
linux-user/i386/sockbits.h
linux-user/i386/syscall_nr.h
linux-user/i386/termbits.h
linux-user/ioctls.h
linux-user/m68k/sockbits.h
linux-user/m68k/syscall_nr.h
linux-user/m68k/termbits.h
linux-user/microblaze/sockbits.h
linux-user/microblaze/syscall_nr.h
linux-user/microblaze/termbits.h
linux-user/mips/syscall_nr.h
linux-user/mips/termbits.h
linux-user/mips64/sockbits.h
linux-user/mips64/syscall_nr.h
linux-user/mips64/target_cpu.h
linux-user/mips64/target_fcntl.h
linux-user/mips64/target_structs.h
linux-user/mips64/termbits.h
linux-user/nios2/sockbits.h
linux-user/nios2/syscall_nr.h
linux-user/nios2/termbits.h
linux-user/openrisc/sockbits.h
linux-user/openrisc/syscall_nr.h
linux-user/openrisc/termbits.h
linux-user/ppc/syscall_nr.h
linux-user/ppc/termbits.h
linux-user/riscv/sockbits.h
linux-user/riscv/syscall_nr.h
linux-user/riscv/target_syscall.h
linux-user/riscv/termbits.h
linux-user/s390x/sockbits.h
linux-user/s390x/syscall_nr.h
linux-user/s390x/termbits.h
linux-user/sh4/sockbits.h
linux-user/sh4/syscall_nr.h
linux-user/sh4/termbits.h
linux-user/socket.h
linux-user/sparc/syscall_nr.h
linux-user/sparc/termbits.h
linux-user/sparc64/sockbits.h
linux-user/sparc64/syscall_nr.h
linux-user/sparc64/target_cpu.h
linux-user/sparc64/target_fcntl.h
linux-user/sparc64/target_signal.h
linux-user/sparc64/termbits.h
linux-user/syscall_types.h
linux-user/target_flat.h
linux-user/tilegx/sockbits.h
linux-user/x86_64/sockbits.h
linux-user/x86_64/syscall_nr.h
linux-user/x86_64/target_cpu.h
linux-user/x86_64/termbits.h
linux-user/xtensa/sockbits.h
linux-user/xtensa/target_flat.h

Tiny Code Generator (TCG)
-------------------------
Common code
M: Richard Henderson <rth@twiddle.net>
tcg/aarch64/tcg-target.opc.h
tcg/tcg-gvec-desc.h
tcg/tcg-op-gvec.h
tcg/tcg-opc.h

AArch64 target
M: Claudio Fontana <claudio.fontana@huawei.com>
M: Claudio Fontana <claudio.fontana@gmail.com>
tcg/aarch64/tcg-target.opc.h

i386 target
M: Richard Henderson <rth@twiddle.net>
tcg/i386/tcg-target.opc.h

UNMAINTAINED
------------
hw/display/tc6393xb_template.h
include/exec/memory_ldst.inc.h
include/exec/memory_ldst_cached.inc.h
include/exec/memory_ldst_phys.inc.h
include/hw/char/cadence_uart.h
include/hw/elf_ops.h
include/hw/qdev-dma.h
include/libdecnumber/dconfig.h
include/libdecnumber/decDPD.h
include/libdecnumber/dpd/decimal128Local.h
qemu-options-wrapper.h
scripts/cocci-macro-file.h
target/tilegx/helper.h
target/tilegx/spr_def_64.h
tests/io-channel-helpers.h
tests/migration/aarch64/a-b-kernel.h
tests/migration/i386/a-b-bootblock.h
tests/migration/s390x/a-b-bios.h
tests/socket-helpers.h

