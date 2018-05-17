Received: from eggs.gnu.org ([2001:4830:134:3::10]:51020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN0B-0006PL-DB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN09-0003c5-B7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:43 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN09-0003bl-4j
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:41 -0400
Received: by mail-wm0-x229.google.com with SMTP id x12-v6so456079wmc.0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:47:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:47:06 +0100
Message-Id: <20180517174718.10107-38-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 37/49] tests/tcg: enable building for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Currently this just enables building the multiarch tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/ppc64le/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tests/tcg/ppc64le/Makefile.include

diff --git a/tests/tcg/ppc64le/Makefile.include b/tests/tcg/ppc64le/Makefile.include
new file mode 100644
index 0000000000..d71cfc9aa7
--- /dev/null
+++ b/tests/tcg/ppc64le/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-ppc64el-cross
+DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
-- 
2.17.0
