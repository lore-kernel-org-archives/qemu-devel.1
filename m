Received: from eggs.gnu.org ([2001:4830:134:3::10]:43866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emjqv-0003x0-03
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emjqr-0001C2-Q2
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:31:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emjqr-0001BC-KQ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:31:13 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 17:31:11 +0000
Message-Id: <20180216173111.10270-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] cuda.h: Fix multiple typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

RHEL6's compilers don't like the repeated typedef.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/hw/misc/macio/cuda.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 6afbdd13ee..494b709579 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -93,12 +93,12 @@ typedef struct CUDAState {
 } CUDAState;
 
 /* MOS6522 CUDA */
-typedef struct MOS6522CUDAState {
+struct MOS6522CUDAState {
     /*< private >*/
     MOS6522State parent_obj;
 
     CUDAState *cuda;
-} MOS6522CUDAState;
+};
 
 #define TYPE_MOS6522_CUDA "mos6522-cuda"
 #define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
-- 
2.14.3
