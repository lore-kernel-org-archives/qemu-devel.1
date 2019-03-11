Received: from eggs.gnu.org ([209.51.188.92]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IDh-0000sj-HN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3IDf-00029x-J5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:31:45 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:2981 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3IDd-00025A-Jj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:31:43 -0400
Date: Mon, 11 Mar 2019 10:31:40 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311103140.GH16@765644dd90e5>
References: <20190311101428.GA11@765644dd90e5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311101428.GA11@765644dd90e5>
Subject: [Qemu-devel] [PATCH v4 9/10] qemu-binfmt-conf.sh: update usage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, eblake@redhat.com, alex.bennee@linaro.org

Reorder how the options are presented to the user. Move 'systemd'
and 'debian' to the end, so that the latter is close to the additional
comments and example commands about it.

Add list of default values for environment variables.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 07d1ee1f04..a516181a3a 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -201,19 +201,27 @@ TARGETS              QEMU_TARGETS     A single arch name or a list of them (see
 -h|--help                             display this usage
 -Q|--path PATH:      QEMU_PATH        set path to qemu interpreter(s)
 -F|--suffix SUFFIX:  QEMU_SUFFIX      add a suffix to the default interpreter name
--d|--debian:                          don't write into /proc, generate update-binfmts templates
--s|--systemd:                         don't write into /proc, generate file(s) for
-                                      systemd-binfmt.service; environment variable HOST_ARCH
-                                      allows to override 'uname' to generate configuration files
-                                      for a different architecture than the current one.
+-p|--persistent:     QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
+                                      uses are cloned from the open file.
+-c|--credential:     QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
+                                      to the binary to interpret
 -e|--exportdir PATH: DEBIANDIR        define where to write configuration files
                      SYSTEMDDIR
 -c|--clear:          QEMU_CLEAR       (yes) remove registered interpreters for target TARGETS;
                                       then exit.
--c|--credential:     QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
-                                      to the binary to interpret
--p|--persistent:     QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
-                                      uses are cloned from the open file.
+-s|--systemd:                         don't write into /proc, generate file(s) for
+                                      systemd-binfmt.service; environment variable HOST_ARCH
+                                      allows to override 'uname' to generate configuration files
+                                      for a different architecture than the current one.
+-d|--debian:                          don't write into /proc, generate update-binfmts templates
+
+Defaults:
+QEMU_TARGETS=$QEMU_TARGETS
+QEMU_PATH=$QEMU_PATH
+QEMU_SUFFIX=$QEMU_SUFFIX
+QEMU_PERSISTENT=$QEMU_PERSISTENT
+QEMU_CREDENTIAL=$QEMU_CREDENTIAL
+QEMU_CLEAR=$QEMU_CLEAR

 To import templates with update-binfmts, use :

@@ -365,8 +373,8 @@ DEBIANDIR="/usr/share/binfmts"
 QEMU_TARGETS="${QEMU_TARGETS:-}"
 QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
 QEMU_SUFFIX="${QEMU_SUFFIX:-}"
-QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
+QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_CLEAR="${QEMU_CLEAR:-no}"

 options=$(getopt -o cdsQ:S:e:hcp -l clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
--
2.21.0
