Received: from eggs.gnu.org ([209.51.188.92]:46633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8p-0001PO-Mx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8o-00007y-Fx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDi8o-000075-8F
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id f6so8513847pgs.8
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 21:13:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Apr 2019 18:13:37 -1000
Message-Id: <20190409041337.23602-3-richard.henderson@linaro.org>
In-Reply-To: <20190409041337.23602-1-richard.henderson@linaro.org>
References: <20190409041337.23602-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] HACK: Test avx2 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jan.bobek@gmail.com

In order to not be a hack, we'd have to test whether avx2 exists.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 test_i386.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/test_i386.S b/test_i386.S
index 05344d7..55815fe 100644
--- a/test_i386.S
+++ b/test_i386.S
@@ -23,24 +23,24 @@
 	add	$2f-1b, BASE
 #endif
 
-	movdqa	0(BASE), %xmm0
-	movdqa	1*16(BASE), %xmm1
-	movdqa	2*16(BASE), %xmm2
-	movdqa	3*16(BASE), %xmm3
-	movdqa	4*16(BASE), %xmm4
-	movdqa	5*16(BASE), %xmm5
-	movdqa	6*16(BASE), %xmm6
-	movdqa	7*16(BASE), %xmm7
+	vmovdqa	0(BASE), %ymm0
+	vmovdqa	1*32(BASE), %ymm1
+	vmovdqa	2*32(BASE), %ymm2
+	vmovdqa	3*32(BASE), %ymm3
+	vmovdqa	4*32(BASE), %ymm4
+	vmovdqa	5*32(BASE), %ymm5
+	vmovdqa	6*32(BASE), %ymm6
+	vmovdqa	7*32(BASE), %ymm7
 
 #ifdef __x86_64__
-	movdqa	8*16(BASE), %xmm8
-	movdqa	9*16(BASE), %xmm9
-	movdqa	10*16(BASE), %xmm10
-	movdqa	11*16(BASE), %xmm11
-	movdqa	12*16(BASE), %xmm12
-	movdqa	13*16(BASE), %xmm13
-	movdqa	14*16(BASE), %xmm14
-	movdqa	15*16(BASE), %xmm15
+	vmovdqa	8*32(BASE), %ymm8
+	vmovdqa	9*32(BASE), %ymm9
+	vmovdqa	10*32(BASE), %ymm10
+	vmovdqa	11*32(BASE), %ymm11
+	vmovdqa	12*32(BASE), %ymm12
+	vmovdqa	13*32(BASE), %ymm13
+	vmovdqa	14*32(BASE), %ymm14
+	vmovdqa	15*32(BASE), %ymm15
 #endif
 
 	xor	%eax, %eax
@@ -75,6 +75,6 @@
 2:
 	.set	i, 0
 	.rept	256
-	.byte	i
+	.byte	i, i, i, i
 	.set	i, i + 1
 	.endr
-- 
2.17.1
