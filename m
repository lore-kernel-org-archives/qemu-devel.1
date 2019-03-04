Received: from eggs.gnu.org ([209.51.188.92]:46327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIw-0008V1-MF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIu-0000FD-OA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:49 +0100
Message-Id: <20190304120210.31500-7-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/27] s390x/tcg: RXE has an optional M3 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Will be needed, so add it to the format description.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225200318.16102-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-format.def | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/insn-format.def b/target/s390x/insn-format.def
index a412d90fb76d..4297ff416589 100644
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
