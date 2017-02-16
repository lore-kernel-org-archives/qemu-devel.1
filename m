Received: from eggs.gnu.org ([2001:4830:134:3::10]:51647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6F-0003SA-Vs
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6C-0007wC-PD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:31:59 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6C-0007va-IJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:31:56 -0500
Received: by mail-wr0-x231.google.com with SMTP id z61so12870659wrc.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:31:56 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56])
	by smtp.gmail.com with ESMTPSA id g5sm9203365wrd.0.2017.02.16.06.31.50
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Feb 2017 06:31:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:24 +0100
Message-Id: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/23] Misc patches for 2017-02-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:

  Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 395d41a549f69f4ec603afa3d3ade1e2005777d5:

  target-i386: correctly propagate retaddr into SVM helpers (2017-02-16 15:30:49 +0100)

----------------------------------------------------------------
* GUEST_PANICKED improvements (Anton)
* vCont gdbstub rewrite (Claudio)
* Fix CPU creation with -device (Liyang)
* Logging fixes for pty chardevs (Ed)
* Makefile "move if changed" fix (Lin)
* First part of cpu_exec refactoring (me)
* SVM emulation fix (me)
* apic_delivered fix (Pavel)
* "info ioapic" fix (Peter)
* qemu-nbd socket activation (Richard)
* QOMification of mcf_uart (Thomas)

----------------------------------------------------------------
Alberto Garcia (1):
      qemu-doc: Clarify that -vga std is now the default

Anton Nefedov (4):
      qemu-char: socket backend: disconnect on write error
      i386/cpu: add crash-information QOM property
      report guest crash information in GUEST_PANICKED event
      vl: log available guest crash information

Claudio Imbrenda (2):
      move vm_start to cpus.c
      gdbstub: Fix vCont behaviour

Dou Liyang (1):
      vl: Move the cpu_synchronize_all_post_init() after generic devices initialization

Ed Swierk (1):
      char: drop data written to a disconnected pty

Lin Ma (1):
      Makefile: avoid leaving the temporary QEMU_PKGVERSION header file

Paolo Bonzini (7):
      test-vmstate: remove yield_until_fd_readable
      cpu-exec: fix icount out-of-bounds access
      cpu-exec: tighten barrier on TCG_EXIT_REQUESTED
      cpu-exec: avoid cpu_loop_exit in cpu_handle_interrupt
      cpu-exec: avoid repeated sigsetjmp on interrupts
      cpu-exec: remove outermost infinite loop
      target-i386: correctly propagate retaddr into SVM helpers

Pavel Dovgalyuk (1):
      apic: reset apic_delivered global variable on machine reset

Peter Xu (3):
      kvm/ioapic: dump real object instead of a fake one
      ioapic: fix error report value of def version
      kvm/ioapic: correct kvm ioapic version

Richard W.M. Jones (1):
      qemu-nbd: Implement socket activation.

Thomas Huth (1):
      hw/char/mcf_uart: QOMify the ColdFire UART

 Makefile                  |   6 +-
 chardev/char-pty.c        |   2 +-
 chardev/char-socket.c     |  10 +++
 cpu-exec.c                |  86 ++++++++++---------
 cpus.c                    |  42 ++++++++++
 gdbstub.c                 | 209 +++++++++++++++++++++++++++++++++++-----------
 hw/char/mcf_uart.c        | 102 ++++++++++++++++------
 hw/i386/kvm/ioapic.c      |  13 ++-
 hw/intc/apic_common.c     |   2 +
 hw/intc/ioapic.c          |   6 +-
 hw/m68k/mcf5208.c         |   6 +-
 hw/misc/pvpanic.c         |   2 +-
 hw/ppc/spapr_rtas.c       |   3 +-
 include/exec/exec-all.h   |   1 +
 include/hw/m68k/mcf.h     |   6 +-
 include/qom/cpu.h         |  10 +++
 include/sysemu/sysemu.h   |   4 +-
 kvm-all.c                 |   3 +-
 qapi-schema.json          |  24 ++++++
 qapi/event.json           |   6 +-
 qemu-nbd.c                | 172 ++++++++++++++++++++++++++++++++++++--
 qemu-options.hx           |   4 +-
 qom/cpu.c                 |  11 +++
 target/i386/cpu.c         |  51 +++++++++++
 target/i386/cpu.h         |   5 +-
 target/i386/excp_helper.c |  11 +--
 target/i386/helper.h      |   1 -
 target/i386/misc_helper.c |  24 +++---
 target/i386/seg_helper.c  |   6 +-
 target/i386/svm_helper.c  |  65 +++++++-------
 target/s390x/kvm.c        |   4 +-
 tests/test-vmstate.c      |  11 ---
 vl.c                      |  56 +++++--------
 33 files changed, 711 insertions(+), 253 deletions(-)
-- 
1.8.3.1
