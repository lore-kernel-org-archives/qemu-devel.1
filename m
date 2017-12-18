Received: from eggs.gnu.org ([2001:4830:134:3::10]:49878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eR3z1-00035i-9X
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1eR3yy-0006QZ-4T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:34:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1eR3yx-0006PU-VB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:34:00 -0500
From: Cole Robinson <crobinso@redhat.com>
Date: Mon, 18 Dec 2017 17:33:54 -0500
Message-Id: <458bba0e0865443a3d4e0f8e0dbb5bc712e098b9.1513636434.git.crobinso@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/make-release: More .git removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org, Cole Robinson <crobinso@redhat.com>

As was last done in 379e21c25, we want to remove .git files for
submodules here, which we aren't presently doing for capstone and
keycodemapdb.

Rather than a whitelist use 'find' to future proof this

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 scripts/make-release | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/make-release b/scripts/make-release
index 3917df7142..7c7bec577f 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -19,7 +19,7 @@ pushd ${destination}
 git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
-rm -rf .git roms/*/.git dtc/.git pixman/.git
+find . -depth -name .git -exec rm -rf '{}' \;
 # FIXME: The following line is a workaround for avoiding filename collisions
 # when unpacking u-boot sources on case-insensitive filesystems. Once we
 # update to something with u-boot commit 610eec7f0 we can drop this line.
-- 
2.14.3
