Received: from eggs.gnu.org ([2001:4830:134:3::10]:59928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPVtJ-0002vt-Lo
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPVtI-0000fw-RQ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:25:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dPVtI-0000fG-ID
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:25:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 16:25:24 +0100
Message-Id: <1498490724-20674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] configure: Handle having no c++ compiler in
 FORTIFY_SOURCE check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Our FORTIFY_SOURCE check assumes that $cxx refers to a working C++
compiler, with the result that if you don't happen to have one
then configure will spuriously print
  configure: line 4685: c++: command not found

Fix this by adding a 'has $cxx' check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index c571ad1..a435908 100755
--- a/configure
+++ b/configure
@@ -4681,7 +4681,7 @@ fi
 if test "$fortify_source" != "no"; then
   if echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
     fortify_source="no";
-  elif test -n "$cxx" &&
+  elif test -n "$cxx" && has $cxx &&
        echo | $cxx -dM -E - | grep __clang__ >/dev/null 2>&1 ; then
     fortify_source="no";
   else
-- 
2.7.4
