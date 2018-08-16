Received: from eggs.gnu.org ([2001:4830:134:3::10]:56165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJl9-0005U7-Pj
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJks-0000bC-H3
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:17 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41047 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJkj-0000Vo-To
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:00 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:04 +0200
Message-Id: <1534431497-1385-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 11/84] elf: Remove duplicate preprocessor
 constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.

The duplicate was introduced in commit 45506bdd. It placed the
constant EF_MIPS_ARCH in a better place, however it did not remove
the original. This patch removes the original occurrence.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index 934dbbd..60f6cbe 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -61,7 +61,6 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ABI		0x0000f000
 #define EF_MIPS_FP64      0x00000200
 #define EF_MIPS_NAN2008   0x00000400
-#define EF_MIPS_ARCH      0xf0000000
=20
 /* These constants define the different elf file types */
 #define ET_NONE   0
--=20
2.7.4
