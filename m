Received: from eggs.gnu.org ([2001:4830:134:3::10]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhN-0006Yt-Eo
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhM-0002QS-TX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:53 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhM-0002QI-Q2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:52 -0400
Received: by mail-qk0-x244.google.com with SMTP id p21so1450159qke.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:27 -0700
Message-Id: <20170621024831.26019-13-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 12/16] tcg: Remove unused TCG_CALL_DUMMY_TCGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 1eeeca5..4f69d0c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -503,7 +503,6 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
 #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
 
 /* used to align parameters */
-#define TCG_CALL_DUMMY_TCGV     MAKE_TCGV_I32(-1)
 #define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
 
 /* Conditions.  Note that these are laid out for easy manipulation by
-- 
2.9.4
