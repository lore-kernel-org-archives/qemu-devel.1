Received: from eggs.gnu.org ([2001:4830:134:3::10]:55117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAP0-0000w7-3Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOz-00054w-2l
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:50 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:45442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOy-00054d-RS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:48 -0400
Received: by mail-lf0-x243.google.com with SMTP id y14-v6so24549000lfy.12
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:19:07 +0200
Message-Id: <20180503091922.28733-15-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 14/29] target-microblaze: Name special
 registers we support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Name special registers we support.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c971fe3b72..57cd00ab3e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -105,8 +105,8 @@ static const char *regnames[] =
 
 static const char *special_regnames[] =
 {
-    "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
-    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
+    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
+    "sr8", "sr9", "sr10", "rbtr", "sr12", "rbtr"
 };
 
 static inline void t_sync_flags(DisasContext *dc)
-- 
2.14.1
