Received: from eggs.gnu.org ([2001:4830:134:3::10]:52312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499r-00023B-Jj
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499q-0003Qs-Te
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:31 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499q-0003QI-OL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:30 -0400
Received: by mail-pf0-x22c.google.com with SMTP id a8so15843593pfc.0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:31 -0700
Message-Id: <20171016172609.23422-13-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 12/50] tcg: Remove unused TCG_CALL_DUMMY_TCGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 4352c0ee8c..e0615de90f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -496,7 +496,6 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
 #define TCG_CALL_NO_WG_SE       (TCG_CALL_NO_WG | TCG_CALL_NO_SE)
 
 /* used to align parameters */
-#define TCG_CALL_DUMMY_TCGV     MAKE_TCGV_I32(-1)
 #define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
 
 /* Conditions.  Note that these are laid out for easy manipulation by
-- 
2.13.6
