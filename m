Received: from eggs.gnu.org ([2001:4830:134:3::10]:35940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX5f-0004BQ-V8
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX5e-0005hl-Q4
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1etX5e-0005hU-LV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:34 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Mar 2018 12:18:20 +0100
Message-Id: <20180307111822.29403-3-kwolf@redhat.com>
In-Reply-To: <20180307111822.29403-1-kwolf@redhat.com>
References: <20180307111822.29403-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] multiboot: Remove unused variables from
 multiboot.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jack.schwartz@oracle.com

From: Jack Schwartz <jack.schwartz@oracle.com>

Remove unused variables: mh_mode_type, mh_width, mh_height, mh_depth

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/i386/multiboot.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index bb8d8e4629..7d59cbe523 100644
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
2.13.6
