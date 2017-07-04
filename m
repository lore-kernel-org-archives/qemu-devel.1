Received: from eggs.gnu.org ([2001:4830:134:3::10]:35736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7j-0008EP-Q6
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7i-00018Y-UA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7i-00017l-OT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:18 -0400
Received: by mail-wm0-x236.google.com with SMTP id 62so198658467wmw.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:54 +0100
Message-Id: <20170704144859.17644-7-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 06/11] risugen: fix bad indent
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risugen b/risugen
index 8b20425..347cf12 100755
--- a/risugen
+++ b/risugen
@@ -262,7 +262,7 @@ Valid options:
                    These REs are applied after the matching pattern which
                    is useful if you want to exclude a specific instruction from
                    a general set you have excluded.
-     --no-fp      : disable floating point: no fp init, randomization etc.
+    --no-fp      : disable floating point: no fp init, randomization etc.
                    Useful to test before support for FP is available.
     --be         : generate instructions in Big-Endian byte order (ppc64 only).
     --help       : print this message
-- 
2.13.0
