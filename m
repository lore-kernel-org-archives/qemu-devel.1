Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5i2-0001eW-SV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5i2-0008Py-0J
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:26 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:03 -0500
Message-Id: <20180619014319.28272-38-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 037/113] multiboot: Remove unused variables
 from multiboot.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jack Schwartz <jack.schwartz@oracle.com>, Kevin Wolf <kwolf@redhat.com>

From: Jack Schwartz <jack.schwartz@oracle.com>

Remove unused variables: mh_mode_type, mh_width, mh_height, mh_depth

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7a2e43cc96fd017883973caf9ee076ae23a3bebd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/multiboot.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index ff2733d12e..964feaf26e 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -255,12 +255,6 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_kernel_size = mb_load_size;
         }
 
-        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
-        uint32_t mh_mode_type = ldl_p(header+i+32);
-        uint32_t mh_width = ldl_p(header+i+36);
-        uint32_t mh_height = ldl_p(header+i+40);
-        uint32_t mh_depth = ldl_p(header+i+44); */
-
         mb_debug("multiboot: mh_header_addr = %#x\n", mh_header_addr);
         mb_debug("multiboot: mh_load_addr = %#x\n", mh_load_addr);
         mb_debug("multiboot: mh_load_end_addr = %#x\n", mh_load_end_addr);
-- 
2.11.0
