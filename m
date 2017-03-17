Received: from eggs.gnu.org ([2001:4830:134:3::10]:60716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1copDX-0004ub-5H
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1copDT-0002yw-64
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:34:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1copDT-0002yj-0P
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:34:39 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 17 Mar 2017 11:34:32 +0100
Message-Id: <1489746872-10327-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] configure: Warn that the support for
 ia64 is going to be removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, aurelien@aurel32.net
Cc: rth@twiddle.net, berrange@redhat.com

Access to an ia64 machine is hard to get these days, and we lack a
machine for continuous integration testing, so it is very likely
that we remove support for the ia64 TCG backend soon.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index 99d8bec..3ff8999 100755
--- a/configure
+++ b/configure
@@ -499,6 +499,11 @@ elif check_define __mips__ ; then
   cpu="mips"
 elif check_define __ia64__ ; then
   cpu="ia64"
+  echo "*** Note: The QEMU Project intends to drop support for ia64 in a near"
+  echo "*** future release since we do not have a machine for continuous"
+  echo "*** integration testing. Please get in touch via qemu-devel@nongnu.org"
+  echo "*** if you want to maintain support and can provide a test machine."
+  sleep 10
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
-- 
1.8.3.1
