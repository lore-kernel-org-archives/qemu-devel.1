Received: from eggs.gnu.org ([2001:4830:134:3::10]:59765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d6OP2-00037L-Hx
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d6OP1-0008NY-TD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:35:12 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Thu,  4 May 2017 17:35:00 -0400
Message-Id: <de25b9a195ff29f7d4bbaec5af4c2f98532d1b9c.1493933558.git.jcody@redhat.com>
In-Reply-To: <cover.1493933558.git.jcody@redhat.com>
References: <cover.1493933558.git.jcody@redhat.com>
In-Reply-To: <cover.1493933558.git.jcody@redhat.com>
References: <cover.1493933558.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block/vxhs: Allow VXHS to be built as a
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, ashmit602@gmail.com, stefanha@redhat.com

In 88d8879, protocol drivers had modularization enabled.  As VXHS is a
protocol, make sure it is able to be built as a module as well.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 48a9370..eada141 100755
--- a/configure
+++ b/configure
@@ -5859,7 +5859,7 @@ if test "$pthread_setname_np" = "yes" ; then
 fi
 
 if test "$vxhs" = "yes" ; then
-  echo "CONFIG_VXHS=y" >> $config_host_mak
+  echo "CONFIG_VXHS=m" >> $config_host_mak
   echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
 fi
 
-- 
2.9.3
