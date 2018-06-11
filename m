Received: from eggs.gnu.org ([2001:4830:134:3::10]:60654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqN-0001sq-T8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqN-0000Ic-2x
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqM-0000IO-Tn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:38 -0300
Message-Id: <20180611174243.31070-9-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] python: futurize -f
 lib2to3.fixes.fix_renames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Change sys.maxint to sys.maxsize.

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f lib2to3.fixes.fix_renames $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-9-ehabkost@redhat.com>
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
