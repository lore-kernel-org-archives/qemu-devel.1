Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywg-0008Sc-90
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywd-00020e-19
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:10 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywc-00020L-Rf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:06 -0400
Received: by mail-wm0-x244.google.com with SMTP id v131-v6so27676355wma.1
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:07:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:55 +0100
Message-Id: <20180530110655.22022-9-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 8/8] tests/Makefile: mark flakey tests
 (!UPSTREAM)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a bookmarking commit to keep track of the failures I'm
currently seeing in Travis. They are currently:

1. test-aio

GTESTER tests/test-thread-pool
**
ERROR:tests/test-aio.c:501:test_timer_schedule: assertion failed: (aio_poll(ctx, true))
GTester: last random seed: R02S66126aca97f9606b33e5d7be7fc9b625
make: *** [check-tests/test-aio] Error 1
make: *** Waiting for unfinished jobs....

Last discussion @ 20180525091724.GC14757@stefanha-x1.localdomain

  - rcutorture

[AWAITING EXAMPLE]

I suspect it is load that causes the problems but they really need to
be fixed properly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b499ba1813..8ff4ab9e27 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -76,7 +76,9 @@ gcov-files-test-coroutine-y = coroutine-$(CONFIG_COROUTINE_BACKEND).c
 check-unit-y += tests/test-visitor-serialization$(EXESUF)
 check-unit-y += tests/test-iov$(EXESUF)
 gcov-files-test-iov-y = util/iov.c
+# start: flakey
 check-unit-y += tests/test-aio$(EXESUF)
+# end: flakey
 gcov-files-test-aio-y = util/async.c util/qemu-timer.o
 gcov-files-test-aio-$(CONFIG_WIN32) += util/aio-win32.c
 gcov-files-test-aio-$(CONFIG_POSIX) += util/aio-posix.c
@@ -110,7 +112,9 @@ gcov-files-test-mul64-y = util/host-utils.c
 check-unit-y += tests/test-int128$(EXESUF)
 # all code tested by test-int128 is inside int128.h
 gcov-files-test-int128-y =
+# start: flakey
 check-unit-y += tests/rcutorture$(EXESUF)
+# end: flakey
 gcov-files-rcutorture-y = util/rcu.c
 check-unit-y += tests/test-rcu-list$(EXESUF)
 gcov-files-test-rcu-list-y = util/rcu.c
-- 
2.17.0
