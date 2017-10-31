Received: from eggs.gnu.org ([2001:4830:134:3::10]:59283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwW-0000aY-Ka
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwU-00070x-BS
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:51335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9XwU-00070S-2U
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:02 -0400
Received: by mail-wr0-x241.google.com with SMTP id j15so16216175wre.8
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:01 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:41 +0000
Message-Id: <20171031145444.13766-5-alex.bennee@linaro.org>
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 4/7] aarch64.risu: update AdvancedSIMD
 across lanes
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

 - sorted alphabetically
 - aligned the instructions patterns

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 aarch64.risu | 81 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index f3e588b..9667ef7 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -1953,50 +1953,49 @@ ZIP2 A64_V 0 Q:1 001110 size:2 0 rm:5 0 111 10 rn:5 rd:5 \
 # ReservedValue: break the !($size == 3 && $Q == 0) constraint
 ZIP2_RES A64_V 0 0 001110 11 0 rm:5 0 111 10 rn:5 rd:5
 
-# C3.6.4 AdvSIMD across lanes
+# C4-286 AdvSIMD across vector lanes
 # 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16  12 11 10 9  5 4  0
 #  0  Q  U  0  1  1  1  0  size  1  1  0  0  0 opcode  1  0  Rn   Rd
 
-SADDLV A64_V 0 Q:1 0 01110 size:2 11000 00011 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-SADDLV_RES A64_V 0 0 0 01110 10 11000 00011 10 rn:5 rd:5
-
-SMAXV A64_V 0 Q:1 0 01110 size:2 11000 01010 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-SMAXV_RES A64_V 0 0 0 01110 10 11000 01010 10 rn:5 rd:5
-
-SMINV A64_V 0 Q:1 0 01110 size:2 11000 11010 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-SMINV_RES A64_V 0 0 0 01110 10 11000 11010 10 rn:5 rd:5
-
-ADDV A64_V 0 Q:1 0 01110 size:2 11000 11011 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-ADDV_RES A64_V 0 0 0 01110 10 11000 11011 10 rn:5 rd:5
-
-UADDLV A64_V 0 Q:1 1 01110 size:2 11000 00011 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-UADDLV_RES A64_V 0 0 1 01110 10 11000 00011 10 rn:5 rd:5
-
-UMAXV A64_V 0 Q:1 1 01110 size:2 11000 01010 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-UMAXV_RES A64_V 0 0 1 01110 10 11000 01010 10 rn:5 rd:5
-
-UMINV A64_V 0 Q:1 1 01110 size:2 11000 11010 10 rn:5 rd:5 \
-!constraints { $size < 2 || ($size == 2 && $Q == 1); }
-# ReservedValue: break the constraint (size==2) => (Q=1)
-UMINV_RES A64_V 0 0 1 01110 10 11000 11010 10 rn:5 rd:5
-
-FMAXNMV A64_V 0 1 1 01110 00 11000 01100 10 rn:5 rd:5
-FMAXV A64_V 0 1 1 01110 00 11000 01111 10 rn:5 rd:5
-
-FMINNMV A64_V 0 1 1 01110 10 11000 01100 10 rn:5 rd:5
-FMINV A64_V 0 1 1 01110 10 11000 01111 10 rn:5 rd:5
+ADDV         A64_V 0 Q:1 0 01110 s:2 11000 11011 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+ADDV_RES     A64_V 0  0  0 01110  10 11000 11011 10 rn:5 rd:5
+
+FMAXNMV      A64_V 0  1  1 01110  00 11000 01100 10 rn:5 rd:5
+FMAXV        A64_V 0  1  1 01110  00 11000 01111 10 rn:5 rd:5
+FMINNMV      A64_V 0  1  1 01110  10 11000 01100 10 rn:5 rd:5
+FMINV        A64_V 0  1  1 01110  10 11000 01111 10 rn:5 rd:5
+
+SADDLV       A64_V 0 Q:1 0 01110 s:2 11000 00011 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+SADDLV_RES   A64_V 0   0 0 01110  10 11000 00011 10 rn:5 rd:5
+
+SMAXV        A64_V 0 Q:1 0 01110 s:2 11000 01010 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+SMAXV_RES    A64_V 0   0 0 01110  10 11000 01010 10 rn:5 rd:5
+
+SMINV        A64_V 0 Q:1 0 01110 s:2 11000 11010 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+SMINV_RES    A64_V 0   0 0 01110  10 11000 11010 10 rn:5 rd:5
+
+UADDLV       A64_V 0 Q:1 1 01110 s:2 11000 00011 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+UADDLV_RES   A64_V 0   0 1 01110  10 11000 00011 10 rn:5 rd:5
+
+UMAXV        A64_V 0 Q:1 1 01110 s:2 11000 01010 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+UMAXV_RES    A64_V 0   0 1 01110  10 11000 01010 10 rn:5 rd:5
+
+UMINV        A64_V 0 Q:1 1 01110 s:2 11000 11010 10 rn:5 rd:5 \
+!constraints { $s < 2 || ($s == 2 && $Q == 1); }
+# ReservedValue: break the constraint (s==2) => (Q=1)
+UMINV_RES    A64_V 0   0 1 01110  10 11000 11010 10 rn:5 rd:5
 
 # C3.6.5 AdvSIMD copy
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15 14    11 10 9  5 4  0
-- 
2.14.2
