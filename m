Received: from eggs.gnu.org ([2001:4830:134:3::10]:39456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dxsGe-0000Jz-53
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dxsGZ-0008EA-8L
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:11:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dxsGZ-0008DP-29
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:11:31 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 29 Sep 2017 13:11:14 +0300
Message-id: <1506679874-22284-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1506679874-22284-1-git-send-email-a.perevalov@samsung.com>
References: <1506679874-22284-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170929101125eucas1p1ed4a290bfc6fcbf6f492fc45d4e9cc10@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH] configure: correctly define PTHREAD_LIB
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, heetae82.ahn@samsung.com, Alexey Perevalov <a.perevalov@samsung.com>, berrange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
List-ID: <qemu-devel.nongnu.org>

In case of -pthread already exists in QEMU_CFLAGS,
compilation of sample pthread program successed,
but -pthread is not putting into PTHREAD_LIBS in this case.
PTHREAD_LIB is using while compiling tests/migration/stress.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 6587e80..a2dd044 100755
--- a/configure
+++ b/configure
@@ -3359,6 +3359,7 @@ int main(void) {
 EOF
 if compile_prog "" "" ; then
   pthread=yes
+  PTHREAD_LIB="-pthread"
 else
   for pthread_lib in $PTHREADLIBS_LIST; do
     if compile_prog "" "$pthread_lib" ; then
-- 
2.7.4
