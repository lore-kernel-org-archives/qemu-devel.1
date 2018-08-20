Received: from eggs.gnu.org ([2001:4830:134:3::10]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnw-0006ve-RK
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlnp-00068Z-A8
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frlnm-00065o-Jp
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:09:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Aug 2018 17:08:59 +0200
Message-Id: <20180820150903.1224-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] cpus: improve seqlock usage for
 timers_state, allow cpu_get_ticks out of BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>

This should help in enabling MTTCG for x86.

Paolo

Paolo Bonzini (4):
  cpus: protect all icount computation with seqlock
  seqlock: add QemuLockable support
  cpus: protect TimerState writes with a spinlock
  cpus: allow cpu_get_ticks out of BQL

 cpus.c                 | 174 +++++++++++++++++++++++++----------------
 include/qemu/seqlock.h |  20 +++++
 2 files changed, 128 insertions(+), 66 deletions(-)

-- 
2.17.1
