Received: from eggs.gnu.org ([2001:4830:134:3::10]:53458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0S-0004Qp-0o
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0Q-0007qA-Ud
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:47 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0Q-0007pj-Nq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:46 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w126so26993263wme.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:13 +0100
Message-Id: <20170720150426.12393-11-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 10/23] target/arm/translate-a64.c:
 handle_3same_64 comment fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We do implement all the opcodes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d95d..68099fdb5e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7135,8 +7135,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     /* Handle 64x64->64 opcodes which are shared between the scalar
      * and vector 3-same groups. We cover every opcode where size == 3
      * is valid in either the three-reg-same (integer, not pairwise)
-     * or scalar-three-reg-same groups. (Some opcodes are not yet
-     * implemented.)
+     * or scalar-three-reg-same groups.
      */
     TCGCond cond;
 
-- 
2.13.0
