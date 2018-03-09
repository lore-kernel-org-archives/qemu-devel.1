Received: from eggs.gnu.org ([2001:4830:134:3::10]:47259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5Y-0008E5-UG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euI5V-0003oh-PR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1euI5V-0003nw-K6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:29:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Mar 2018 14:29:18 +0100
Message-Id: <20180309132922.24211-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Optionally use membarrier system call for
 RCU
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

I didn't have time to check whether it improves performance (not
too likely, since QEMU tends to have pretty long RCU critical
sections), but it cannot hurt either. :)

For microbenchmark results, see patch 4.

Paolo


Paolo Bonzini (4):
  rcutorture: remove synchronize_rcu from readers
  rcu: make memory barriers more explicit
  membarrier: introduce qemu/sys_membarrier.h
  membarrier: add --enable-membarrier

 configure                     | 41 ++++++++++++++++++++++++++++++++++-
 include/qemu/rcu.h            | 16 ++++++++++++--
 include/qemu/sys_membarrier.h | 27 +++++++++++++++++++++++
 tests/rcutorture.c            |  4 ---
 util/Makefile.objs            |  1 +
 util/rcu.c                    | 15 +++++++++----
 util/sys_membarrier.c         | 50 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 143 insertions(+), 11 deletions(-)
 create mode 100644 include/qemu/sys_membarrier.h
 create mode 100644 util/sys_membarrier.c

-- 
2.14.3
