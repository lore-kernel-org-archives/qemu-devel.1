Received: from eggs.gnu.org ([2001:4830:134:3::10]:41328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSJ1-0008Qe-I3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIy-00010W-CI
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49052
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIy-00010L-6T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnCv3079645
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:43 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k0eqakyc2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:43 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:42 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:14 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-8-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 07/14] qga-win: Fixing msi upgrade disallow in
 WiX file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bishara AbuHattoum <bishara@daynix.com>

From: Bishara AbuHattoum <bishara@daynix.com>

Issue: When upgrading qemu-ga using the msi from an old version
       to a newer one, the upgrade is not allowed by the msi
       showing this error message "Another version of this product
       is already installed."

BZ# 1536331: https://bugzilla.redhat.com/show_bug.cgi?id=1536331

Fix: For the upgrade to be allowed by the msi the WiX file must
     provide three things:
      1. Changing product's Id. (assigning it to "*")
      2. Constant product's UpgradeId. (exists)
      3. Changing version. (exists)

Reference: http://wixtoolset.org/documentation/manual/v3/howtos/updates/major_upgrade.html

Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/installer/qemu-ga.wxs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 5af11627f8..f751a7e9f7 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -41,7 +41,7 @@
 
   <Product
     Name="QEMU guest agent"
-    Id="{DF9974AD-E41A-4304-81AD-69AA8F299766}"
+    Id="*"
     UpgradeCode="{EB6B8302-C06E-4BEC-ADAC-932C68A3A98D}"
     Manufacturer="$(env.QEMU_GA_MANUFACTURER)"
     Version="$(env.QEMU_GA_VERSION)"
-- 
2.11.0
