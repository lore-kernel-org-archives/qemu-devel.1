Received: from eggs.gnu.org ([2001:4830:134:3::10]:56566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fk2oS-0005Sr-1F
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fk2oP-0001KT-AY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:40268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fk2oP-0001K9-2Y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:49 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 30 Jul 2018 15:13:56 +0800
Message-Id: <1532934837-5966-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1532934837-5966-1-git-send-email-wei.w.wang@intel.com>
References: <1532934837-5966-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] bitmap.h: add comments to
 BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, quintela@redhat.com
Cc: mst@redhat.com

This macro was ported from Linux and we've reached an aggreement there
that the corner case "nbits = 0" is not applicable to this macro, because
when "nbits = 0", which means no bits to mask, this macro is expected to
return 0, instead of 0xffffffff. This patch simply adds a comment above
the macro as a note to users about the corner case.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eedd..f53c640 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -60,6 +60,7 @@
  */
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+/* "nbits = 0" is not applicable to this macro. Callers should avoid that. */
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
 #define DECLARE_BITMAP(name,bits)                  \
-- 
2.7.4
