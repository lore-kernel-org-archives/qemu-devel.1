Received: from eggs.gnu.org ([2001:4830:134:3::10]:33227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1eUrCX-0003oq-Qa
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1eUrCU-0000WE-DU
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1eUrCU-0000U1-7R
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:38 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 29 Dec 2017 10:42:04 +0100
Message-Id: <20171229094206.14512-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] pvpanic: implement abort_on_panic option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, mjt@tls.msk.ru, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>

Extend pvpanic and qemu_system_guest_panicked so it's possible to
configure the first to induce an abort() when the Guest panics.

This is specially useful (and mainly intended to be enabled only) when
debugging soft/hard lockups on the Guest OS.

Sergio Lopez (2):
  vl: extend qemu_system_guest_panicked with abort_on_panic
  pvpanic: add PVPANIC_ABORT_PROP

 accel/kvm/kvm-all.c     |  2 +-
 hw/misc/pvpanic.c       | 10 +++++++---
 hw/ppc/spapr_rtas.c     |  2 +-
 include/sysemu/sysemu.h |  3 ++-
 target/s390x/helper.c   |  2 +-
 target/s390x/kvm.c      |  2 +-
 vl.c                    | 10 ++++++++--
 7 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.14.3
