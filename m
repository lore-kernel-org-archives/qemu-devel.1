Received: from eggs.gnu.org ([209.51.188.92]:59247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5M-00083D-Qj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5I-0004uy-Sl
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:53 +0100
Message-Id: <20190308125823.32535-4-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/33] iotests: open notrun files in text mode
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

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Replace the binary mode with the default text one when *.notrun
files are opened for skipped tests. That change is made for the
compatibility with Python 3 which returns error otherwise.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 3d15571688..46fad4ce81 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -712,7 +712,7 @@ def notrun(reason):
     # Each test in qemu-iotests has a number ("seq")
     seq =3D os.path.basename(sys.argv[0])
=20
-    open('%s/%s.notrun' % (output_dir, seq), 'wb').write(reason + '\n')
+    open('%s/%s.notrun' % (output_dir, seq), 'w').write(reason + '\n')
     print('%s not run: %s' % (seq, reason))
     sys.exit(0)
=20
--=20
2.20.1
