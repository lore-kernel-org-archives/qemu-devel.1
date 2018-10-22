Received: from eggs.gnu.org ([2001:4830:134:3::10]:33348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVtE-0003H2-17
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVt9-0008C5-3P
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:43 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:12245)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVt8-00084O-91
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:38 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 22 Oct 2018 16:48:23 +0800
Message-Id: <20181022084824.555-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
References: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/2] debian-bootstrap.pre: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, alex.bennee@linaro.org, famz@redhat.com, philmd@redhat.com

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

Cc: alex.bennee@linaro.org
Cc: famz@redhat.com
Cc: philmd@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index 3b0ef95374..c164778c30 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -2,7 +2,7 @@
 #
 # Simple wrapper for debootstrap, run in the docker build context
 #
-FAKEROOT=`which fakeroot 2> /dev/null`
+FAKEROOT=$(which fakeroot 2> /dev/null)
 # debootstrap < 1.0.67 generates empty sources.list, see Debian#732255
 MIN_DEBOOTSTRAP_VERSION=1.0.67
 
@@ -52,7 +52,7 @@ fi
 
 if [ -z $DEBOOTSTRAP_DIR ]; then
     NEED_DEBOOTSTRAP=false
-    DEBOOTSTRAP=`which debootstrap 2> /dev/null`
+    DEBOOTSTRAP=$(which debootstrap 2> /dev/null)
     if [ -z $DEBOOTSTRAP ]; then
         echo "No debootstrap installed, attempting to install from SCM"
         NEED_DEBOOTSTRAP=true
-- 
2.17.1
