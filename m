Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFMyt-0004B4-QY
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFMyr-0001JR-Sp
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56215 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFMyr-0001In-J8
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 19:29:48 +0200
Message-Id: <1540402190-26289-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540402190-26289-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540402190-26289-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/3] target/mips: Add nanoMIPS CRC32
 instruction pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add nanoMIPS CRC32 instruction pool.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c44a751..4338b9a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17475,6 +17475,16 @@ enum {
     NM_SOV      = 0x7a,
 };
 
+/* CRC32 instruction pool */
+enum {
+    NM_CRC32B   = 0x00,
+    NM_CRC32H   = 0x01,
+    NM_CRC32W   = 0x02,
+    NM_CRC32CB  = 0x04,
+    NM_CRC32CH  = 0x05,
+    NM_CRC32CW  = 0x06,
+};
+
 /* POOL32A5 instruction pool */
 enum {
     NM_CMP_EQ_PH        = 0x00,
-- 
2.7.4
