Received: from eggs.gnu.org ([2001:4830:134:3::10]:59378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePqxO-0005T4-9O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePqxK-0007m0-An
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:27:22 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Dec 2017 15:27:10 +0100
Message-Id: <1513348030-7689-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] scripts/make-release: No need to delete
 pixman/.git anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org

The pixman submodule has been removed in commit c12b6d70e384c769ca372e1,
so there is no need anymore to delete pixman/.git while building a
release tarball.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Rebased to current master branch (there was a contextual conflict)

 scripts/make-release | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/make-release b/scripts/make-release
index 3917df7..7af11af 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -19,7 +19,7 @@ pushd ${destination}
 git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
-rm -rf .git roms/*/.git dtc/.git pixman/.git
+rm -rf .git roms/*/.git dtc/.git
 # FIXME: The following line is a workaround for avoiding filename collisions
 # when unpacking u-boot sources on case-insensitive filesystems. Once we
 # update to something with u-boot commit 610eec7f0 we can drop this line.
-- 
1.8.3.1
