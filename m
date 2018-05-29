Received: from eggs.gnu.org ([2001:4830:134:3::10]:36947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDC-0001W8-Pq
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcD8-0003wa-2K
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:42 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcD7-0003wP-R6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:37 -0400
Received: by mail-wm0-x243.google.com with SMTP id f8-v6so39340388wmc.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:37 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:47 +0200
Message-Id: <20180529105011.1914-15-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 14/38] target-microblaze: Name special
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
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Name special registers we support.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b36092b6fe..381f25348c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -105,8 +105,8 @@ static const char *regnames[] =
 
 static const char *special_regnames[] =
 {
-    "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
-    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
+    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
+    "sr8", "sr9", "sr10", "rbtr", "sr12", "redr"
 };
 
 static inline void t_sync_flags(DisasContext *dc)
-- 
2.14.1
