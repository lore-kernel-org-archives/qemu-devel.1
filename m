Received: from eggs.gnu.org ([2001:4830:134:3::10]:60714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJf-0006jQ-4U
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJa-0000iv-Bk
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJa-0000hj-5M
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:18 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 126D47F08B
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:16:17 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v2RGGF8p009176
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 12:16:16 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:06 +0200
Message-Id: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Misc fixes for QEMU 2.9.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 08329701199449bde497570dcfdb9c86062baf20:

  qom: Fix regression with 'qom-type' (2017-03-23 17:59:40 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to bed58b4443b001227b953dca80ce76fa76ea0fc1:

  scsi-generic: Fill in opt_xfer_len in INQUIRY reply if it is zero (2017-03-27 17:02:07 +0200)

----------------------------------------------------------------
* MTTCG fix for win32
* virtio-scsi assertion failure
* mem-prealloc coverity fix
* x86 migration revert which requires more thought
* x86 instruction limit (avoids >2 page translation blocks)
* nbd dead code cleanup
* small memory.c logic fix

----------------------------------------------------------------
Andrey Shedel (1):
      win32: replace custom mutex and condition variable with native primitives

Fam Zheng (3):
      virtio-scsi: Make virtio_scsi_acquire/release public
      virtio-scsi: Fix acquire/release in dataplane handlers
      scsi-generic: Fill in opt_xfer_len in INQUIRY reply if it is zero

Jitendra Kolhe (1):
      mem-prealloc: fix sysconf(_SC_NPROCESSORS_ONLN) failure case.

Paolo Bonzini (1):
      Revert "apic: save apic_delivered flag"

Pranith Kumar (1):
      tcg/i386: Check the size of instruction being translated

Stefan Hajnoczi (1):
      nbd: drop unused NBDClientSession.is_unix field

Xu, Anthony (1):
      clear pending status before calling memory commit

 block/nbd-client.h              |   2 -
 block/nbd.c                     |   2 -
 hw/intc/apic_common.c           |  33 ----------
 hw/scsi/scsi-generic.c          |   5 +-
 hw/scsi/virtio-scsi-dataplane.c |  20 ++++--
 hw/scsi/virtio-scsi.c           |  41 +++++-------
 include/hw/i386/apic_internal.h |   2 -
 include/hw/virtio/virtio-scsi.h |  14 +++++
 include/qemu/thread-win32.h     |   7 +--
 memory.c                        |  10 +--
 target/i386/translate.c         |   7 +++
 util/oslib-posix.c              |  16 ++++-
 util/qemu-thread-win32.c        | 136 +++++-----------------------------------
 13 files changed, 86 insertions(+), 209 deletions(-)
-- 
2.9.3
