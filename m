Received: from eggs.gnu.org ([209.51.188.92]:33778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1giceK-0005m9-KV
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1giceJ-0003V3-Nz
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:48 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1giceJ-0003Tx-HO
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:47 -0500
Received: by mail-wm1-x343.google.com with SMTP id n190so6114425wmd.0
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 02:05:47 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Sun, 13 Jan 2019 12:05:30 +0200
Message-Id: <20190113100531.1346024-4-basil@daynix.com>
In-Reply-To: <20190113100531.1346024-1-basil@daynix.com>
References: <20190113100531.1346024-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH v2 3/4] qga: Installer: Wait for installation
 to finish
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>

Installation might fail if we don't wait for the provider
unregisteration process to finish.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/installer/qemu-ga.wxs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 64bf90bd85..f6781752e6 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -81,7 +81,7 @@
               Arguments="-d --retry-path"
               >
             </ServiceInstall>
-            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="no" />
+            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="yes" />
           </Component>
           <?ifdef var.InstallVss?>
           <Component Id="qga_vss_dll" Guid="{CB19C453-FABB-4BB1-ABAB-6B74F687BFBB}">
-- 
2.17.2
