Received: from eggs.gnu.org ([2001:4830:134:3::10]:54805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcU-0000hV-El
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcP-0005Qp-T9
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rcP-0005PQ-Kt
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNTaB6121461
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:18 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dusba08ak-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:18 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 19:31:16 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:53 -0500
In-Reply-To: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
References: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171026233054.21133-6-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/6] qga-win: install service with --retry-path
 set by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameeh@daynix.com, yan@daynix.com, daniel@daynix.com

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
index 5af11627f8..fb2273507f 100644
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
2.11.0
