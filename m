Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJbTK-0004aZ-BD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJbTJ-0001iI-A5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:46 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJbTJ-0001h5-2w
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:45 -0400
Received: by mail-wr0-x243.google.com with SMTP id x9-v6so5554797wrl.13
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 02:14:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 18 May 2018 10:14:40 +0100
Message-Id: <20180518091440.1559-3-alex.bennee@linaro.org>
In-Reply-To: <20180518091440.1559-1-alex.bennee@linaro.org>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following tests keep showing up in failed Travis runs:

  - test-aio
  - rcutorture
  - tpm-crb-test
  - tpm-tis-test

I suspect it is load that causes the problems but they really need to
be fixed properly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2..861bc395ee 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -76,7 +76,7 @@ gcov-files-test-coroutine-y = coroutine-$(CONFIG_COROUTINE_BACKEND).c
 check-unit-y += tests/test-visitor-serialization$(EXESUF)
 check-unit-y += tests/test-iov$(EXESUF)
 gcov-files-test-iov-y = util/iov.c
-check-unit-y += tests/test-aio$(EXESUF)
+#check-unit-y += tests/test-aio$(EXESUF)
 gcov-files-test-aio-y = util/async.c util/qemu-timer.o
 gcov-files-test-aio-$(CONFIG_WIN32) += util/aio-win32.c
 gcov-files-test-aio-$(CONFIG_POSIX) += util/aio-posix.c
@@ -110,7 +110,7 @@ gcov-files-test-mul64-y = util/host-utils.c
 check-unit-y += tests/test-int128$(EXESUF)
 # all code tested by test-int128 is inside int128.h
 gcov-files-test-int128-y =
-check-unit-y += tests/rcutorture$(EXESUF)
+#check-unit-y += tests/rcutorture$(EXESUF)
 gcov-files-rcutorture-y = util/rcu.c
 check-unit-y += tests/test-rcu-list$(EXESUF)
 gcov-files-test-rcu-list-y = util/rcu.c
@@ -297,8 +297,8 @@ check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EX
 ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
 check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
 endif
-check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-test$(EXESUF)
+#check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-test$(EXESUF)
+#check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
-- 
2.17.0
