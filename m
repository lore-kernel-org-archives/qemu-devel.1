Received: from eggs.gnu.org ([209.51.188.92]:42779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFc-0000YB-Pk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFc-0007R1-2J
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:52 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFb-0007Q9-Sp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:52 -0500
Received: by mail-wm1-x330.google.com with SMTP id x7so10442601wmj.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:51 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:33 +0000
Message-Id: <20190228202537.4638-13-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/16] tests/tcg/cris: comment out the ccs
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
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Evidently upstream gcc doesn't like this opcode.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/cris/bare/check_btst.s | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/cris/bare/check_btst.s b/tests/tcg/cris/bare/check_btst.s
index e39fc8f4d6..485deb2006 100644
--- a/tests/tcg/cris/bare/check_btst.s
+++ b/tests/tcg/cris/bare/check_btst.s
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
2.20.1
