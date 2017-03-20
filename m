Received: from eggs.gnu.org ([2001:4830:134:3::10]:45728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvb-0003yE-DH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-000721-3u
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:51 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:59221)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvU-00070a-V9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:45 -0400
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id CCBAA5E32C367
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 13:00:40 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:26 +0000
Message-ID: <1490014826-4472-11-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL for v2.9 10/10] MAINTAINERS: update for MIPS
 devices
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

cc: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf1aafb..779c429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -600,15 +600,28 @@ S: Maintained
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
+M: Paul Burton <paul.burton@imgtec.com>
+S: Maintained
+F: hw/core/loader-fit.c
+F: hw/mips/boston.c
+F: hw/pci-host/xilinx-pcie.c
+
 OpenRISC Machines
 -----------------
 or1k-sim
-- 
2.7.4
