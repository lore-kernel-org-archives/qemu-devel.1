Received: from eggs.gnu.org ([2001:4830:134:3::10]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1f9aWi-0001Pt-L5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1f9aWd-0002E1-P8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:12:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1f9aWd-0002BH-Ix
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:12:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id m26-v6so7338794wrb.3
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 11:12:47 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 20 Apr 2018 20:12:45 +0200
Message-Id: <5570aff71297a26c09ba9b6cb3f88f583ff31057.1524247958.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qga/schema: fix documentation for GuestOSInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

The documentation for kernel-version and kernel-release on Windows was
swapped.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/qapi-schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..d3a686ba12 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1168,10 +1168,10 @@
 #
 # @kernel-release:
 #     * POSIX: release field returned by uname(2)
-#     * Windows: version number of the OS
+#     * Windows: build number of the OS
 # @kernel-version:
 #     * POSIX: version field returned by uname(2)
-#     * Windows: build number of the OS
+#     * Windows: version number of the OS
 # @machine:
 #     * POSIX: machine field returned by uname(2)
 #     * Windows: one of x86, x86_64, arm, ia64
-- 
2.17.0
