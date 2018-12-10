Received: from eggs.gnu.org ([2001:4830:134:3::10]:43340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU8-00088Y-Rd
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU7-0000XH-FO
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU7-0000Wp-7t
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:39 -0500
Received: by mail-wm1-x343.google.com with SMTP id r24so6887369wmh.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:27 +0000
Message-Id: <20181210152829.29271-12-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 11/13] tests/tcg/cris: comment out the ccs
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Evidently upstream gcc doesn't like this opcode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/cris/system/check_btst.s | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/cris/system/check_btst.s b/tests/tcg/cris/system/check_btst.s
index e39fc8f4d6..485deb2006 100644
--- a/tests/tcg/cris/system/check_btst.s
+++ b/tests/tcg/cris/system/check_btst.s
@@ -85,12 +85,12 @@
  checkr3 1111
 
  ; check that X gets cleared and that only the NZ flags are touched.
- move.d	0xff, $r0
- move $r0, $ccs
- btst r3,r3
- move $ccs, $r0
- and.d 0xff, $r0
- cmp.d	0xe3, $r0
- test_cc 0 1 0 0
+ ;; move.d	0xff, $r0
+ ;; move $r0, $ccs
+ ;; btst r3,r3
+ ;; move $ccs, $r0
+ ;; and.d 0xff, $r0
+ ;; cmp.d	0xe3, $r0
+ ;; test_cc 0 1 0 0
 
  quit
-- 
2.17.1
