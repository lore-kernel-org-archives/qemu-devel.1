Received: from eggs.gnu.org ([2001:4830:134:3::10]:46608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z73-00009g-An
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z72-0006K9-Cr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z72-0006JY-5Y
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:28 -0400
Received: by mail-wr0-x243.google.com with SMTP id y55so13941448wry.3
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:02 +0100
Message-Id: <20180410193919.28026-8-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 07/24] docker: allow "cc" command to run in
 user context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9444f4bea4..f79213044d 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -399,6 +399,8 @@ class CcCommand(SubCommand):
                             help="The docker image in which to run cc")
         parser.add_argument("--cc",
                             help="The compiler executable to call")
+        parser.add_argument("--user",
+                            help="The user-id to run under")
         parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
                             help="""Extra paths to (ro) mount into container for
                             reading sources""")
@@ -414,6 +416,9 @@ class CcCommand(SubCommand):
             for p in args.paths:
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
 
+        if args.user:
+            cmd += ["-u", args.user]
+
         cmd += [args.image]
 
         # The compile command we are running
-- 
2.16.2
