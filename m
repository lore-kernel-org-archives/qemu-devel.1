Received: from eggs.gnu.org ([2001:4830:134:3::10]:42426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3MtH-0003mM-Ef
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3MtD-0008PH-H0
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:21:55 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:38337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3MtD-0008P2-AQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:21:51 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CE78FE99FC
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:21:49 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 26 Apr 2017 15:21:46 +0200
Message-ID: <149321290672.6890.14889421479138766387.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] configure: fix trace backend list for
 out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Since commit "c53eeaf75a04 configure: eliminate Python dependency for
--help", configure --help fails to produce the list of available trace
backends if invoked out-of-tree. It also spits the following error:

grep: scripts/tracetool/backend/*.py: No such file or directory

This patch simply adds the missing $source_path to fix it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 configure |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index c35acf119261..96847b092c8d 100755
--- a/configure
+++ b/configure
@@ -1271,7 +1271,7 @@ for config in $mak_wilds; do
 done
 
 # Enumerate public trace backends for --help output
-trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
+trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' $source_path/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
 
 if test x"$show_help" = x"yes" ; then
 cat << EOF
