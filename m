Received: from eggs.gnu.org ([209.51.188.92]:45810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RPn-0003mP-JX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RPm-0004kf-Oj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:51 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:9550 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RPm-0004hf-CJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:50 -0400
Date: Mon, 11 Mar 2019 20:20:51 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311202051.GE9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 5/9] qemu-binfmt-conf.sh: remove 'qemu'
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 35f61d9a6c..124866246f 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -167,6 +167,7 @@ qemu_get_family() {

 usage() {
     cat <<EOF
+
 Usage: qemu-binfmt-conf.sh [options]

 Configure binfmt_misc to use qemu interpreter
@@ -175,8 +176,8 @@ Options and associated environment variables:

 Argument             Env-variable     Description
 -h|--help                             display this usage
--Q|--qemu-path PATH  QEMU_PATH        set path to qemu interpreter
--F|--qemu-suffix SUFFIX               add a suffix to the default interpreter name
+-Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
+-F|--suffix SUFFIX                    add a suffix to the default interpreter name
 -p|--persistent      QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
                                       uses are cloned from the open file.
 -c|--credential      QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
@@ -329,7 +330,7 @@ QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"

 QEMU_SUFFIX=""

-options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"

 while true ; do
@@ -361,11 +362,11 @@ while true ; do
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
2.21.0
