Received: from eggs.gnu.org ([2001:4830:134:3::10]:41754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMww-0005u8-H5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMws-0003VC-Gu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:06 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:39086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMws-0003Um-9x
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:02 -0400
Received: by mail-wm0-x230.google.com with SMTP id p11-v6so2805551wmc.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:58 +0100
Message-Id: <20180622141205.16306-16-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 15/22] risu_reginfo_aarch64: drop stray
 ;
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index c270e0b..34dd9af 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -66,7 +66,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     for (i = 0; i < 32; i++) {
         ri->vregs[i] = fp->vregs[i];
     }
-};
+}
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
-- 
2.17.1
