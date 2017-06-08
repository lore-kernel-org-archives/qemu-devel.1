Received: from eggs.gnu.org ([2001:4830:134:3::10]:59838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ3GX-0003sY-SG
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ3GX-0000GB-5h
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:45 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ3GW-0000G1-Ve
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:38:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id d17so3996569wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 12:38:44 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 22:38:21 +0300
Message-Id: <20170608193822.24418-3-rolnik@amazon.com>
In-Reply-To: <20170608193822.24418-1-rolnik@amazon.com>
References: <20170608193822.24418-1-rolnik@amazon.com>
Subject: [Qemu-devel] [PATCH RFC v19 12/13] target-avr: Respect .inc.c
 convention
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Michael Rolnik <mrolnik@gmail.com>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/avr/{decode.c => decode.inc.c}                 | 0
 target/avr/{translate-inst.c => translate-inst.inc.c} | 0
 target/avr/translate.c                                | 4 ++--
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename target/avr/{decode.c => decode.inc.c} (100%)
 rename target/avr/{translate-inst.c => translate-inst.inc.c} (100%)

diff --git a/target/avr/decode.c b/target/avr/decode.inc.c
similarity index 100%
rename from target/avr/decode.c
rename to target/avr/decode.inc.c
diff --git a/target/avr/translate-inst.c b/target/avr/translate-inst.inc.c
similarity index 100%
rename from target/avr/translate-inst.c
rename to target/avr/translate-inst.inc.c
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 184e66c04e..428261a64a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -103,8 +103,8 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 
 #include "exec/gen-icount.h"
 #include "translate-inst.h"
-#include "translate-inst.c"
-#include "decode.c"
+#include "translate-inst.inc.c"
+#include "decode.inc.c"
 
 void avr_translate_init(void)
 {
-- 
2.11.0 (Apple Git-81)
