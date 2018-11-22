Received: from eggs.gnu.org ([2001:4830:134:3::10]:37056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFP-0001h1-9C
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFN-0000lC-MM
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:07 +0100
Message-Id: <20181122165417.23894-4-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/13] iotests: Skip 233 if certtool not
 installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The use of TLS while building qemu is optional. While the
'certtool' binary should be available on every platform that
supports building against TLS, that does not imply that the
developer has installed it.  Make the test gracefully skip
in that case.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.tls | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
index 39f17c1b99..eae81789bb 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -31,6 +31,9 @@ tls_x509_cleanup()
=20
 tls_x509_init()
 {
+    (certtool --help) >/dev/null 2>&1 || \
+	_notrun "certtool utility not found, skipping test"
+
     mkdir -p "${tls_dir}"
=20
     # use a fixed key so we don't waste system entropy on
--=20
2.19.1
