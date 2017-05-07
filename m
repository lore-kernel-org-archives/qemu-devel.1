Received: from eggs.gnu.org ([2001:4830:134:3::10]:58096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Go1-0001Ph-Fe
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Gny-00071x-Cs
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:08 +0300
Message-Id: <46bbbec2d30c3d791a6d328e5ef861694ff3eafb.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 05/23] tests: Ignore more test executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eric Blake <eblake@redhat.com>

Ignore test executables when building in-tree:
test-arm-mptimer introduced in commit 882fac3
test-crypto-hmac introduced in commit 4fd460b
test-aio-multithread introduced in commit 0c330a7

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index a966740c2c..5ab00a9c95 100644
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
2.11.0
