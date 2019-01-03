Received: from eggs.gnu.org ([208.118.235.92]:34411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22C-0005FY-F5
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22B-0004Dl-0V
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:36 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1gf22A-0004Co-R1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so33350988wrt.13
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 04:23:33 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Thu,  3 Jan 2019 14:23:22 +0200
Message-Id: <20190103122323.1273034-4-basil@daynix.com>
In-Reply-To: <20190103122323.1273034-1-basil@daynix.com>
References: <20190103122323.1273034-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH 3/4] qga: Installer: Wait for installation to
 finish
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
