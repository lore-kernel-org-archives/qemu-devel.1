Received: from eggs.gnu.org ([209.51.188.92]:34086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utU-0002sR-Jw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utP-0004wp-0D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:12 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utO-0004vz-P2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id w6so17898515wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:25:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.25.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:25:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:50 +0000
Message-Id: <20190307152450.20340-13-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/12] MAINTAINERS: Add entry for Sphinx
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

Add a MAINTAINERS entry for Sphinx documentation infrastructure:
this doesn't cover actual content, only the machinery we use to
build the docs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190305172139.32662-13-peter.maydell@linaro.org
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
