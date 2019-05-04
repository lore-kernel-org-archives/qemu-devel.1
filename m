Received: from eggs.gnu.org ([209.51.188.92]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncE-0008AW-7u
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncD-0004ic-Bj
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMncD-0004hs-5y
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so3978159pfa.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:53:00 -0700
Message-Id: <20190504055300.18426-32-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 31/31] tcg/aarch64: Do not advertise minmax
 for MO_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

The min/max instructions are not available for 64-bit elements.

Fixes: 93f332a50371
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 5684b39e1f..e13960711d 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2332,16 +2332,16 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
-    case INDEX_op_smax_vec:
-    case INDEX_op_smin_vec:
-    case INDEX_op_umax_vec:
-    case INDEX_op_umin_vec:
     case INDEX_op_shlv_vec:
         return 1;
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         return -1;
     case INDEX_op_mul_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return vece < MO_64;
 
     default:
-- 
2.17.1
