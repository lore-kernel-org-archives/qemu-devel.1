Received: from eggs.gnu.org ([209.51.188.92]:35712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3I9v-0006Bs-4I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3I9u-0008UG-4r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:27:51 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:44920 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3I9t-0008Kt-Nu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:27:50 -0400
Date: Mon, 11 Mar 2019 10:27:33 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311102733.GC16@765644dd90e5>
References: <20190311101428.GA11@765644dd90e5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311101428.GA11@765644dd90e5>
Subject: [Qemu-devel] [PATCH v4 4/10] qemu-binfmt-conf.sh: use the same
 presentation format as for qemu-*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com


Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 58 +++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index e7a714e22c..489d7d2326 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -167,47 +167,43 @@ qemu_get_family() {

 usage() {
     cat <<EOF
-Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential][--exportdir PATH]
-                           [--persistent][--qemu-suffix SUFFIX]
+Usage: qemu-binfmt-conf.sh [options]

-       Configure binfmt_misc to use qemu interpreter
+Configure binfmt_misc to use qemu interpreter

-       --help:        display this usage
-       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
-       --qemu-suffix: add a suffix to the default interpreter name
-       --debian:      don't write into /proc,
-                      instead generate update-binfmts templates
-       --systemd:     don't write into /proc,
-                      instead generate file for systemd-binfmt.service
-                      for the given CPU. If CPU is "ALL", generate a
-                      file for all known cpus
-       --exportdir:   define where to write configuration files
-                      (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential:  if present, credential and security tokens are
-                      calculated according to the binary to interpret
-                      ($QEMU_CREDENTIAL=yes)
-       --persistent:  if present, the interpreter is loaded when binfmt is
-                      configured and remains in memory. All future uses
-                      are cloned from the open file.
-                      ($QEMU_PERSISTENT=yes)
+Options and associated environment variables:

-    To import templates with update-binfmts, use :
+Argument             Env-variable     Description
+-h|--help                             display this usage
+-Q|--qemu-path PATH: QEMU_PATH        set path to qemu interpreter
+-F|--qemu-suffix SUFFIX:              add a suffix to the default interpreter name
+-d|--debian:                          don't write into /proc, generate update-binfmts templates
+-s|--systemd CPU:                     don't write into /proc, generate file for
+                                      systemd-binfmt.service for the given CPU; if CPU is "ALL",
+                                      generate a file for all known cpus.
+-e|--exportdir PATH: DEBIANDIR        define where to write configuration files
+                     SYSTEMDDIR
+-c|--credential:     QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
+                                      to the binary to interpret
+-p|--persistent:     QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
+                                      uses are cloned from the open file.

-        sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU
+To import templates with update-binfmts, use :

-    To remove interpreter, use :
+    sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU

-        sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
+To remove interpreter, use :

-    With systemd, binfmt files are loaded by systemd-binfmt.service
+    sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH

-    The environment variable HOST_ARCH allows to override 'uname' to generate
-    configuration files for a different architecture than the current one.
+With systemd, binfmt files are loaded by systemd-binfmt.service

-    where CPU is one of:
+The environment variable HOST_ARCH allows to override 'uname' to generate configuration files for a
+different architecture than the current one.

-        $qemu_target_list
+where CPU is one of:
+
+    $qemu_target_list

 EOF
 }
--
2.21.0
