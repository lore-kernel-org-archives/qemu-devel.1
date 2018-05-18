Received: from eggs.gnu.org ([2001:4830:134:3::10]:36658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJbTK-0004ab-Bm
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJbTH-0001gJ-RO
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:46 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJbTH-0001ea-L7
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:14:43 -0400
Received: by mail-wr0-x236.google.com with SMTP id p4-v6so8434206wrh.3
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 02:14:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 18 May 2018 10:14:39 +0100
Message-Id: <20180518091440.1559-2-alex.bennee@linaro.org>
In-Reply-To: <20180518091440.1559-1-alex.bennee@linaro.org>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/2] .travis.yml: disable linux-user build
 for gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Currently the default testing doesn't exercise the linux-user builds
so there is no point spending time building them. We may want to
enable a separate gcov build once linux-user testing is re-enabled
although it's likely to report very low coverage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c1e99237b2..aa83e9aed7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,7 +74,7 @@ matrix:
     - env: CONFIG=""
       compiler: clang
     # gprof/gcov are GCC features
-    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
+    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --disable-linux-user"
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-- 
2.17.0
