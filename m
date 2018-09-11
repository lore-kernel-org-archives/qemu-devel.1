Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJR-0008Rb-N3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJN-0007YP-W4
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzjJN-0007XN-Mg
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id v17-v6so26187548wrr.9
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:06:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Sep 2018 15:06:31 +0100
Message-Id: <20180911140631.18481-5-alex.bennee@linaro.org>
In-Reply-To: <20180911140631.18481-1-alex.bennee@linaro.org>
References: <20180911140631.18481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/4] tests/tcg: add nios2 architecture
 (NEEDS FIXES)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Now we have a docker image with a nios2 compiler we can add the bits
to build our TCG tests.

Current failures:
  testmmap - fails in check_file_fixed_eof_mmaps due to inversion of offset
  linux-test - unimplemented lseek (probably others as well)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/nios2/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tests/tcg/nios2/Makefile.include

diff --git a/tests/tcg/nios2/Makefile.include b/tests/tcg/nios2/Makefile.include
new file mode 100644
index 0000000000..2ab4160435
--- /dev/null
+++ b/tests/tcg/nios2/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=buildroot-nios2-cross
+DOCKER_CROSS_COMPILER=nios2-linux-gcc
-- 
2.17.1
