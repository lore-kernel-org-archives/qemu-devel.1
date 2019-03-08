Received: from eggs.gnu.org ([209.51.188.92]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0Z-0004PY-2o
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G0W-0002ih-DC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:55 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2G0W-0002XY-5L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:57:52 -0500
Received: by mail-wm1-x342.google.com with SMTP id j125so12547102wmj.1
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:57:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Mar 2019 13:57:43 +0000
Message-Id: <20190308135744.6480-3-peter.maydell@linaro.org>
In-Reply-To: <20190308135744.6480-1-peter.maydell@linaro.org>
References: <20190308135744.6480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] Makefile: Fix 'make distclean'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

We forgot the '-r' option on the rm command to clean up the
Sphinx .doctrees working directory, which meant that
"make distclean" fails:
 rm: cannot remove '.doctrees': Is a directory

Add the missing option.

Fixes: 5f71eac06e15b9a3fa1134d446f ("Makefile, configure: Support building rST documentation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0194ef7fa55..9fd7f3f9bfb 100644
--- a/Makefile
+++ b/Makefile
@@ -691,7 +691,7 @@ distclean: clean
 	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 	rm -f docs/qemu-block-drivers.7
 	rm -f docs/qemu-cpu-models.7
-	rm -f .doctrees
+	rm -rf .doctrees
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
 	for d in $(TARGET_DIRS); do \
-- 
2.20.1
