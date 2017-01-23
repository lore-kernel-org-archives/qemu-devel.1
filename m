Received: from eggs.gnu.org ([2001:4830:134:3::10]:38122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1l-0003CZ-PH
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1i-0005sX-LN
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1i-0005rx-F0
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:25 -0200
Message-Id: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/13] x86, machine, numa queue (2017-01-23)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to d99569d9d8562c480e0befab601756b0b7b5d0e0:

  kvm: Allow invtsc migration if tsc-khz is set explicitly (2017-01-23 21:26:27 -0200)

----------------------------------------------------------------
x86, machine, numa queue (2017-01-23)

----------------------------------------------------------------

Dou Liyang (1):
  vl: Ensure the numa_post_machine_init func in the appropriate location

Eduardo Habkost (6):
  i386: Remove AMD feature flag aliases from Opteron models
  i386: Return migration-safe field on query-cpu-definitions
  arch_init: Remove unnecessary default_config_files table
  qemu-options: Rename variables on the -numa "cpus" option
  kvm: Simplify invtsc check
  kvm: Allow invtsc migration if tsc-khz is set explicitly

He Chen (1):
  x86: add AVX512_VPOPCNTDQ features

Igor Mammedov (3):
  pc: cleanup: move smbios_set_cpuid() into pc_build_smbios()
  pc: don't return cpu pointer from pc_new_cpu() as it's not needed
    anymore
  machine: Make possible_cpu_arch_ids() return const pointer

Thomas Huth (2):
  MAINTAINERS: Add an entry for hw/core/null-machine.c
  hw/core/null-machine: Add the possibility to instantiate a CPU and RAM

 include/hw/acpi/acpi_dev_interface.h |  2 +-
 include/hw/boards.h                  |  2 +-
 include/hw/i386/pc.h                 |  2 +-
 include/qemu/config-file.h           |  4 ---
 target/i386/cpu-qom.h                |  2 ++
 target/i386/cpu.h                    |  1 +
 arch_init.c                          | 27 -------------------
 hw/acpi/cpu.c                        |  6 ++---
 hw/acpi/cpu_hotplug.c                |  4 +--
 hw/core/null-machine.c               | 27 +++++++++++++++++--
 hw/i386/acpi-build.c                 |  8 +++---
 hw/i386/pc.c                         | 51 ++++++++++++++----------------------
 stubs/pc_madt_cpu_entry.c            |  2 +-
 target/i386/cpu.c                    | 51 +++++++++++-------------------------
 target/i386/kvm.c                    | 20 +++++++-------
 vl.c                                 | 23 +++++++++++-----
 MAINTAINERS                          |  1 +
 hw/core/Makefile.objs                |  2 +-
 qemu-options.hx                      |  8 +++---
 19 files changed, 108 insertions(+), 135 deletions(-)

-- 
2.11.0.259.g40922b1
