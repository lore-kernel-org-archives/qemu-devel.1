Received: from eggs.gnu.org ([2001:4830:134:3::10]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyl-0002i0-Kj
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyi-0003Mh-G1
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyi-0003MV-Ae
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:36 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:09 +0800
Message-Id: <1481512100-10380-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 03/14] libcflat: introduce
 is_power_of_2()
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

Suggested-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/libcflat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index c622198..8455c3d 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -104,4 +104,9 @@ do {									\
 	}								\
 } while (0)
 
+static inline bool is_power_of_2(unsigned long n)
+{
+	return n && !(n & (n - 1));
+}
+
 #endif
-- 
2.7.4
