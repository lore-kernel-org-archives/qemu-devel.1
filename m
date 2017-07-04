Received: from eggs.gnu.org ([2001:4830:134:3::10]:35696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7i-0008Di-T7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7i-00017g-2v
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:18 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7h-00016f-R8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:17 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k67so249661502wrc.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:53 +0100
Message-Id: <20170704144859.17644-6-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 05/11] risu.el: derive from text-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As RISU files have copious commentary it seems better to derive from
text-mode so we can access things like spell-checker short cuts ;-)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu.el | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu.el b/risu.el
index dff9337..1875d02 100644
--- a/risu.el
+++ b/risu.el
@@ -39,7 +39,7 @@
 
 ;;; Code
 
-(define-derived-mode risu-mode fundamental-mode "RISU"
+(define-derived-mode risu-mode text-mode "RISU"
   "Major mode for editing RISU control files."
   (set (make-local-variable 'font-lock-defaults) '(risu-font-lock-keywords)))
 
-- 
2.13.0
