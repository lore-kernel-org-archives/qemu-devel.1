Received: from eggs.gnu.org ([2001:4830:134:3::10]:51928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cldJl-0008E5-18
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cldJh-0004a8-Ke
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:15:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Mar 2017 09:15:44 -0600
Message-Id: <20170308151544.7606-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9? v2] tests: Ignore more test executables
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

Ignore test executables when building in-tree:
test-arm-mptimer introduced in commit 882fac3
test-crypto-hmac introduced in commit 4fd460b
test-aio-multithread introduced in commit 0c330a7

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v2: pick up another built binary [Laurent]

Doesn't affect the built binaries, but does make it harder to
accidentally commit an unintended binary when doing 'git add .'.
Therefore, it's up to the maintainer if this is 2.9 or 2.10
material.  (test-arm-mptimer has been around since the 2.8 release)

 tests/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index dc37519..73598b6 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -11,6 +11,8 @@ check-qom-proplist
 qht-bench
 rcutorture
 test-aio
+test-aio-multithread
+test-arm-mptimer
 test-base64
 test-bitops
 test-bitcnt
@@ -24,6 +26,7 @@ test-crypto-afsplit
 test-crypto-block
 test-crypto-cipher
 test-crypto-hash
+test-crypto-hmac
 test-crypto-ivgen
 test-crypto-pbkdf
 test-crypto-secret
-- 
2.9.3
