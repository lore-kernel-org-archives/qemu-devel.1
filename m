Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW29-00048d-1Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzp-0000oo-Lw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzp-0000oO-FR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id y197so4621953wmd.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:32 +0100
Message-Id: <20190430165234.32272-14-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 13/15] Makefile: fix coverage-report
 reference to BUILD_DIR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Commit 337f2311f actually claimed to do this in the commit log but
didn't actually. Oops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 626a04d305..45dfe1b585 100644
--- a/Makefile
+++ b/Makefile
@@ -992,7 +992,7 @@ $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 %/coverage-report.html:
 	@mkdir -p $*
 	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(BUILD_PATH) \
+		gcovr -r $(SRC_PATH) --object-directory $(BUILD_DIR) \
 		-p --html --html-details -o $@, \
 		"GEN", "coverage-report.html")
 
-- 
2.20.1
