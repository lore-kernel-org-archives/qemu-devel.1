Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwW-0000aW-KC
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwT-00070W-F5
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:04 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9XwT-0006zx-8G
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id y83so23681757wmc.4
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:01 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:39 +0000
Message-Id: <20171031145444.13766-3-alex.bennee@linaro.org>
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 2/7] aarch64.risu: remove duplicate
 AdvSIMD Scalar 3 same block
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

A chunk of the AArch64 definitions repeat themselves. Clean that up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 aarch64.risu | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index 5e7ec59..c9f24cd 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2165,28 +2165,6 @@ FCMGT    A64_V   01 1 11110 1 size:1 1 rm:5 11100 1 rn:5 rd:5
 FACGT    A64_V   01 1 11110 1 size:1 1 rm:5 11101 1 rn:5 rd:5 \
 !constraints { $size != 11; }
 
-CMTST    A64_v   01 0 11110 size:2 1 rm:5 10001 1 rn:5 rd:5
-SQDMULH  A64_v   01 0 11110 size:2 1 rm:5 10110 1 rn:5 rd:5
-FMULX    A64_v   01 0 11110 0 size:1 1 rm:5 11011 1 rn:5 rd:5
-FCMEQ    A64_v   01 0 11110 0 size:1 1 rm:5 11100 1 rn:5 rd:5
-FRECPS   A64_v   01 0 11110 0 size:1 1 rm:5 11111 1 rn:5 rd:5
-FRSQRTS  A64_v   01 0 11110 1 size:1 1 rm:5 11111 1 rn:5 rd:5
-UQADD    A64_v   01 1 11110 size:2 1 rm:5 00001 1 rn:5 rd:5
-UQSUB    A64_v   01 1 11110 size:2 1 rm:5 00101 1 rn:5 rd:5
-CMHI     A64_v   01 1 11110 size:2 1 rm:5 00110 1 rn:5 rd:5
-CMHS     A64_v   01 1 11110 size:2 1 rm:5 00111 1 rn:5 rd:5
-USHL     A64_v   01 1 11110 size:2 1 rm:5 01000 1 rn:5 rd:5
-UQSHL    A64_v   01 1 11110 size:2 1 rm:5 01001 1 rn:5 rd:5
-URSHL    A64_v   01 1 11110 size:2 1 rm:5 01010 1 rn:5 rd:5
-UQRSHL   A64_v   01 1 11110 size:2 1 rm:5 01011 1 rn:5 rd:5
-SUBv     A64_v   01 1 11110 size:2 1 rm:5 10000 1 rn:5 rd:5
-CMEQ     A64_v   01 1 11110 size:2 1 rm:5 10001 1 rn:5 rd:5
-SQRDMULH A64_v   01 1 11110 size:2 1 rm:5 10110 1 rn:5 rd:5
-FCMGE    A64_v   01 1 11110 0 size:1 1 rm:5 11100 1 rn:5 rd:5
-FACGE    A64_v   01 1 11110 0 size:1 1 rm:5 11101 1 rn:5 rd:5
-FABD     A64_v   01 1 11110 1 size:1 1 rm:5 11010 1 rn:5 rd:5
-FCMGT    A64_v   01 1 11110 1 size:1 1 rm:5 11100 1 rn:5 rd:5
-FACGT    A64_v   01 1 11110 1 size:1 1 rm:5 11101 1 rn:5 rd:5
 
 # C3.6.12 AdvSIMD scalar 2reg misc
 CMGTzero A64_V      01 0 11110 size:2 10000 01000 10 rn:5 rd:5
-- 
2.14.2
