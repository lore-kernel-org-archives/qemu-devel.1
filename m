Received: from eggs.gnu.org ([209.51.188.92]:36714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1OUZ-0008U5-0T
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1OUY-0003UG-23
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:49:18 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:31891 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1OUX-0003TB-NR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 23:49:18 -0500
Date: Wed, 6 Mar 2019 04:49:14 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190306044914.GD75@03612eec87fc>
References: <20190306031221.GA53@03612eec87fc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306031221.GA53@03612eec87fc>
Subject: [Qemu-devel] [PATCH v3 4/10] qemu-binfmt-conf.sh: remove 'qemu'
 prefix from cli options
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

This breaks backward compatibility.

Options 'qemu-path' and 'qemu-suffix' have the 'qemu-' prefix, which is
not present in other option names ('debian', 'systemd', 'persistent',
'credential'...). In order to keep consistency, the prefix is removed.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index e7a714e22c..68aa4c3f78 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -167,15 +167,15 @@ qemu_get_family() {

 usage() {
     cat <<EOF
-Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
+Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd CPU]
                            [--help][--credential][--exportdir PATH]
-                           [--persistent][--qemu-suffix SUFFIX]
+                           [--persistent][--suffix SUFFIX]

        Configure binfmt_misc to use qemu interpreter

        --help:        display this usage
-       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
-       --qemu-suffix: add a suffix to the default interpreter name
+       --path:        set path to qemu interpreter ($QEMU_PATH)
+       --suffix:      add a suffix to the default interpreter name
        --debian:      don't write into /proc,
                       instead generate update-binfmts templates
        --systemd:     don't write into /proc,
@@ -328,7 +328,7 @@ QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"

 QEMU_SUFFIX=""

-options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
@@ -360,11 +360,11 @@ while true ; do
             fi
         fi
         ;;
-    -Q|--qemu-path)
+    -Q|--path)
         shift
         QEMU_PATH="$1"
         ;;
-    -F|--qemu-suffix)
+    -F|--suffix)
         shift
         QEMU_SUFFIX="$1"
         ;;
--
2.20.1
