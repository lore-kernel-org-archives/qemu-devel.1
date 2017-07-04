Received: from eggs.gnu.org ([2001:4830:134:3::10]:35832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7n-0008G2-Hi
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7m-0001Ch-OM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:23 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7m-0001Bx-IL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:22 -0400
Received: by mail-wr0-x234.google.com with SMTP id 77so250282273wrb.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:57 +0100
Message-Id: <20170704144859.17644-10-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 09/11] aarch64.risu: remove duplicate
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
 aarch64.risu | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index bfca45f..609021a 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2130,6 +2130,8 @@ SQDMULL_S3D A64_V 0 1 U 11110 size:2 1 rm:5 1101 00 rn:5 rd:5
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15      11 10  9    5   4    0
 #  0  1 U   1  1  1  1  0  size  1 [  Rm  ] [ opcode ]  1 [  Rn  ] [  Rd  ]
 #
+@AdvSIMDScalar3Same
+
 SQADD    A64_V   01 0 11110 size:2 1 rm:5 00001 1 rn:5 rd:5
 SQSUB    A64_V   01 0 11110 size:2 1 rm:5 00101 1 rn:5 rd:5
 CMGT     A64_V   01 0 11110 size:2 1 rm:5 00110 1 rn:5 rd:5
@@ -2167,28 +2169,7 @@ FCMGT    A64_V   01 1 11110 1 size:1 1 rm:5 11100 1 rn:5 rd:5
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
+@
 
 # C3.6.12 AdvSIMD scalar 2reg misc
 CMGTzero A64_V      01 0 11110 size:2 10000 01000 10 rn:5 rd:5
-- 
2.13.0
