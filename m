Received: from eggs.gnu.org ([2001:4830:134:3::10]:43294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5siA-0004Di-L2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5si7-0000h9-Ez
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5si7-0000h3-9x
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:49:19 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Apr 2018 20:49:11 +0800
Message-Id: <20180410124913.10832-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-thread: allow cur_mon be per thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This should be for 2.13.  But I'd like to get early review comments
too if there is any.

Now cur_mon is still only be accessed by the main thread.  So we don't
even need per-thread cur_mon.  However after more commands become OOB
compatible, cur_mon can be accessed by more than main thread now.  The
major user should be the monitor IOThread.  This series tries to let
cur_mon be per-thread, so that we can be well-prepared.

The first patch is a cleanup.  The second patch does the idea.

Any early review comments would be welcomed.  Thanks,

Peter Xu (2):
  qemu-thread: always keep the posix wrapper layer
  qemu-thread: let cur_mon be per-thread

 include/monitor/monitor.h   |  2 +-
 include/qemu/thread-win32.h |  1 +
 monitor.c                   |  2 +-
 stubs/monitor.c             |  2 +-
 tests/test-util-sockets.c   |  2 +-
 util/qemu-thread-posix.c    | 39 +++++++++++++++++++--------------------
 util/qemu-thread-win32.c    |  6 ++++++
 7 files changed, 30 insertions(+), 24 deletions(-)

-- 
2.14.3
