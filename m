Received: from eggs.gnu.org ([2001:4830:134:3::10]:44764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiL-0002w5-Cv
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiK-0003c0-Np
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:13 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLiK-0003bV-GP
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:12 -0400
Received: by mail-lf0-x242.google.com with SMTP id x81so15592589lfb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:09:12 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 18:09:01 +0200
Message-Id: <1497974944-27050-5-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 4/7] target-microblaze: dec_barrel: Plug TCG
 temp leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug TCG temp leak.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 504ed88..6ee4885 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -690,6 +690,7 @@ static void dec_barrel(DisasContext *dc)
             tcg_gen_shr_tl(cpu_R[dc->rd], cpu_R[dc->ra], t0);
         }
     }
+    tcg_temp_free(t0);
 }
 
 static void dec_bit(DisasContext *dc)
-- 
2.7.4
