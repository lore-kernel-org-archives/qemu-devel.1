Received: from eggs.gnu.org ([209.51.188.92]:35714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlQ-0002MI-R4
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlQ-0001Pv-34
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:22:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DlP-0001Lj-S5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:22:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id j125so3381583wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:21:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 17:21:39 +0000
Message-Id: <20190305172139.32662-13-peter.maydell@linaro.org>
In-Reply-To: <20190305172139.32662-1-peter.maydell@linaro.org>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/12] MAINTAINERS: Add entry for Sphinx
 documentation infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

Add a MAINTAINERS entry for Sphinx documentation infrastructure:
this doesn't cover actual content, only the machinery we use to
build the docs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5040d9dfb12..074ad46d473 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2567,3 +2567,9 @@ GIT submodules
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: scripts/git-submodule.sh
+
+Sphinx documentation configuration and build machinery
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: docs/conf.py
+F: docs/*/conf.py
-- 
2.20.1
