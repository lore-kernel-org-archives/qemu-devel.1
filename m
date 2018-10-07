Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pa-00055g-Fh
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pY-0007QK-G4
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pY-0007Pm-8U
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id z25-v6so6724027wmf.1
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:35 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:21 +0300
Message-Id: <20181007110223.129692-6-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 5/7] qga-win: install service with
 --retry-path set by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

It's nicer from a management perspective that the agent can survive
hotplug/unplug of the channel device, or be started prior to the
installation of the channel device's driver without and still be able
to resume normal function afterward. On linux there are alternatives
like systemd to support this, but on w32 --retry-path is the only
option so it makes sense to set it by default when installed as a
w32 service.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/installer/qemu-ga.wxs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index f751a7e9f7..64bf90bd85 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -78,7 +78,7 @@
               Account="LocalSystem"
               ErrorControl="ignore"
               Interactive="no"
-              Arguments="-d"
+              Arguments="-d --retry-path"
               >
             </ServiceInstall>
             <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="no" />
-- 
2.17.0
