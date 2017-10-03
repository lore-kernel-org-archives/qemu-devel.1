Received: from eggs.gnu.org ([2001:4830:134:3::10]:42619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUt-00032f-AS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUq-0001xK-OO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:19 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:47691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzKUq-0001wP-H5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:16 -0400
Received: by mail-wm0-x243.google.com with SMTP id t69so15679226wmt.2
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 03:32:16 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	x75sm16293812wme.3.2017.10.03.03.32.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Oct 2017 03:32:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 12:28:35 +0200
Message-Id: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Misc patches for 2017-10-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 346b1215b1e9f7cc6d8fe9fb6f3c2778b890afb6:

  kvmclock: use the updated system_timer_msr (2017-10-02 14:39:51 +0200)

----------------------------------------------------------------
* iothread bugfix (Eduardo)
* Linux headers sync (Dave)
* .gitignore fix (Eric)
* KVM capability check fixes (Greg)
* kvmclock fix (Jim)

----------------------------------------------------------------
Alexey Perevalov (1):
      linux-headers: sync against v4.14-rc1

Eduardo Habkost (1):
      iothread: Make iothread_stop() idempotent

Eric Blake (1):
      scsi: Ignore executable for in-tree builds

Greg Kurz (2):
      kvm: check KVM_CAP_SYNC_MMU with kvm_vm_check_extension()
      kvm: check KVM_CAP_NR_VCPUS with kvm_vm_check_extension()

Jim Somerville (1):
      kvmclock: use the updated system_timer_msr

 .gitignore                                   |  1 +
 accel/kvm/kvm-all.c                          | 51 +++++++++++++++-------------
 accel/stubs/kvm-stub.c                       |  4 +--
 hw/i386/kvm/clock.c                          |  3 +-
 include/standard-headers/asm-x86/hyperv.h    | 19 ++++++++---
 include/standard-headers/linux/pci_regs.h    | 42 +++++++++++++----------
 include/standard-headers/linux/virtio_ring.h |  4 +--
 include/sysemu/kvm.h                         |  2 +-
 iothread.c                                   |  2 +-
 linux-headers/asm-s390/kvm.h                 |  6 ++++
 linux-headers/linux/kvm.h                    |  3 +-
 linux-headers/linux/userfaultfd.h            | 16 ++++++++-
 12 files changed, 98 insertions(+), 55 deletions(-)
-- 
1.8.3.1
