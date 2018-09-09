Received: from eggs.gnu.org ([2001:4830:134:3::10]:39330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod7-0004JG-NA
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod3-0001Kj-Sb
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:13 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod1-0001JI-Rn
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:09 -0400
Received: by mail-wm0-x243.google.com with SMTP id s12-v6so18069415wmc.0
	for <qemu-devel@nongnu.org>; Sat, 08 Sep 2018 18:35:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  9 Sep 2018 02:34:44 +0100
Message-Id: <20180909013444.18936-3-f4bug@amsat.org>
In-Reply-To: <20180909013444.18936-1-f4bug@amsat.org>
References: <20180909013444.18936-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] target/mips: Add entries for the Toshiba's
 R3900 and R5900 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/mips-defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index c8e99791ad..9875bdac82 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -56,6 +56,8 @@
 #define		INSN_LOONGSON2E  0x20000000
 #define		INSN_LOONGSON2F  0x40000000
 #define		INSN_VR54XX	0x80000000
+#define     INSN_R3900       0x100000000ULL
+#define     INSN_R5900       0x200000000ULL
 
 /* MIPS CPU defines. */
 #define		CPU_MIPS1	(ISA_MIPS1)
-- 
2.19.0.rc2
