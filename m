Received: from eggs.gnu.org ([209.51.188.92]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RPI-0003Iq-RF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3ROy-0003EE-NR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:01 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:16725 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3ROy-00039X-BO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:00 -0400
Date: Mon, 11 Mar 2019 20:20:01 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311202001.GD9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 4/9] qemu-binfmt-conf.sh: use the same
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
 scripts/qemu-binfmt-conf.sh | 63 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index ad9ae731a0..35f61d9a6c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -167,47 +167,48 @@ qemu_get_family() {

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
+-Q|--qemu-path PATH  QEMU_PATH        set path to qemu interpreter
+-F|--qemu-suffix SUFFIX               add a suffix to the default interpreter name
+-p|--persistent      QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
+                                      uses are cloned from the open file.
+-c|--credential      QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
+                                      to the binary to interpret
+-e|--exportdir PATH  DEBIANDIR        define where to write configuration files
+                     SYSTEMDDIR
+-s|--systemd CPU                      don't write into /proc, generate file for
+                                      systemd-binfmt.service for the given CPU; if CPU is "ALL",
+                                      generate a file for all known cpus.
+-d|--debian                           don't write into /proc, generate update-binfmts templates

-        sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU
+Defaults:
+QEMU_PATH=$QEMU_PATH
+QEMU_PERSISTENT=$QEMU_PERSISTENT
+QEMU_CREDENTIAL=$QEMU_CREDENTIAL

-    To remove interpreter, use :
+To import templates with update-binfmts, use :

-        sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
+    sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU

-    With systemd, binfmt files are loaded by systemd-binfmt.service
+To remove interpreter, use :

-    The environment variable HOST_ARCH allows to override 'uname' to generate
-    configuration files for a different architecture than the current one.
+    sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH

-    where CPU is one of:
+With systemd, binfmt files are loaded by systemd-binfmt.service

-        $qemu_target_list
+The environment variable HOST_ARCH allows to override 'uname' to generate configuration files for a
+different architecture than the current one.
+
+where CPU is one of:
+
+    $qemu_target_list

 EOF
 }
--
2.21.0
