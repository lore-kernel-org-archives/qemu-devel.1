Received: from eggs.gnu.org ([209.51.188.92]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3mj-00012K-1Z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3mi-0007uZ-7U
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:00 +0100
Message-Id: <20190205164109.25413-2-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/10] target/s390x: define TCG_GUEST_DEFAULT_MO
 for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

MTTCG should be enabled by default whenever the memory model allows
it. s390x was missing its definition of TCG_GUEST_DEFAULT_MO meaning
the user had to manually specify  --accel tcg,thread=3Dmulti.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Message-Id: <20190118171848.27332-1-alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8c2320e882..47d2c2e9cf 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,6 +35,10 @@
 #define CPUArchState struct CPUS390XState
=20
 #include "exec/cpu-defs.h"
+
+/* The z/Architecture has a strong memory model with some store-after-lo=
ad re-ordering */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 #define TARGET_PAGE_BITS 12
=20
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
--=20
2.17.2
