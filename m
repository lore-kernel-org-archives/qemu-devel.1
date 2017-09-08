Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPz-0006FX-Oq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPu-0000pX-Ve
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPu-0000ni-QH
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:59 +0800
Message-Id: <20170908091700.14867-7-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 6/7] buildsys: Add "check-tcg" target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

This is merely a thin wrapper of the old "test" target, but in a
consistent form of Makefile structure.

Next patches will actually convert the rules from the old "make test".

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 Makefile                   | 1 +
 tests/Makefile.include     | 1 +
 tests/tcg/Makefile.include | 3 +++
 3 files changed, 5 insertions(+)
 create mode 100644 tests/tcg/Makefile.include

diff --git a/Makefile b/Makefile
index c1e35b1fd0..c44be86cef 100644
--- a/Makefile
+++ b/Makefile
@@ -282,6 +282,7 @@ dummy := $(call unnest-vars,, \
                 trace-obj-y)
 
 include $(SRC_PATH)/tests/Makefile.include
+include $(SRC_PATH)/tests/tcg/Makefile.include
 
 all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index debaf845db..0e22d90640 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -10,6 +10,7 @@ check-help:
 	@echo " make check-speed          Run qobject speed tests"
 	@echo " make check-qapi-schema    Run QAPI schema tests"
 	@echo " make check-block          Run block tests"
+	@echo " make check-tcg            Clean TCG tests"
 	@echo " make check-report.html    Generates an HTML test report"
 	@echo " make check-clean          Clean the tests"
 	@echo
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
new file mode 100644
index 0000000000..e5fea1c8c5
--- /dev/null
+++ b/tests/tcg/Makefile.include
@@ -0,0 +1,3 @@
+
+check-tcg:
+	$(MAKE) -C tests/tcg test
-- 
2.13.5
