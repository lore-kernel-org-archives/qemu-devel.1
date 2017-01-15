Received: from eggs.gnu.org ([2001:4830:134:3::10]:35316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4m-00069x-Qd
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4l-0002qt-S4
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:56 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4l-0002qg-LW
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:55 -0500
Received: by mail-pg0-x241.google.com with SMTP id 194so3586045pgd.0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:55 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:16 -0800
Message-Id: <1484514617-11726-7-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] target/xtensa: tests: replace hardcoded
 interrupt masks
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

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_timer.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/xtensa/test_timer.S b/tests/tcg/xtensa/test_timer.S
index 9e6012d..844c032 100644
--- a/tests/tcg/xtensa/test_timer.S
+++ b/tests/tcg/xtensa/test_timer.S
@@ -59,7 +59,7 @@ test ccompare0_interrupt
     rsr     a2, interrupt
     assert  eqi, a2, 0
 
-    movi    a2, 0x40
+    movi    a2, 1 << XCHAL_TIMER0_INTERRUPT
     wsr     a2, intenable
     rsil    a2, 0
     loop    a3, 1f
@@ -87,7 +87,7 @@ test ccompare1_interrupt
     rsync
     rsr     a2, interrupt
     assert  eqi, a2, 0
-    movi    a2, 0x400
+    movi    a2, 1 << XCHAL_TIMER1_INTERRUPT
     wsr     a2, intenable
     rsil    a2, 2
     loop    a3, 1f
@@ -113,7 +113,7 @@ test ccompare2_interrupt
     rsync
     rsr     a2, interrupt
     assert  eqi, a2, 0
-    movi    a2, 0x2000
+    movi    a2, 1 << XCHAL_TIMER2_INTERRUPT
     wsr     a2, intenable
     rsil    a2, 4
     loop    a3, 1f
@@ -141,7 +141,7 @@ test ccompare_interrupt_masked
     rsr     a2, interrupt
     assert  eqi, a2, 0
 
-    movi    a2, 0x40
+    movi    a2, 1 << XCHAL_TIMER0_INTERRUPT
     wsr     a2, intenable
     rsil    a2, 0
     loop    a3, 1f
@@ -171,7 +171,7 @@ test ccompare_interrupt_masked_waiti
     rsr     a2, interrupt
     assert  eqi, a2, 0
 
-    movi    a2, 0x40
+    movi    a2, 1 << XCHAL_TIMER0_INTERRUPT
     wsr     a2, intenable
     waiti   0
     test_fail
-- 
2.1.4
