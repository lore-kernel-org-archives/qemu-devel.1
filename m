Received: from eggs.gnu.org ([2001:4830:134:3::10]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpHo-0006JZ-Ld
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpHj-0002Z6-2y
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:12 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKpHi-00020z-DR
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:06 -0500
Date: Thu, 8 Nov 2018 19:43:07 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <5bea109f0c140da6a821aa7f9705d4b3717e86dc.1541701393.git.noring@nocrew.org>
References: <cover.1541701393.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541701393.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 1/2] linux-user/mips: Support the n32 ABI for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Recognise the R5900, which reports itself as MIPS III, as a 64-bit CPU
supporting the n32 ABI.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 linux-user/mips64/target_elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ec55d8542a..5f2f2df29f 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
     }
+    if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
+        return "R5900";
+    }
     return "5KEf";
 }
 #endif
-- 
2.18.1
