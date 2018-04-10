Received: from eggs.gnu.org ([2001:4830:134:3::10]:49816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC8-0004yZ-RZ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC7-0001Hv-US
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:44 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5zC7-0001H6-Nu
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:43 -0400
Received: by mail-wr0-x244.google.com with SMTP id d19so10043137wre.1
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:44:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:14 +0100
Message-Id: <20180410193919.28026-20-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 19/24] tests/tcg: move MIPS specific tests
 into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

These only need to be built for MIPS guests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/README                  | 11 -----------
 tests/tcg/mips/README             |  7 +++++++
 tests/tcg/{ => mips}/hello-mips.c |  0
 3 files changed, 7 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/mips/README
 rename tests/tcg/{ => mips}/hello-mips.c (100%)

diff --git a/tests/tcg/README b/tests/tcg/README
index 625f2326e6..a5643d33e7 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -3,17 +3,6 @@ regression testing. Tests are either multi-arch, meaning they can be
 built for all guest architectures that support linux-user executable,
 or they are architecture specific.
 
-
-
-MIPS
-====
-
-hello-mips
-----------
-
-hello-mipsel
-------------
-
 CRIS
 ====
 The testsuite for CRIS is in tests/tcg/cris.  You can run it
diff --git a/tests/tcg/mips/README b/tests/tcg/mips/README
new file mode 100644
index 0000000000..e5bbc58ec5
--- /dev/null
+++ b/tests/tcg/mips/README
@@ -0,0 +1,7 @@
+MIPS
+====
+
+hello-mips
+----------
+
+A very simple inline assembly, write syscall based hello world
diff --git a/tests/tcg/hello-mips.c b/tests/tcg/mips/hello-mips.c
similarity index 100%
rename from tests/tcg/hello-mips.c
rename to tests/tcg/mips/hello-mips.c
-- 
2.16.2
