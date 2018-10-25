Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjWM-0002TS-Ul
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjWH-0000yI-Oa
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:34:10 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjWH-0000xx-Fv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:34:05 -0400
Date: Thu, 25 Oct 2018 19:34:02 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <3de56dc48ac4a141914991a1e10deb34c8df038e.1540487815.git.noring@nocrew.org>
References: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540487815.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/11] disas/mips: Increase 'member of ISAs'
 flag holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
