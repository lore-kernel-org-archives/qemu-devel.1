Received: from eggs.gnu.org ([2001:4830:134:3::10]:43055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHPG-0005MF-LP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHPF-0004CS-Uv
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gRHPF-000484-Oj
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHP9-0001gg-Em
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:58:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 13:58:19 +0000
Message-Id: <20181126135820.18998-3-peter.maydell@linaro.org>
In-Reply-To: <20181126135820.18998-1-peter.maydell@linaro.org>
References: <20181126135820.18998-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] MAINTAINERS: Add an ARM SMMU section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Add a new ARM SMMU section and set Eric Auger as the maintainer
for ARM SMMU emulation sources.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20181122180143.14237-1-eric.auger@redhat.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43d0d9d5783..9410bbb7cf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -151,6 +151,13 @@ F: disas/arm.c
 F: disas/arm-a64.cc
 F: disas/libvixl/
 
+ARM SMMU
+M: Eric Auger <eric.auger@redhat.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/smmu*
+F: include/hw/arm/smmu*
+
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.19.1
