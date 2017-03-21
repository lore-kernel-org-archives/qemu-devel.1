Received: from eggs.gnu.org ([2001:4830:134:3::10]:45063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqIVo-0005Te-JT
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqIVl-0004Di-RE
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:03:40 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqIVl-0004CB-Jc
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:03:37 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11so2517077wma.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 05:03:37 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 21 Mar 2017 14:03:26 +0200
Message-Id: <20170321120326.10011-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH qemu-ga] Start VSS Provider after install
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

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/vss-win32/install.cpp | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index f4160a3..7e38332 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -307,6 +307,7 @@ STDAPI COMRegister(void)
     chk(put_Value(pObj, L"User", L"SYSTEM"));
     chk(pUsersInRole->SaveChanges(&n));
 
+    chk(pCatalog->StartApplication(_bstr_t(QGA_PROVIDER_LNAME)));
 out:
     if (unregisterOnFailure && FAILED(hr)) {
         COMUnregister();
-- 
2.9.3
