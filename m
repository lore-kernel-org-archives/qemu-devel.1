Received: from eggs.gnu.org ([2001:4830:134:3::10]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1fYYNO-0000Mx-3f
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1fYYNJ-0007Uk-R0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:58:26 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:44984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1fYYNJ-0007RZ-Ib
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:58:21 -0400
Received: by mail-wr0-x22b.google.com with SMTP id p12-v6so5839971wrn.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:58:21 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Thu, 28 Jun 2018 17:58:16 +0300
Message-Id: <20180628145816.30339-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v3] qga-win: Fixing msi upgrade disallow in WiX
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

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
2.13.6
