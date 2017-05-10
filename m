Received: from eggs.gnu.org ([2001:4830:134:3::10]:33073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsE-0008CL-QB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsD-0006U3-Va
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:14 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsD-0006TT-RW
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:13 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so264999qta.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:06:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 17:05:31 -0300
Message-Id: <20170510200535.13268-5-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-1-f4bug@amsat.org>
References: <20170510200535.13268-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/8] target/cris: optimize gen_swapb() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Applied using Coccinelle script.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/cris/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca02d..c03403ac62 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -442,8 +442,7 @@ static inline void t_gen_swapb(TCGv d, TCGv s)
     tcg_gen_mov_tl(org_s, s);
     tcg_gen_shli_tl(t, org_s, 8);
     tcg_gen_andi_tl(d, t, 0xff00ff00);
-    tcg_gen_shri_tl(t, org_s, 8);
-    tcg_gen_andi_tl(t, t, 0x00ff00ff);
+    tcg_gen_extract_tl(t, org_s, 8, 0x00ff00ff);
     tcg_gen_or_tl(d, d, t);
     tcg_temp_free(t);
     tcg_temp_free(org_s);
-- 
2.11.0
