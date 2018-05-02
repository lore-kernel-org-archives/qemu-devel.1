Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvrF-00050H-8s
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvrC-0003qV-GG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:01 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvrC-0003qB-9j
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:47:58 -0400
Received: by mail-pf0-x243.google.com with SMTP id a14so12420806pfi.1
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:47:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 10:47:49 -0700
Message-Id: <20180502174753.16133-2-richard.henderson@linaro.org>
In-Reply-To: <20180502174753.16133-1-richard.henderson@linaro.org>
References: <20180502174753.16133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/5] tcg: Document INDEX_mul[us]h_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/README | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/README b/tcg/README
index bb2ea5121b..a5237a9edb 100644
--- a/tcg/README
+++ b/tcg/README
@@ -431,6 +431,14 @@ double-word product T0.  The later is returned in two single-word outputs.
 
 Similar to mulu2, except the two inputs T1 and T2 are signed.
 
+* mulsh_i32/i64 t0, t1, t2
+* muluh_i32/i64 t0, t1, t2
+
+Provide the high part of a signed or unsigned multiply, respectively.
+If mulu2/muls2 are not provided by the backend, the tcg-op generator
+can obtain the same results can be obtained by emitting a pair of
+opcodes, mul+muluh/mulsh.
+
 ********* Memory Barrier support
 
 * mb <$arg>
-- 
2.14.3
