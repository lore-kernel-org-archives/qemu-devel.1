Received: from eggs.gnu.org ([2001:4830:134:3::10]:56271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyN-0000gp-Rt
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyM-0007tt-Mn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyM-0007sK-9f
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:26 -0400
Received: by mail-wm0-x242.google.com with SMTP id r15-v6so5257341wmc.1
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:38 +0100
Message-Id: <20180615194705.28019-28-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 27/54] tests/tcg: move MIPS specific tests
 into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Yongbok Kim <yongbok.kim@mips.com>

These only need to be built for MIPS guests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.17.1
