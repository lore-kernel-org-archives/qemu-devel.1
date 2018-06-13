Received: from eggs.gnu.org ([2001:4830:134:3::10]:50531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jx-0002l3-Et
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jv-0005IW-1h
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:17 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5Ju-0005HC-RU
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:14 -0400
Received: by mail-wr0-x244.google.com with SMTP id w10-v6so2645544wrk.9
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:56:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:54 +0100
Message-Id: <20180613125601.14371-16-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 15/22] risu_reginfo_aarch64: drop stray
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
