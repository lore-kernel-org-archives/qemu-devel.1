Received: from eggs.gnu.org ([2001:4830:134:3::10]:35013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRNZ-0005dz-KH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRNT-0002pe-T4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:21 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:33757)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRNT-0002nm-NB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:15 -0400
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id B5F8C573404AA
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 14:55:04 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 13 Mar 2017 14:54:52 +0000
Message-ID: <1489416892-2719-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] MAINTAINERS: update for MIPS devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paul Burton <paul.burton@imgtec.com>

Add myself to MIPSSIM and new entry for Fulong 2E.
Add an entry for Boston machine (Paul Burton).

Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
cc: Paul Burton <Paul.Burton@imgtec.com>
---
 MAINTAINERS | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3edd04..d196f19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -600,15 +600,26 @@ S: Maintained
 F: hw/mips/mips_malta.c
 
 Mipssim
-L: qemu-devel@nongnu.org
-S: Orphan
+M: Yongbok Kim <yongbok.kim@imgtec.com>
+S: Odd Fixes
 F: hw/mips/mips_mipssim.c
+F: hw/net/mipsnet.c
 
 R4000
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/mips/mips_r4k.c
 
+Fulong 2E
+M: Yongbok Kim <yongbok.kim@imgtec.com>
+S: Odd Fixes
+F: hw/mips/mips_fulong2e.c
+
+Boston
+M: Paul Burton <Paul.Burton@imgtec.com>
+S: Maintained
+F: hw/mips/boston.c
+
 OpenRISC Machines
 -----------------
 or1k-sim
-- 
2.7.4
