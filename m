Received: from eggs.gnu.org ([2001:4830:134:3::10]:54228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfD-00075W-Ip
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXf8-0006oj-KK
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:47 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXf8-0006oK-G5
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:42 -0500
Received: by mail-qk0-x242.google.com with SMTP id d21so13223582qkj.3
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 18:04:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 23:04:09 -0300
Message-Id: <20180114020412.26160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/3] add helpers to be more explicit when
 using QOM abstract parent hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi,

Learning how to implement QOM devices I found the pattern changing parent hooks
when the parent is abstract not trivial to understand.

This series add few helpers to have this pattern more explicit.

Those functions deserve some comments, but before spending more time I'd like
to get some feedbacks if this might be useful or not.
If so, I can split the 3rd patch in many patches for each subsystem maintainers.

This can also be use for the CPUClass->reset() method, dunno if useful but
maybe to be consistent.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  qdev: rename typedef qdev_resetfn() -> DeviceReset()
  qdev: add helpers to be more explicit when using abstract QOM parent functions
  qdev: use device_class_set_parent_realize/unrealize/reset()

 include/hw/qdev-core.h             | 14 ++++++++++++--
 hw/core/qdev.c                     | 24 ++++++++++++++++++++++++
 hw/i386/kvm/i8254.c                |  4 ++--
 hw/i386/kvm/i8259.c                |  3 +--
 hw/input/adb-kbd.c                 |  4 ++--
 hw/input/adb-mouse.c               |  4 ++--
 hw/intc/arm_gic.c                  |  3 +--
 hw/intc/arm_gic_kvm.c              |  7 +++----
 hw/intc/arm_gicv3.c                |  3 +--
 hw/intc/arm_gicv3_its_kvm.c        |  3 +--
 hw/intc/arm_gicv3_kvm.c            |  7 +++----
 hw/intc/i8259.c                    |  3 +--
 hw/net/vmxnet3.c                   |  4 ++--
 hw/pci-bridge/gen_pcie_root_port.c |  3 +--
 hw/scsi/vmw_pvscsi.c               |  4 ++--
 hw/timer/i8254.c                   |  3 +--
 hw/vfio/amd-xgbe.c                 |  4 ++--
 hw/vfio/calxeda-xgmac.c            |  4 ++--
 hw/virtio/virtio-pci.c             |  4 ++--
 target/alpha/cpu.c                 |  4 ++--
 target/arm/cpu.c                   |  4 ++--
 target/cris/cpu.c                  |  4 ++--
 target/hppa/cpu.c                  |  4 ++--
 target/i386/cpu.c                  |  8 ++++----
 target/lm32/cpu.c                  |  5 ++---
 target/m68k/cpu.c                  |  5 ++---
 target/microblaze/cpu.c            |  5 ++---
 target/mips/cpu.c                  |  5 ++---
 target/moxie/cpu.c                 |  5 ++---
 target/nios2/cpu.c                 |  4 ++--
 target/openrisc/cpu.c              |  5 ++---
 target/ppc/translate_init.c        |  8 ++++----
 target/s390x/cpu.c                 |  4 ++--
 target/sh4/cpu.c                   |  4 ++--
 target/sparc/cpu.c                 |  4 ++--
 target/tilegx/cpu.c                |  4 ++--
 target/tricore/cpu.c               |  4 ++--
 target/unicore32/cpu.c             |  4 ++--
 target/xtensa/cpu.c                |  4 ++--
 39 files changed, 109 insertions(+), 90 deletions(-)

-- 
2.15.1
