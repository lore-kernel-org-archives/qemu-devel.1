Received: from eggs.gnu.org ([2001:4830:134:3::10]:48561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFud-0001fe-JT
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFua-0007Z6-7l
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:45:07 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFuZ-0007YB-Ul
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:45:04 -0400
Date: Sun, 21 Oct 2018 17:44:58 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <5cf396b0852dce2bf2977bf38fc1172e868920e0.1540134919.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 38/38] linux-user/mips: Recognise the R5900
 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

This kind of ELF for the R5900 relies on an IEEE 754-1985 compliant FPU.
The R5900 FPU hardware is noncompliant and it is therefore emulated in
software by the Linux kernel. QEMU emulates a compliant FPU accordingly.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 linux-user/mips/target_elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index fa5d30bf99..a98c9bd6ad 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags=
)
     if ((eflags & EF_MIPS_ARCH) =3D=3D EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_MACH) =3D=3D EF_MIPS_MACH_5900) {
+        return "R5900";
+    }
     return "24Kf";
 }
 #endif
--=20
2.18.1
