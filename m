Received: from eggs.gnu.org ([209.51.188.92]:59402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM68j-0003lM-GT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM68c-0001Yo-45
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM68O-0008Sg-9E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id j13so1288342wmh.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:26:55 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 10:26:14 +0300
Message-Id: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 00/27] gdbstub: Refactor command packets
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, liran.alon@oracle.com, Jon Doron <arilou@gmail.com>

This patch series refactors the old gdbstub command packets handler
with a new infrastructure which should ease extending and adding new
and missing gdb command packets.

version 8 changes:
- Add new command to display the Supported qemu generic query/sets
- kvm: Add API to read/write a MSR
- Add new commands specific for qemu:
  * Command to swap the memory GDB sees to be the physical memory
  * Commands to read and write a MSR

version 7 changes:
- Fixed few checkpatch complaints
- Feedback from Alex Bennee

version 4-6 changes:
- mostly feedback from Richard Henderson

version 3 changes
- Split the single patch to many individual patches for easier reviewing

version 2 changes
- Code convention fixes

Jon Doron (27):
  gdbstub: Add infrastructure to parse cmd packets
  gdbstub: Implement deatch (D pkt) with new infra
  gdbstub: Implement thread_alive (T pkt) with new infra
  gdbstub: Implement continue (c pkt) with new infra
  gdbstub: Implement continue with signal (C pkt) with new infra
  gdbstub: Implement set_thread (H pkt) with new infra
  gdbstub: Implement insert breakpoint (Z pkt) with new infra
  gdbstub: Implement remove breakpoint (z pkt) with new infra
  gdbstub: Implement set register (P pkt) with new infra
  gdbstub: Implement get register (p pkt) with new infra
  gdbstub: Implement write memory (M pkt) with new infra
  gdbstub: Implement read memory (m pkt) with new infra
  gdbstub: Implement write all registers (G pkt) with new infra
  gdbstub: Implement read all registers (g pkt) with new infra
  gdbstub: Implement file io (F pkt) with new infra
  gdbstub: Implement step (s pkt) with new infra
  gdbstub: Implement v commands with new infra
  gdbstub: Implement generic query (q pkt) with new infra
  gdbstub: Implement generic set (Q pkt) with new infra
  gdbstub: Implement target halted (? pkt) with new infra
  gdbstub: Clear unused variables in gdb_handle_packet
  gdbstub: Implement generic query qemu.Supported
  gdbstub: Implement qemu physical memory mode
  gdbstub: Add another handler for setting qemu.sstep
  kvm: Add API to read/write a CPU MSR value
  gdbstub: Add support to read a MSR for KVM target
  gdbstub: Add support to write a MSR for KVM target

 accel/kvm/kvm-all.c  |   39 +
 gdbstub.c            | 1807 ++++++++++++++++++++++++++++++------------
 include/sysemu/kvm.h |    2 +
 3 files changed, 1359 insertions(+), 489 deletions(-)

-- 
2.20.1
