Received: from eggs.gnu.org ([2001:4830:134:3::10]:54017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZot-0000IB-QK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZor-0004hT-SJ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:07 -0400
Received: from mail.kernel.org ([198.145.29.136]:46648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnZor-0004hF-Kf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:56:05 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 13 Mar 2017 16:55:52 -0700
Message-Id: <1489449360-14411-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PATCH v2 1/9] configure: change CONFIG_XEN_BACKEND to
 be a target property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, pbonzini@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, stefanha@redhat.com

CONFIG_XEN_BACKEND is currently set when the host supports Xen,
regardless of the chosen targets. As a consequence, Xen backends can be
enabled even on targets that don't support Xen.

Fix the issue by setting CONFIG_XEN_BACKEND only for targets that
support Xen.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
CC: groug@kaod.org
CC: groug@kaod.org
CC: pbonzini@redhat.com
CC: peter.maydell@linaro.org
CC: rth@twiddle.net
CC: stefanha@redhat.com
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 6c21975..6d8f752 100755
--- a/configure
+++ b/configure
@@ -5442,7 +5442,6 @@ if test "$virglrenderer" = "yes" ; then
   echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
 fi
 if test "$xen" = "yes" ; then
-  echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
   if test "$xen_pv_domain_build" = "yes" ; then
     echo "CONFIG_XEN_PV_DOMAIN_BUILD=y" >> $config_host_mak
@@ -6028,6 +6027,7 @@ case "$target_name" in
   i386|x86_64)
     if test "$xen" = "yes" -a "$target_softmmu" = "yes" ; then
       echo "CONFIG_XEN=y" >> $config_target_mak
+      echo "CONFIG_XEN_BACKEND=y" >> $config_target_mak
       if test "$xen_pci_passthrough" = yes; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
       fi
-- 
1.9.1
