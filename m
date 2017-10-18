Received: from eggs.gnu.org ([2001:4830:134:3::10]:34596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e4wQf-0001FA-AJ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e4wQe-00059y-KG
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:03:09 -0400
Date: Wed, 18 Oct 2017 15:03:02 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1710181439060.27209@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sstabellini@kernel.org, julien.grall@linaro.org

WFI/E are 4 bytes long: set ARM_EL_IL_SHIFT in the syndrome.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f6efef..cf8c966 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -398,6 +398,7 @@ static inline uint32_t syn_breakpoint(int same_el)
 static inline uint32_t syn_wfx(int cv, int cond, int ti)
 {
     return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
+           (1 << ARM_EL_IL_SHIFT) |
            (cv << 24) | (cond << 20) | ti;
 }
 
