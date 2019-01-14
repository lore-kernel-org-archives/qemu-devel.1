Received: from eggs.gnu.org ([209.51.188.92]:37501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0007fd-Ml
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0001GC-1B
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:05 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3tI-0001FM-Qu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:04 -0500
Received: by mail-wr1-x434.google.com with SMTP id u4so23286296wrp.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:11:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:29 +0000
Message-Id: <20190114150129.1013-22-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/21] Revert "tests: Disable qht-bench parallel
 test when using gprof"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This reverts commit ce2eefd7c21697fee87a0686353de881081d22c6. The
underlying cause was fixed with eb4f8e100f.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 4ea3f14883..f59d484f7a 100755
--- a/configure
+++ b/configure
@@ -7487,7 +7487,6 @@ alpha)
 esac
 
 if test "$gprof" = "yes" ; then
-  echo "CONFIG_GPROF=y" >> $config_host_mak
   echo "TARGET_GPROF=y" >> $config_target_mak
   if test "$target_linux_user" = "yes" ; then
     cflags="-p $cflags"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 601ef4f64c..f403a6571d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -88,8 +88,7 @@ check-unit-y += tests/test-rcu-simpleq$(EXESUF)
 check-unit-y += tests/test-rcu-tailq$(EXESUF)
 check-unit-y += tests/test-qdist$(EXESUF)
 check-unit-y += tests/test-qht$(EXESUF)
-# FIXME: {test-qht-par + gprof} often break on Travis CI
-check-unit-$(call lnot,$(CONFIG_GPROF)) += tests/test-qht-par$(EXESUF)
+check-unit-y += tests/test-qht-par$(EXESUF)
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
 check-unit-y += tests/test-qdev-global-props$(EXESUF)
-- 
2.17.1
