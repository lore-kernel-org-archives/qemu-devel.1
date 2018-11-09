Received: from eggs.gnu.org ([2001:4830:134:3::10]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL9Qt-0008Qn-GC
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gL9Qq-00025S-BS
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:14:55 -0500
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri,  9 Nov 2018 10:13:52 -0600
Message-Id: <20181109161352.29873-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH resend for-3.1] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is needed to build skiboot from tarball-distributed sources
since the git data the make_release.sh script relies on to generate
it is not available.

Cc: qemu-stable@nongnu.org
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 scripts/make-release | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/make-release b/scripts/make-release
index 04fa9defdc..c14f75b12c 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -19,6 +19,7 @@ pushd ${destination}
 git checkout "v${version}"
 git submodule update --init
 (cd roms/seabios && git describe --tags --long --dirty > .version)
+(cd roms/skiboot && ./make_version.sh > .version)
 # FIXME: The following line is a workaround for avoiding filename collisions
 # when unpacking u-boot sources on case-insensitive filesystems. Once we
 # update to something with u-boot commit 610eec7f0 we can drop this line.
-- 
2.17.1
