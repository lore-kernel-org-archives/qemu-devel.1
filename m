Received: from eggs.gnu.org ([2001:4830:134:3::10]:35730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ff9e6-0005bq-Tz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ff9e3-000119-2Z
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:58:59 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 16 Jul 2018 21:47:37 +0200
Message-Id: <20180716195851.0FE177456B7@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] Do not enable QOM debugging by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Commit 3556c233d 5 years ago added an option to disable QOM debugging,
noting that it can have high performance cost but left the default to on.
Change the default to off and only enable it when debugging is requested
to avoid the performance penalty for those compiling without debug options.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2a7796e..a8fc1ed 100755
--- a/configure
+++ b/configure
@@ -415,7 +415,7 @@ bsd_user="no"
 blobs="yes"
 pkgversion=""
 pie=""
-qom_cast_debug="yes"
+qom_cast_debug="no"
 trace_backends="log"
 trace_file="trace"
 spice=""
@@ -1062,6 +1062,7 @@ for opt do
       debug_tcg="yes"
       debug_mutex="yes"
       debug="yes"
+      qom_cast_debug="yes"
       strip_opt="no"
       fortify_source="no"
   ;;
-- 
2.7.6
