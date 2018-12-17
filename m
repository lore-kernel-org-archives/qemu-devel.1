Received: from eggs.gnu.org ([2001:4830:134:3::10]:58459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Tl-0007UA-2n
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Th-0007PR-O3
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:12 -0500
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:55468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1Th-0007K1-5v
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:09 -0500
Received: from player718.ha.ovh.net (unknown [10.109.159.154])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 216A114AA58
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:35:02 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 17 Dec 2018 23:34:39 +0100
Message-Id: <20181217223445.28594-2-clg@kaod.org>
In-Reply-To: <20181217223445.28594-1-clg@kaod.org>
References: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 1/7] target/ppc: fix the PPC_BIT definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Change the PPC_BIT macro to use ULL instead of UL and the PPC_BIT32
and PPC_BIT8 not to use any suffix.

This fixes a compile breakage on windows.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ab68abe8a23c..527181c0f09f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -70,9 +70,9 @@
 #define PPC_ELF_MACHINE     EM_PPC
 #endif
=20
-#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
-#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
-#define PPC_BIT8(bit)           (0x80UL >> (bit))
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32(bit)          (0x80000000 >> (bit))
+#define PPC_BIT8(bit)           (0x80 >> (bit))
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
--=20
2.17.2
