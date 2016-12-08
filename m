Received: from eggs.gnu.org ([2001:4830:134:3::10]:59891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qS-0003kO-0w
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qR-0004Fh-9u
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:51:00 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:27 +0100
Message-Id: <20161208175030.12269-8-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 07/10] libcflat: add
 IS_ALIGNED() macro, and page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

These macros will be useful to do page alignment checks.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
[drew: also added SZ_64K and changed to shifts]
Signed-off-by: Andrew Jones <drjones@redhat.com>

---
v6: change to shifts [Alex]
---
 lib/libcflat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index 15dbcadc6c7a..e636705e12b3 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -33,6 +33,12 @@
 #define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 #define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define ALIGN(x, a)		__ALIGN((x), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#define SZ_4K			(1 << 12)
+#define SZ_64K			(1 << 16)
+#define SZ_2M			(1 << 21)
+#define SZ_1G			(1 << 30)
 
 typedef uint8_t		u8;
 typedef int8_t		s8;
-- 
2.9.3
