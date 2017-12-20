Received: from eggs.gnu.org ([2001:4830:134:3::10]:47187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRiiq-0004B3-JZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRiim-0002Js-Qb
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRiim-0002JP-JN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5788356F7
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:03:59 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1022438181
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:03:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:39 +0100
Message-Id: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 00/19] Initial support for Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f1faf2d59c91a8f1f59a0fc6339154efb749b55d:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-12-20 11:30:55 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream-hvf

for you to fetch changes up to 5fd1a70fb75d53b43dfff636a9c641dbf03f949f:

  i386: hvf: cleanup x86_gen.h (2017-12-20 18:39:06 +0100)

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

 configure                     |   38 +
 cpus.c                        |   89 ++
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
 target/i386/hvf/hvf.c         |  955 ++++++++++++++++++
 target/i386/hvf/panic.h       |   45 +
 target/i386/hvf/vmcs.h        |  371 +++++++
 target/i386/hvf/vmx.h         |  222 +++++
 target/i386/hvf/x86.c         |  186 ++++
 target/i386/hvf/x86.h         |  400 ++++++++
 target/i386/hvf/x86_cpuid.c   |  165 ++++
 target/i386/hvf/x86_decode.c  | 2186 +++++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/x86_decode.h  |  323 ++++++
 target/i386/hvf/x86_descr.c   |  125 +++
 target/i386/hvf/x86_descr.h   |   58 ++
 target/i386/hvf/x86_emu.c     | 1483 ++++++++++++++++++++++++++++
 target/i386/hvf/x86_emu.h     |   49 +
 target/i386/hvf/x86_flags.c   |  315 ++++++
 target/i386/hvf/x86_flags.h   |   80 ++
 target/i386/hvf/x86_gen.h     |   45 +
 target/i386/hvf/x86_mmu.c     |  271 +++++
 target/i386/hvf/x86_mmu.h     |   43 +
 target/i386/hvf/x86_task.c    |  192 ++++
 target/i386/hvf/x86_task.h    |   18 +
 target/i386/hvf/x86hvf.c      |  463 +++++++++
 target/i386/hvf/x86hvf.h      |   39 +
 target/i386/kvm.c             |    2 -
 38 files changed, 8480 insertions(+), 59 deletions(-)
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
 create mode 100644 target/i386/hvf/x86_gen.h
 create mode 100644 target/i386/hvf/x86_mmu.c
 create mode 100644 target/i386/hvf/x86_mmu.h
 create mode 100644 target/i386/hvf/x86_task.c
 create mode 100644 target/i386/hvf/x86_task.h
 create mode 100644 target/i386/hvf/x86hvf.c
 create mode 100644 target/i386/hvf/x86hvf.h
-- 
2.14.3
