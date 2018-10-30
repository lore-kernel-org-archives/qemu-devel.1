Received: from eggs.gnu.org ([2001:4830:134:3::10]:48218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa28-00082L-V5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa26-0002IO-6h
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa25-0001yK-R9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id l6-v6so13982594wrt.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:14 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g76-v6sm17480094wmd.25.2018.10.30.12.50.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Oct 2018 12:50:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:01 +0100
Message-Id: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/10] Misc patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2e14019d2a37f32ccecd786d8be4e9a70094e7f7:

  lsi53c895a: check message length value is valid (2018-10-30 20:46:25 +0100)

Already all bugfixes except for a single patch by Vitaly.

----------------------------------------------------------------
* icount fix (Clement)
* dumping fixes for non-volatile memory (Marc-André, myself)
* x86 emulation fix (Rudolf)
* recent Hyper-V CPUID flag (Vitaly)
* Q35 doc fix (Daniel)
* lsi fix (Prasad)

----------------------------------------------------------------
Clement Deschamps (1):
      icount: fix deadlock when all cpus are sleeping

Daniel P. Berrangé (1):
      i386: clarify that the Q35 machine type implements a P35 chipset

Marc-André Lureau (3):
      memory: learn about non-volatile memory region
      nvdimm: set non-volatile on the memory region
      memory-mapping: skip non-volatile memory regions in GuestPhysBlockList

Paolo Bonzini (2):
      MAINTAINERS: remove or downgrade myself to reviewer from some subsystems
      scripts/dump-guest-memory: Synchronize with guest_phys_blocks_region_add

Prasad J Pandit (1):
      lsi53c895a: check message length value is valid

Rudolf Marek (1):
      target/i386: Clear RF on SYSCALL instruction

Vitaly Kuznetsov (1):
      x86: hv_evmcs CPU flag support

 MAINTAINERS                  | 13 ++++++-------
 cpus.c                       |  8 ++++++++
 docs/devel/migration.rst     |  1 +
 hw/mem/nvdimm.c              |  1 +
 hw/pci-host/q35.c            | 10 +++++++++-
 hw/scsi/lsi53c895a.c         | 19 +++++++++++++++++--
 include/exec/memory.h        | 25 ++++++++++++++++++++++++
 include/hw/pci/pci_ids.h     |  2 +-
 memory.c                     | 45 ++++++++++++++++++++++++++++++++++----------
 memory_mapping.c             |  3 ++-
 scripts/dump-guest-memory.py |  4 +++-
 target/i386/cpu.c            |  1 +
 target/i386/cpu.h            |  1 +
 target/i386/hyperv-proto.h   |  2 ++
 target/i386/kvm.c            | 30 +++++++++++++++++++++++++++--
 target/i386/seg_helper.c     |  4 ++--
 16 files changed, 142 insertions(+), 27 deletions(-)
-- 
1.8.3.1
