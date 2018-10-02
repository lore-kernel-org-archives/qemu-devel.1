Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7CRR-0003Bi-TQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7CFi-0002vl-U5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 00:25:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  2 Oct 2018 14:25:26 +1000
Message-Id: <20181002042526.9565-2-david@gibson.dropbear.id.au>
In-Reply-To: <20181002042526.9565-1-david@gibson.dropbear.id.au>
References: <20181002042526.9565-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/1] Update dtc/libfdt submodule to v1.4.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

dtc v1.4.7 contains a bunch of improvements to make libfdt safer against
handling a corrupted or malicious tree, which is a good thing to have.  It
also includes an explicit fdt checking function that we'll be wanting in
future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 dtc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dtc b/dtc
index e54388015a..88f18909db 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
+Subproject commit 88f18909db731a627456f26d779445f84e449536
-- 
2.17.1
