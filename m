Received: from eggs.gnu.org ([2001:4830:134:3::10]:45819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGYD-0008Jq-LS
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGYC-0005IK-Ou
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:31:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 09:29:50 -0300
Message-Id: <20180608122952.2009-9-ehabkost@redhat.com>
In-Reply-To: <20180608122952.2009-1-ehabkost@redhat.com>
References: <20180608122952.2009-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/10] python: futurize -f
 lib2to3.fixes.fix_renames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Change sys.maxint to sys.maxsize.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_renames $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/runner.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 45e8fca63f..95d84f38f3 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -128,7 +128,7 @@ class TestEnv(object):
         if seed is not None:
             self.seed = seed
         else:
-            self.seed = str(random.randint(0, sys.maxint))
+            self.seed = str(random.randint(0, sys.maxsize))
         random.seed(self.seed)
 
         self.init_path = os.getcwd()
-- 
2.18.0.rc1.1.g3f1ff2140
