Received: from eggs.gnu.org ([2001:4830:134:3::10]:45489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6P-0008CR-Vh
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6O-00084v-46
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:57 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6N-00084L-UK
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:56 -0400
Received: by mail-wm0-x241.google.com with SMTP id u138so622914wmu.4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:56 +0200
Message-Id: <20171025093535.10175-13-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/51] tcg: Remove unused TCG_CALL_DUMMY_TCGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 0a0bc92dd9..c50805217c 100644
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
