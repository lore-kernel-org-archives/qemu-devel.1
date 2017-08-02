Received: from eggs.gnu.org ([2001:4830:134:3::10]:51749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03P-0000Jc-QB
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03O-0006In-RH
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dd03O-0006I3-LO
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3CD085541
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:15:37 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  2 Aug 2017 16:15:12 -0400
Message-Id: <20170802201512.29142-7-crosa@redhat.com>
In-Reply-To: <20170802201512.29142-1-crosa@redhat.com>
References: <20170802201512.29142-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] tests/tcg/test-i386-fprem.c: compilation
 fix for -Werror=unused-const-variable=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

A clean up of unused code to make the compiler happy.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/tcg/test-i386-fprem.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/tests/tcg/test-i386-fprem.c b/tests/tcg/test-i386-fprem.c
index f70363d..1dceda0 100644
--- a/tests/tcg/test-i386-fprem.c
+++ b/tests/tcg/test-i386-fprem.c
@@ -54,14 +54,6 @@ union float80u {
 
 #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
 
-static const union float80u q_nan = {
-    .ieee_nan.negative = 0,  /* X */
-    .ieee_nan.exponent = 0x7fff,
-    .ieee_nan.one = 1,
-    .ieee_nan.quiet_nan = 1,
-    .ieee_nan.mantissa = 0,
-};
-
 static const union float80u s_nan = {
     .ieee_nan.negative = 0,  /* X */
     .ieee_nan.exponent = 0x7fff,
@@ -91,13 +83,6 @@ static const union float80u pos_denorm = {
     .ieee.mantissa = 1,
 };
 
-static const union float80u smallest_positive_norm = {
-    .ieee.negative = 0,
-    .ieee.exponent = 1,
-    .ieee.one = 1,
-    .ieee.mantissa = 0,
-};
-
 static void fninit(void)
 {
     asm volatile ("fninit\n");
-- 
2.9.4
