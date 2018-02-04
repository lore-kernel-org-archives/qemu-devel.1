Received: from eggs.gnu.org ([2001:4830:134:3::10]:47367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBer-0004j5-8A
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeq-0004yZ-7z
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:01 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBeq-0004yH-2K
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:00 -0500
Received: by mail-pl0-x242.google.com with SMTP id j19so9379034pll.2
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:25 -0800
Message-Id: <20180204041136.17525-14-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/24] fpu/soft-fp: Add arithmetic macros to
 half.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

These were omitted from upstream glibc for some reason.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/half.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fpu/half.h b/fpu/half.h
index 75a3168a75..d9e1cd5e01 100644
--- a/fpu/half.h
+++ b/fpu/half.h
@@ -159,7 +159,19 @@ union _FP_UNION_H
   _FP_TO_INT_ROUND (H, 1, (r), X, (rsz), (rsg))
 #define FP_FROM_INT_H(X, r, rs, rt)	_FP_FROM_INT (H, 1, X, (r), (rs), rt)
 
-/* HFmode arithmetic is not implemented.  */
+#define FP_ISSIGNAN_H(X)                _FP_ISSIGNAN (H, 1, X)
+#define FP_NEG_H(R, X)                  _FP_NEG (H, 1, R, X)
+#define FP_ADD_H(R, X, Y)               _FP_ADD (H, 1, R, X, Y)
+#define FP_SUB_H(R, X, Y)               _FP_SUB (H, 1, R, X, Y)
+#define FP_MUL_H(R, X, Y)               _FP_MUL (H, 1, R, X, Y)
+#define FP_DIV_H(R, X, Y)               _FP_DIV (H, 1, R, X, Y)
+#define FP_SQRT_H(R, X)                 _FP_SQRT (H, 1, R, X)
+#define _FP_SQRT_MEAT_H(R, S, T, X, Q)  _FP_SQRT_MEAT_1 (R, S, T, X, (Q))
+#define FP_FMA_H(R, X, Y, Z)            _FP_FMA (H, 1, 1, R, X, Y, Z)
+
+#define FP_CMP_H(r, X, Y, un, ex)       _FP_CMP (H, 1, (r), X, Y, (un), (ex))
+#define FP_CMP_EQ_H(r, X, Y, ex)        _FP_CMP_EQ (H, 1, (r), X, Y, (ex))
+#define FP_CMP_UNORD_H(r, X, Y, ex)     _FP_CMP_UNORD (H, 1, (r), X, Y, (ex))
 
 #define _FP_FRAC_HIGH_H(X)	_FP_FRAC_HIGH_1 (X)
 #define _FP_FRAC_HIGH_RAW_H(X)	_FP_FRAC_HIGH_1 (X)
-- 
2.14.3
