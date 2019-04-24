Received: from eggs.gnu.org ([209.51.188.92]:53372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJEVX-0006f2-IF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJETb-00062b-8c
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJETb-00061e-3N
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:46:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Apr 2019 11:45:57 +0200
Message-Id: <20190424094557.28404-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/tpm-tests: Use g_test_skip() to mark
 skipped tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>
Cc: pbonzini@redhat.com, lvivier@redhat.com

Since we do not use gtester anymore (which had a bug here),
we can now use g_test_skip() to mark skipped tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tpm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
index 582ec0cfd4..e640777aa9 100644
--- a/tests/tpm-tests.c
+++ b/tests/tpm-tests.c
@@ -22,7 +22,7 @@ static bool
 tpm_test_swtpm_skip(void)
 {
     if (!tpm_util_swtpm_has_tpm2()) {
-        g_test_message("swtpm not in PATH or missing --tpm2 support");
+        g_test_skip("swtpm not in PATH or missing --tpm2 support");
         return true;
     }
=20
--=20
2.21.0
