Received: from eggs.gnu.org ([2001:4830:134:3::10]:37008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnb-0005qX-ON
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOmnZ-0003mb-Ca
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:07 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:33729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOmnZ-0003mH-4X
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:21:05 -0400
Received: by mail-wm0-x22b.google.com with SMTP id z6-v6so5932796wma.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:21:05 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Jun 2018 17:20:55 +0100
Message-Id: <20180601162101.895-2-alex.bennee@linaro.org>
In-Reply-To: <20180601162101.895-1-alex.bennee@linaro.org>
References: <20180601162101.895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/7] .travis.yml: disable linux-user build for
 gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Currently the default testing doesn't exercise the linux-user builds
so there is no point spending time building them. We may want to
enable a separate gcov build once linux-user testing is re-enabled
although it's likely to report very low coverage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
