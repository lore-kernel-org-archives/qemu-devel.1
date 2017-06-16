Received: from eggs.gnu.org ([2001:4830:134:3::10]:45123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLwQI-0005MC-4J
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLwQH-00078t-BQ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:56:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 16 Jun 2017 14:56:36 -0400
Message-Id: <1497639397-19453-2-git-send-email-cota@braap.org>
In-Reply-To: <1497639397-19453-1-git-send-email-cota@braap.org>
References: <1497639397-19453-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 1/2] gen-icount: add missing inline to
 gen_tb_end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 62d462e..547c979 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -44,7 +44,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_temp_free_i32(count);
 }
 
-static void gen_tb_end(TranslationBlock *tb, int num_insns)
+static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
     if (tb->cflags & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
-- 
2.7.4
