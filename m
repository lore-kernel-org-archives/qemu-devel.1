Received: from eggs.gnu.org ([209.51.188.92]:48209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpeYT-00084W-Kn
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpeYS-0003uu-PI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:32:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Feb 2019 13:32:34 -0600
Message-Id: <20190201193234.20796-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: Ignore fp test outputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-trivial@nongnu.org

Commit 2cade3d wired up new tests, but did not exclude the
new *.out files produced by running the tests.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index 72c18aaab04..f2bf85c8c4c 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -5,6 +5,7 @@ benchmark-crypto-hmac
 check-*
 !check-*.c
 !check-*.sh
+fp/*.out
 qht-bench
 rcutorture
 test-*
--=20
2.20.1
