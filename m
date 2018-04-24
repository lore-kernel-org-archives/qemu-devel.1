Received: from eggs.gnu.org ([2001:4830:134:3::10]:49364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fApvU-000211-M7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 00:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fApvP-0006Uh-OQ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 00:51:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fApvP-0006UQ-Jx
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 00:51:31 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 24 Apr 2018 12:51:08 +0800
Message-Id: <20180424045112.12963-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/4] qemu-thread: support
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

v5:
- init file/line [Emilio]

v4:
- cherrypick Emilio's patch to add "-m" parameter to atomic_add-bench
  tool.
- use inline functions [Emilio]

Micro benchmark result on "taskset -c 0 atomic_add-bench -m":

|--------+---------------------+------------------------|
|        | with --enable-debug | without --enable-debug |
|--------+---------------------+------------------------|
| Before | 20 Mops/s           | 34 Mops/s              |
| After  | 18 Mops/s           | 34 Mops/s              |
|--------+---------------------+------------------------|

Please review.  Thanks.

Emilio G. Cota (1):
  tests/atomic_add-bench: add -m option to use mutexes

Peter Xu (3):
  qemu-thread: introduce qemu-thread-common.h
  QemuMutex: support --enable-debug-mutex
  configure: enable debug-mutex if debug enabled

 configure                   | 11 +++++++++
 include/qemu/thread-posix.h |  4 ++++
 include/qemu/thread-win32.h |  4 ++++
 util/qemu-thread-common.h   | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/atomic_add-bench.c    | 19 ++++++++++++++--
 util/qemu-thread-posix.c    | 19 +++++++---------
 util/qemu-thread-win32.c    | 17 +++++++-------
 7 files changed, 107 insertions(+), 22 deletions(-)
 create mode 100644 util/qemu-thread-common.h

-- 
2.14.3
