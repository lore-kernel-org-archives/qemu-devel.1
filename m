Received: from eggs.gnu.org ([209.51.188.92]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RPc-0003Iq-Jm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3RMJ-00063D-8g
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:17:16 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:52062 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3RMI-000610-UC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:17:15 -0400
Date: Mon, 11 Mar 2019 20:17:10 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Message-ID: <20190311201710.GA9@59ca1d9b7985>
References: <20190311201532.GA6@59ca1d9b7985>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311201532.GA6@59ca1d9b7985>
Subject: [Qemu-devel] [PATCH v5 1/9] qemu-binfmt-conf.sh: enforce safe style
 consistency
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

Spaces are added before '; then', for consistency.

All the tests are prefixed with 'x', in order to avoid risky comparisons
(i.e. a user deliberately trying to provoke a syntax error).

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..0009385be2 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -219,12 +219,12 @@ qemu_check_access() {

 qemu_check_bintfmt_misc() {
     # load the binfmt_misc module
-    if [ ! -d /proc/sys/fs/binfmt_misc ]; then
+    if [ ! -d /proc/sys/fs/binfmt_misc ] ; then
       if ! /sbin/modprobe binfmt_misc ; then
           exit 1
       fi
     fi
-    if [ ! -f /proc/sys/fs/binfmt_misc/register ]; then
+    if [ ! -f /proc/sys/fs/binfmt_misc/register ] ; then
       if ! mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc ; then
           exit 1
       fi
@@ -255,10 +255,10 @@ qemu_check_systemd() {

 qemu_generate_register() {
     flags=""
-    if [ "$CREDENTIAL" = "yes" ] ; then
+    if [ "x$CREDENTIAL" = "xyes" ] ; then
         flags="OC"
     fi
-    if [ "$PERSISTENT" = "yes" ] ; then
+    if [ "x$PERSISTENT" = "xyes" ] ; then
         flags="${flags}F"
     fi

@@ -296,18 +296,18 @@ qemu_set_binfmts() {
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)

-        if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ] ; then
+        if [ "x$magic" = "x" ] || [ "x$mask" = "x" ] || [ "x$family" = "x" ] ; then
             echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
             continue
         fi

         qemu="$QEMU_PATH/qemu-$cpu"
-        if [ "$cpu" = "i486" ] ; then
+        if [ "x$cpu" = "xi486" ] ; then
             qemu="$QEMU_PATH/qemu-i386"
         fi

         qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ] ; then
+        if [ "x$host_family" != "x$family" ] ; then
             $BINFMT_SET
         fi
     done
--
2.21.0
