Received: from eggs.gnu.org ([209.51.188.92]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSKj-0004mT-0C
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSKh-0002Fs-3n
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:31:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSKd-00029D-EP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:31:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id w17so23426211wrn.12
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:31:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:34 +0000
Message-Id: <20190228202537.4638-14-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/16] tests/tcg/cris: align mul operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

To avoid:

  Error: dangerous MULS/MULU location; give it higher alignment

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/cris/bare/check_mulx.s | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/tcg/cris/bare/check_mulx.s b/tests/tcg/cris/bare/check_mulx.s
index d43241a6f5..a7a1f82a82 100644
--- a/tests/tcg/cris/bare/check_mulx.s
+++ b/tests/tcg/cris/bare/check_mulx.s
@@ -3,6 +3,8 @@
 
  .include "testutils.inc"
  start
+
+ .align 4
  moveq -1,r3
  moveq 2,r4
  muls.d r4,r3
@@ -11,6 +13,7 @@
  move mof,r3
  checkr3 ffffffff
 
+ .align 4
  moveq -1,r3
  moveq 2,r4
  mulu.d r4,r3
@@ -19,6 +22,7 @@
  move mof,r3
  checkr3 1
 
+ .align 4
  moveq 2,r3
  moveq -1,r4
  muls.d r4,r3
@@ -27,6 +31,7 @@
  move mof,r3
  checkr3 ffffffff
 
+ .align 4
  moveq 2,r3
  moveq -1,r4
  mulu.d r4,r3
@@ -98,6 +103,7 @@
  checkr3 1fffe
  move mof,r3
  checkr3 0
+ nop
 
  moveq 2,r3
  move.d 0xffff,r4
@@ -138,6 +144,7 @@
  checkr3 fdbdade2
  move mof,r3
  checkr3 ffffffff
+ nop
 
  move.d 0x5432f789,r4
  move.d 0x78134452,r3
@@ -146,6 +153,7 @@
  checkr3 420fade2
  move mof,r3
  checkr3 0
+ nop
 
  move.d 0xff,r3
  moveq 2,r4
@@ -186,6 +194,7 @@
  checkr3 1
  move mof,r3
  checkr3 0
+ nop
 
  moveq -1,r4
  move.d r4,r3
@@ -194,6 +203,7 @@
  checkr3 fe01
  move mof,r3
  checkr3 0
+ nop
 
  move.d 0xfeda49ff,r4
  move.d r4,r3
@@ -202,6 +212,7 @@
  checkr3 1
  move mof,r3
  checkr3 0
+ nop
 
  move.d 0xfeda49ff,r4
  move.d r4,r3
-- 
2.20.1
