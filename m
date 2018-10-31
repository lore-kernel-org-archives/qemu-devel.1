Received: from eggs.gnu.org ([2001:4830:134:3::10]:60472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfV6-0000ht-VN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUy-0002MC-Rq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:49 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUy-0002Lv-GC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:44 -0400
Received: by mail-qt1-x82d.google.com with SMTP id l9-v6so15948097qtj.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:44 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:19 -0500
Message-Id: <20181031013821.24023-23-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 22/24] qga-win: install service with
 --retry-path set by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

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
2.17.1
