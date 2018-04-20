Received: from eggs.gnu.org ([2001:4830:134:3::10]:54377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9NsP-0004YB-9Y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f9NsM-00072Y-7h
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f9NsM-00072E-2U
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:42:22 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Apr 2018 12:42:09 +0800
Message-Id: <20180420044212.28765-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] qemu-thread: support
 --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>, peterx@redhat.com

v3:
- note down owner for every locking operations [Emilio]
- let Windows use it too [Emilio]
- added two more patches: patch 1 & 3.

Patch 1 generalize some common hooks for qemu-thread implementation
for both POSIX and Windows.

Patch 2 introduces the new debugging facility.

Patch 3 turns on mutex debugging automatically for "--enable-debug". I
suppose most developers are with that so we naturally benefit from it.

Please review.  Thanks.

Peter Xu (3):
  qemu-thread: introduce qemu-thread-common.[ch]
  QemuMutex: support --enable-debug-mutex
  configure: enable debug-mutex if debug enabled

 configure                   | 11 +++++++++++
 include/qemu/thread-posix.h |  4 ++++
 include/qemu/thread-win32.h |  4 ++++
 util/qemu-thread-common.h   | 23 +++++++++++++++++++++++
 util/qemu-thread-common.c   | 38 ++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c    | 17 +++++++----------
 util/qemu-thread-win32.c    | 15 +++++++--------
 util/Makefile.objs          |  4 ++--
 8 files changed, 96 insertions(+), 20 deletions(-)
 create mode 100644 util/qemu-thread-common.h
 create mode 100644 util/qemu-thread-common.c

-- 
2.14.3
