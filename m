Received: from eggs.gnu.org ([2001:4830:134:3::10]:44927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVCUm-0000GY-NM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVCUl-00008p-Tb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVCUl-00007X-G4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 12 Jul 2017 15:55:27 +0800
Message-Id: <20170712075528.22770-2-famz@redhat.com>
In-Reply-To: <20170712075528.22770-1-famz@redhat.com>
References: <20170712075528.22770-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] docker.py: Drop infile parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The **kwargs can do this just well.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e707e5b..f5ac86b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -112,11 +112,9 @@ class Docker(object):
         signal.signal(signal.SIGTERM, self._kill_instances)
         signal.signal(signal.SIGHUP, self._kill_instances)
 
-    def _do(self, cmd, quiet=True, infile=None, **kwargs):
+    def _do(self, cmd, quiet=True, **kwargs):
         if quiet:
             kwargs["stdout"] = DEVNULL
-        if infile:
-            kwargs["stdin"] = infile
         return subprocess.call(self._command + cmd, **kwargs)
 
     def _do_kill_instances(self, only_known, only_active=True):
@@ -184,7 +182,7 @@ class Docker(object):
     def update_image(self, tag, tarball, quiet=True):
         "Update a tagged image using "
 
-        self._do(["build", "-t", tag, "-"], quiet=quiet, infile=tarball)
+        self._do(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
 
     def image_matches_dockerfile(self, tag, dockerfile):
         try:
-- 
2.9.4
