Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwdY-00023R-0L
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwdU-0007Fw-U3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:55:32 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRwdU-0007F3-Ep
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:55:28 -0500
Received: by mail-wr0-x22c.google.com with SMTP id w68so12081401wrc.10
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:55:28 -0800 (PST)
Received: from donizetti.lan (dynamic-adsl-78-12-251-125.clienti.tiscali.it.
	[78.12.251.125])
	by smtp.gmail.com with ESMTPSA id t4sm3985330wmt.9.2017.12.21.00.55.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Dec 2017 00:55:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Dec 2017 09:55:24 +0100
Message-Id: <20171221085524.11674-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba26:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-18-v2' into staging (2017-12-20 13:20:48 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream-hvf

for you to fetch changes up to 0a4609ab57575f89565845af1ad076579add3e4b:

  i386: hvf: cleanup x86_gen.h (2017-12-21 09:51:53 +0100)

----------------------------------------------------------------
Initial support for the HVF accelerator

----------------------------------------------------------------
Paolo Bonzini (10):
      i386: hvf: move all hvf files in the same directory
      i386: hvf: header cleanup
      i386: hvf: unify register enums between HVF and the rest
      i386: hvf: remove more dead emulator code
      i386: hvf: remove ZERO_INIT macro
      i386: hvf: abort on decoding error
      i386: hvf: simplify flag handling
      i386: hvf: remove addr_t
      i386: hvf: remove VM_PANIC from "in"
      i386: hvf: cleanup x86_gen.h

Sergio Andres Gomez Del Real (9):
      apic: add function to apic that will be used by hvf
      i386: hvf: add code base from Google's QEMU repository
      i386: hvf: fix licensing issues; isolate task handling code (GPL v2-only)
      i386: hvf: use new helper functions for put/get xsave
      i386: hvf: implement hvf_get_supported_cpuid
      i386: refactor KVM cpuid code so that it applies to hvf as well
      i386: hvf: implement vga dirty page tracking
      i386: hvf: refactor event injection code for hvf
      i386: hvf: inject General Protection Fault when vmexit through vmcall

 accel/stubs/Makefile.objs     |    1 +
 accel/stubs/hvf-stub.c        |   31 +
 configure                     |   38 +
 cpus.c                        |   86 ++
 hw/intc/apic.c                |   12 +
 include/hw/i386/apic.h        |    1 +
 include/qemu/typedefs.h       |    1 +
 include/qom/cpu.h             |    2 +
 include/sysemu/hvf.h          |  107 ++
 qemu-options.hx               |   10 +-
 target/i386/Makefile.objs     |    1 +
 target/i386/cpu-qom.h         |    4 +-
 target/i386/cpu.c             |   80 +-
 target/i386/cpu.h             |  101 +-
 target/i386/hvf/Makefile.objs |    2 +
 target/i386/hvf/README.md     |    7 +
 target/i386/hvf/hvf-i386.h    |   48 +
 target/i386/hvf/hvf.c         |  959 ++++++++++++++++++
 target/i386/hvf/panic.h       |   45 +
 target/i386/hvf/vmcs.h        |  374 +++++++
 target/i386/hvf/vmx.h         |  222 +++++
 target/i386/hvf/x86.c         |  186 ++++
 target/i386/hvf/x86.h         |  400 ++++++++
 target/i386/hvf/x86_cpuid.c   |  166 ++++
 target/i386/hvf/x86_decode.c  | 2186 +++++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/x86_decode.h  |  323 ++++++
 target/i386/hvf/x86_descr.c   |  125 +++
 target/i386/hvf/x86_descr.h   |   58 ++
 target/i386/hvf/x86_emu.c     | 1483 ++++++++++++++++++++++++++++
 target/i386/hvf/x86_emu.h     |   49 +
 target/i386/hvf/x86_flags.c   |  315 ++++++
 target/i386/hvf/x86_flags.h   |   80 ++
 target/i386/hvf/x86_mmu.c     |  272 +++++
 target/i386/hvf/x86_mmu.h     |   43 +
 target/i386/hvf/x86_task.c    |  192 ++++
 target/i386/hvf/x86_task.h    |   18 +
 target/i386/hvf/x86hvf.c      |  465 +++++++++
 target/i386/hvf/x86hvf.h      |   39 +
 target/i386/kvm.c             |    2 -
 39 files changed, 8475 insertions(+), 59 deletions(-)
 create mode 100644 accel/stubs/hvf-stub.c
 create mode 100644 include/sysemu/hvf.h
 create mode 100644 target/i386/hvf/Makefile.objs
 create mode 100644 target/i386/hvf/README.md
 create mode 100644 target/i386/hvf/hvf-i386.h
 create mode 100644 target/i386/hvf/hvf.c
 create mode 100644 target/i386/hvf/panic.h
 create mode 100644 target/i386/hvf/vmcs.h
 create mode 100644 target/i386/hvf/vmx.h
 create mode 100644 target/i386/hvf/x86.c
 create mode 100644 target/i386/hvf/x86.h
 create mode 100644 target/i386/hvf/x86_cpuid.c
 create mode 100644 target/i386/hvf/x86_decode.c
 create mode 100644 target/i386/hvf/x86_decode.h
 create mode 100644 target/i386/hvf/x86_descr.c
 create mode 100644 target/i386/hvf/x86_descr.h
 create mode 100644 target/i386/hvf/x86_emu.c
 create mode 100644 target/i386/hvf/x86_emu.h
 create mode 100644 target/i386/hvf/x86_flags.c
 create mode 100644 target/i386/hvf/x86_flags.h
 create mode 100644 target/i386/hvf/x86_mmu.c
 create mode 100644 target/i386/hvf/x86_mmu.h
 create mode 100644 target/i386/hvf/x86_task.c
 create mode 100644 target/i386/hvf/x86_task.h
 create mode 100644 target/i386/hvf/x86hvf.c
 create mode 100644 target/i386/hvf/x86hvf.h
-- 
2.14.3
