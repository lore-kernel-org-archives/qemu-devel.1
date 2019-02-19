Received: from eggs.gnu.org ([209.51.188.92]:49510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydt-0005UP-Ff
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydq-00079i-0F
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:31 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydk-00075M-CO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:27 -0500
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so16416845ljk.3
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:16 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:58 -0800
Message-Id: <20190219061111.10231-11-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 10/23] tests/tcg/xtensa: add straightforward
 conditionals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Make tests for optional instruction groups conditional on the presence
of corresponding options in the config.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_clamps.S | 4 ++++
 tests/tcg/xtensa/test_loop.S   | 4 ++++
 tests/tcg/xtensa/test_mac16.S  | 4 ++++
 tests/tcg/xtensa/test_max.S    | 4 ++++
 tests/tcg/xtensa/test_min.S    | 4 ++++
 tests/tcg/xtensa/test_mul16.S  | 4 ++++
 tests/tcg/xtensa/test_mul32.S  | 4 ++++
 tests/tcg/xtensa/test_nsa.S    | 4 ++++
 tests/tcg/xtensa/test_quo.S    | 4 ++++
 tests/tcg/xtensa/test_rem.S    | 4 ++++
 tests/tcg/xtensa/test_rst0.S   | 8 ++++++++
 tests/tcg/xtensa/test_sext.S   | 4 ++++
 12 files changed, 52 insertions(+)

diff --git a/tests/tcg/xtensa/test_clamps.S b/tests/tcg/xtensa/test_clamps.S
index 3efabfd9d3d9..d9b2c38ac1d6 100644
--- a/tests/tcg/xtensa/test_clamps.S
+++ b/tests/tcg/xtensa/test_clamps.S
@@ -2,6 +2,8 @@
 
 test_suite clamps
 
+#if XCHAL_HAVE_CLAMPS
+
 test clamps
     movi    a2, 0
     movi    a3, 0
@@ -39,4 +41,6 @@ test clamps
     assert  eq, a3, a2
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_loop.S b/tests/tcg/xtensa/test_loop.S
index 5755578d0191..0cfd8661ea0e 100644
--- a/tests/tcg/xtensa/test_loop.S
+++ b/tests/tcg/xtensa/test_loop.S
@@ -2,6 +2,8 @@
 
 test_suite loop
 
+#if XCHAL_HAVE_LOOPS
+
 test loop
     movi    a2, 0
     movi    a3, 5
@@ -160,4 +162,6 @@ test loopgtz
 1:
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_mac16.S b/tests/tcg/xtensa/test_mac16.S
index 512025d84291..ee0cedd2ae5d 100644
--- a/tests/tcg/xtensa/test_mac16.S
+++ b/tests/tcg/xtensa/test_mac16.S
@@ -2,6 +2,8 @@
 
 test_suite mac16
 
+#if XCHAL_HAVE_MAC16
+
 #define ext16(v) (((v) & 0xffff) | (((v) & 0x8000) * 0x1ffffffe))
 #define mul16(a, b) ((ext16(a) * ext16(b)))
 
@@ -240,4 +242,6 @@ test mula_dd_lddec
 .text
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_max.S b/tests/tcg/xtensa/test_max.S
index 3caa207ea5ec..f349d578e3bb 100644
--- a/tests/tcg/xtensa/test_max.S
+++ b/tests/tcg/xtensa/test_max.S
@@ -2,6 +2,8 @@
 
 test_suite max
 
+#if XCHAL_HAVE_MINMAX
+
 test max
     movi    a2, 0xffffffff
     movi    a3, 1
@@ -78,4 +80,6 @@ test maxu
     assert  eq, a3, a4
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_min.S b/tests/tcg/xtensa/test_min.S
index 551cf591e54e..89ee10334f62 100644
--- a/tests/tcg/xtensa/test_min.S
+++ b/tests/tcg/xtensa/test_min.S
@@ -2,6 +2,8 @@
 
 test_suite min
 
+#if XCHAL_HAVE_MINMAX
+
 test min
     movi    a2, 0xffffffff
     movi    a3, 1
@@ -78,4 +80,6 @@ test minu
     assert  eq, a3, a4
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_mul16.S b/tests/tcg/xtensa/test_mul16.S
index 98fa7042b504..32507f7f1ef1 100644
--- a/tests/tcg/xtensa/test_mul16.S
+++ b/tests/tcg/xtensa/test_mul16.S
@@ -2,6 +2,8 @@
 
 test_suite mul16
 
+#if XCHAL_HAVE_MUL16
+
 test mul16u_pp
     movi    a2, 0x137f5a5a
     mov     a3, a2
@@ -80,4 +82,6 @@ test mul16s_nn
     assert  eq, a3, a6
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_mul32.S b/tests/tcg/xtensa/test_mul32.S
index b288ead9f6cb..862d45abcec0 100644
--- a/tests/tcg/xtensa/test_mul32.S
+++ b/tests/tcg/xtensa/test_mul32.S
@@ -2,6 +2,8 @@
 
 test_suite mul32
 
+#if XCHAL_HAVE_MUL32
+
 test mull
     movi    a2, 0x137f5a5a
     mov     a3, a2
@@ -15,6 +17,8 @@ test mull
     assert  eq, a3, a6
 test_end
 
+#endif
+
 /* unfortunately dc232b doesn't have muluh/mulsh*/
 
 test_suite_end
diff --git a/tests/tcg/xtensa/test_nsa.S b/tests/tcg/xtensa/test_nsa.S
index 479b2e2429f5..0af7d1f50d56 100644
--- a/tests/tcg/xtensa/test_nsa.S
+++ b/tests/tcg/xtensa/test_nsa.S
@@ -2,6 +2,8 @@
 
 test_suite nsa
 
+#if XCHAL_HAVE_NSA
+
 test nsa
     movi    a2, 0
     movi    a3, 31
@@ -56,4 +58,6 @@ test nsau
     assert  eq, a3, a2
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_quo.S b/tests/tcg/xtensa/test_quo.S
index 5b3ae383d0cd..32886b913be6 100644
--- a/tests/tcg/xtensa/test_quo.S
+++ b/tests/tcg/xtensa/test_quo.S
@@ -2,6 +2,8 @@
 
 test_suite quo
 
+#if XCHAL_HAVE_DIV32
+
 test quou_pp
     movi    a2, 0x5a5a137f
     mov     a3, a2
@@ -144,4 +146,6 @@ test quos_exc
     assert  eq, a2, a3
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_rem.S b/tests/tcg/xtensa/test_rem.S
index 6357e520d979..0b96bb3390ab 100644
--- a/tests/tcg/xtensa/test_rem.S
+++ b/tests/tcg/xtensa/test_rem.S
@@ -2,6 +2,8 @@
 
 test_suite rem
 
+#if XCHAL_HAVE_DIV32
+
 test remu_pp
     movi    a2, 0x5a5a137f
     mov     a3, a2
@@ -144,4 +146,6 @@ test rems_exc
     assert  eq, a2, a3
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_rst0.S b/tests/tcg/xtensa/test_rst0.S
index a73366b1203a..143e90b401ec 100644
--- a/tests/tcg/xtensa/test_rst0.S
+++ b/tests/tcg/xtensa/test_rst0.S
@@ -54,6 +54,8 @@ test add
     assert  eq, a4, a6
 test_end
 
+#if XCHAL_HAVE_ADDX
+
 test addx2
     movi    a2, 0x137fa5a5
     mov     a3, a2
@@ -93,6 +95,8 @@ test addx8
     assert  eq, a4, a6
 test_end
 
+#endif
+
 test sub
     movi    a2, 0x137fa5a5
     mov     a3, a2
@@ -106,6 +110,8 @@ test sub
     assert  eq, a4, a6
 test_end
 
+#if XCHAL_HAVE_ADDX
+
 test subx2
     movi    a2, 0x137fa5a5
     mov     a3, a2
@@ -145,4 +151,6 @@ test subx8
     assert  eq, a4, a6
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_sext.S b/tests/tcg/xtensa/test_sext.S
index 087a6333a434..483d2176e421 100644
--- a/tests/tcg/xtensa/test_sext.S
+++ b/tests/tcg/xtensa/test_sext.S
@@ -2,6 +2,8 @@
 
 test_suite sext
 
+#if XCHAL_HAVE_SEXT
+
 test sext
     movi    a2, 0xffffff5a
     movi    a3, 0x0000005a
@@ -66,4 +68,6 @@ test sext_same_rs
     assert  eq, a3, a2
 test_end
 
+#endif
+
 test_suite_end
-- 
2.11.0
