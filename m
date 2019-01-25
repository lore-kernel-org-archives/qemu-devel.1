Received: from eggs.gnu.org ([209.51.188.92]:56652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyKn-0005Kn-6w
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyKl-0006oM-TE
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:03:37 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:03:22 +0100
Message-Id: <1548410602-16008-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] decodetree: re.fullmatch was added in 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Python 3 versions earlier than 3.4 do not have it, use the
same workaround that is in place for 3.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 0bc73b5..e342d27 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -204,7 +204,7 @@ def output(*args):
         output_fd.write(a)
 
 
-if sys.version_info >= (3, 0):
+if sys.version_info >= (3, 4):
     re_fullmatch = re.fullmatch
 else:
     def re_fullmatch(pat, str):
-- 
1.8.3.1
