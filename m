Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slX-00079W-5o
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slW-0002gJ-5d
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:33 +1000
Message-Id: <20180410125233.31618-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 7/7] roms/u-boot-sam460ex: Change to qemu git
 mirror and update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Now that we have a mirror of this repo on git.qemu.org change the
submodule to use that and update it to latest commit which fixes a
dangling symlink and removes two big binaries that are not needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 .gitmodules          | 2 +-
 roms/u-boot-sam460ex | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index c613722e3c..49e9c2e3f4 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -45,4 +45,4 @@
 	url = git://github.com/hdeller/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = git://github.com/zbalaton/u-boot-sam460ex
+	url = git://git.qemu.org/u-boot-sam460ex.git
diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
index 119aa277f7..8ee007c421 160000
--- a/roms/u-boot-sam460ex
+++ b/roms/u-boot-sam460ex
@@ -1 +1 @@
-Subproject commit 119aa277f74a4a2d3f7ab6c9471292308eba14e4
+Subproject commit 8ee007c4216fd6a0d760589e8405ce4494497aa0
-- 
2.14.3
