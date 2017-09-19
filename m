Received: from eggs.gnu.org ([2001:4830:134:3::10]:40436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLfD-0007iC-SQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLfD-0004Lq-4y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLfC-0004LJ-Vw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:23 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:33 +0200
Message-Id: <20170919164337.18555-35-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 34/38] configure: Allow --enable-seccomp on
 s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

libseccomp supports s390x since version 2.3.0, and I was able to start
a VM with "-sandbox on" without any obvious problems by using this patch,
so it should be safe to allow --enable-seccomp on s390x nowadays, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1505385363-27717-1-git-send-email-thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 94db2d103e..cb0f7ed0ab 100755
--- a/configure
+++ b/configure
@@ -2025,7 +2025,7 @@ if test "$seccomp" != "no" ; then
     arm|aarch64)
         libseccomp_minver="2.2.3"
         ;;
-    ppc|ppc64)
+    ppc|ppc64|s390x)
         libseccomp_minver="2.3.0"
         ;;
     *)
-- 
2.13.5
