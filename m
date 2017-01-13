Received: from eggs.gnu.org ([2001:4830:134:3::10]:35197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS1LC-00061v-6T
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS1LB-0002PK-EG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:22 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:64952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cS1LB-0002Ov-4D
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:21 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 13 Jan 2017 13:52:02 +0100
Message-Id: <1484311923-28637-5-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 4/5] target-m68k: CAS doesn't need aligned
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, rth@twiddle.net, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 23e2b06..cf5d8dd 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1934,7 +1934,6 @@ DISAS_INSN(cas)
     default:
         g_assert_not_reached();
     }
-    opc |= MO_ALIGN;
 
     ext = read_im16(env, s);
 
-- 
2.7.4
