Received: from eggs.gnu.org ([209.51.188.92]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3IBH-0007Lt-4f
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3IBG-0000ph-HG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:15 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 11 Mar 2019 11:29:05 +0100
Message-Id: <1552300145-12526-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Remove old *-config-devices.mak.d
 files when running configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

When running "make" in a build directory from the pre-Kconfig merge time,
the build process currently fails with:

 make: *** No rule to make target `.../default-configs/pci.mak',
  needed by `aarch64-softmmu/config-devices.mak'.  Stop.

To make sure that this problem at least goes away when the user runs
"configure" (or "sh config.status") again, we have to make sure that
we re-generate the .mak.d files. Thus remove the old stale files
while running the configure script.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index b354e74..32c847f 100755
--- a/configure
+++ b/configure
@@ -1792,6 +1792,9 @@ EOF
 exit 0
 fi
 
+# Remove old dependency files to make sure that they get properly regenerated
+rm -f *-config-devices.mak.d
+
 if ! has $python; then
   error_exit "Python not found. Use --python=/path/to/python"
 fi
-- 
1.8.3.1
