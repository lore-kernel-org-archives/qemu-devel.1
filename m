Received: from eggs.gnu.org ([209.51.188.92]:49037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTb-0006lp-Fy
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTT-0000aU-4X
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:03:41 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 21:03:12 +0100
Message-Id: <20190225200318.16102-2-david@redhat.com>
In-Reply-To: <20190225200318.16102-1-david@redhat.com>
References: <20190225200318.16102-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/7] s390x/tcg: RXE has an optional M3 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Will be needed, so add it to the format description.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-format.def | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/insn-format.def b/target/s390x/insn-format.def
index a412d90fb7..4297ff4165 100644
--- a/target/s390x/insn-format.def
+++ b/target/s390x/insn-format.def
@@ -36,7 +36,7 @@ F3(RSY_a, R(1, 8),     BDL(2),      R(3,12))
 F3(RSY_b, R(1, 8),     BDL(2),      M(3,12))
 F2(RX_a,  R(1, 8),     BXD(2))
 F2(RX_b,  M(1, 8),     BXD(2))
-F2(RXE,   R(1, 8),     BXD(2))
+F3(RXE,   R(1, 8),     BXD(2),      M(3,32))
 F3(RXF,   R(1,32),     BXD(2),      R(3, 8))
 F2(RXY_a, R(1, 8),     BXDL(2))
 F2(RXY_b, M(1, 8),     BXDL(2))
-- 
2.17.2
