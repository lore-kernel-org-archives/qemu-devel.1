Received: from eggs.gnu.org ([2001:4830:134:3::10]:47586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eS4at-0006Sm-E5
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eS4ap-0008N6-CQ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:25:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1eS4ap-0008LU-2M
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:25:15 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Thu, 21 Dec 2017 09:25:16 -0800
Message-Id: <1513877118-3149-3-git-send-email-jack.schwartz@oracle.com>
In-Reply-To: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH QEMU v1 2/4] multiboot: Remove unused variables
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
Cc: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, daniel.kiper@oracle.com, konrad.wilk@oracle.com

Remove unused variables: mh_mode_type, mh_width, mh_height, mh_depth

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 hw/i386/multiboot.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index ff2733d..964feaf 100644
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
1.8.3.1
