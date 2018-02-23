Received: from eggs.gnu.org ([2001:4830:134:3::10]:44396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOx-0002mO-I9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOw-00077J-NJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:47 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFOw-00075J-FR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:46 -0500
Received: by mail-wr0-x242.google.com with SMTP id z12so14530346wrg.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:36:46 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:12 +0000
Message-Id: <20180223153636.29809-8-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/31] arm/translate-a64: handle_3same_64
 comment fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

We do implement all the opcodes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ebaf4571ac..5dd54b7ac4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7278,8 +7278,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     /* Handle 64x64->64 opcodes which are shared between the scalar
      * and vector 3-same groups. We cover every opcode where size == 3
      * is valid in either the three-reg-same (integer, not pairwise)
-     * or scalar-three-reg-same groups. (Some opcodes are not yet
-     * implemented.)
+     * or scalar-three-reg-same groups.
      */
     TCGCond cond;
 
-- 
2.15.1
