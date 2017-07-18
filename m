Received: from eggs.gnu.org ([2001:4830:134:3::10]:60257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsV-0001gt-1Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsU-0000nV-2A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:47 -0300
Message-Id: <20170718061005.29518-12-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/29] s390x/sclp: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/s390x/sclp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9253dbbc64..0a207c7345 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -237,7 +237,7 @@ static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
     }
     assign_addr = (assign_info->rn - 1) * mhd->rzm;
 
-    if ((assign_addr % MEM_SECTION_SIZE == 0) &&
+    if (QEMU_IS_ALIGNED(assign_addr, MEM_SECTION_SIZE) &&
         (assign_addr >= mhd->padded_ram_size)) {
         /* Re-use existing memory region if found */
         mr = memory_region_find(sysmem, assign_addr, 1).mr;
@@ -297,7 +297,7 @@ static void unassign_storage(SCLPDevice *sclp, SCCB *sccb)
     unassign_addr = (assign_info->rn - 1) * mhd->rzm;
 
     /* if the addr is a multiple of 256 MB */
-    if ((unassign_addr % MEM_SECTION_SIZE == 0) &&
+    if (QEMU_IS_ALIGNED(unassign_addr, MEM_SECTION_SIZE) &&
         (unassign_addr >= mhd->padded_ram_size)) {
         mhd->standby_state_map[(unassign_addr -
                            mhd->padded_ram_size) / MEM_SECTION_SIZE] = 0;
-- 
2.13.2
