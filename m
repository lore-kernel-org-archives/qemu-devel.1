Received: from eggs.gnu.org ([2001:4830:134:3::10]:48280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYH-0003n1-FI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYG-0008OB-LA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:25 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFYG-0008MT-Ek
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:24 -0500
Received: by mail-wr0-x243.google.com with SMTP id u49so14534443wrc.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:12 +0000
Message-Id: <20180223154613.2096-8-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 7/8] contrib/run_risu.sh: add a visual cue
 for a clean-run
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

It saves you from having to check the status code or wonder if the
errors just scrolled off your screen.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/run_risu.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/run_risu.sh b/contrib/run_risu.sh
index 2d1897a..fc69d83 100755
--- a/contrib/run_risu.sh
+++ b/contrib/run_risu.sh
@@ -61,6 +61,8 @@ if test ${#failed[@]} -gt 0; then
     for f in "${failed[@]}"; do
         echo "$f"
     done
+else
+    echo "No Failures ;-)"
 fi
 
 exit ${#failed[@]}
-- 
2.15.1
