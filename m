Received: from eggs.gnu.org ([2001:4830:134:3::10]:55246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyp-0002ks-3w
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyo-0003O5-Ao
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyo-0003Nv-5d
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:42 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:11 +0800
Message-Id: <1481512100-10380-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 05/14] libcflat: add
 IS_ALIGNED() macro, and page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

These macros will be useful to do page alignment checks.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/libcflat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index 8455c3d..88b10e2 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -33,6 +33,12 @@
 #define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 #define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define ALIGN(x, a)		__ALIGN((x), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#define SZ_4K                  (1 << 12)
+#define SZ_64K                 (1 << 16)
+#define SZ_2M                  (1 << 21)
+#define SZ_1G                  (1 << 30)
 
 typedef uint8_t		u8;
 typedef int8_t		s8;
-- 
2.7.4
