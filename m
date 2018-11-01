Received: from eggs.gnu.org ([2001:4830:134:3::10]:41437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGtE-0003O6-TU
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGtE-0002NX-5v
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:36:16 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:64715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIGtD-0002Mk-Ul
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:36:16 -0400
Date: Thu, 1 Nov 2018 18:36:04 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <bfc3cf106eb3645a9bbeb636bb47db19a8f5ad55.1541093316.git.noring@nocrew.org>
References: <cover.1541093316.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541093316.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/12] disas/mips: Increase 'member of ISAs'
 flag holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Increase the size of 'membership' holder size to 64 bits. This is
needed for future extensions since existing bits are almost all used.
This change is related to commit f9c9cd63e3 "target/mips: Increase
'supported ISAs/ASEs' flag holder size".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 disas/mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/mips.c b/disas/mips.c
index 97f661a37e..d73d4094d8 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -301,7 +301,7 @@ struct mips_opcode
   unsigned long pinfo2;
   /* A collection of bits describing the instruction sets of which this
      instruction or macro is a member. */
-  unsigned long membership;
+  uint64_t membership;
 };
=20
 /* These are the characters which may appear in the args field of an
--=20
2.18.1
