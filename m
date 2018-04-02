Received: from eggs.gnu.org ([2001:4830:134:3::10]:34132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f30z7-0003hO-D5
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 11:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f30z3-0005cr-GY
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 11:03:01 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 2 Apr 2018 16:52:24 +0200
Message-Id: <20180402150254.38B857456A2@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] roms/u-boot-sam460ex: Change to qemu git
 mirror and update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>

Now that we have a mirror of this repo on git.qemu.org change the
submodule to use that and also update it to latest HEAD which has a
commit to fix a dangling symlink.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 .gitmodules          | 2 +-
 roms/u-boot-sam460ex | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index c613722..49e9c2e 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -45,4 +45,4 @@
 	url = git://github.com/hdeller/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = git://github.com/zbalaton/u-boot-sam460ex
+	url = git://git.qemu.org/u-boot-sam460ex.git
diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
index 119aa27..930735b 160000
--- a/roms/u-boot-sam460ex
+++ b/roms/u-boot-sam460ex
@@ -1 +1 @@
-Subproject commit 119aa277f74a4a2d3f7ab6c9471292308eba14e4
+Subproject commit 930735bdd6edbb0588d6a54882feb58ab3cb2d08
-- 
2.7.6
