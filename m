Received: from eggs.gnu.org ([2001:4830:134:3::10]:48243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYG-0003l5-5A
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYF-0008L5-8M
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:24 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFYF-0008JM-0a
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:23 -0500
Received: by mail-wr0-x242.google.com with SMTP id f14so14531874wre.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:11 +0000
Message-Id: <20180223154613.2096-7-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 6/8] contrib/run_risu.sh: don't set -e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As the script is meant to summarise the results at the end it doesn't
make sense to bail out at the first error.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/run_risu.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/run_risu.sh b/contrib/run_risu.sh
index 63649dd..2d1897a 100755
--- a/contrib/run_risu.sh
+++ b/contrib/run_risu.sh
@@ -17,8 +17,6 @@
 #   (optional) export RISU=/path/to/risu
 #   ./run_risu.sh  ./testcases.aarch64/*.bin
 
-set -e
-
 passed=()
 failed=()
 missing=()
-- 
2.15.1
