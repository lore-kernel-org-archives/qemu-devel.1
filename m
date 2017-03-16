Received: from eggs.gnu.org ([2001:4830:134:3::10]:56314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coTSE-0000tY-AL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coTSB-0006PN-73
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coTSB-0006PD-0b
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:20:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D91693DBEF
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 11:20:22 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 16 Mar 2017 11:20:16 +0000
Message-Id: <20170316112016.26450-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] List SASL config file under the cryptography
 maintainer's realm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

No one is listed as maintainer for qemu.sasl. It is used by the
VNC server for SASL auth, but since it is cryptography related,
list it under the crytography maintainer's realm, rather than
under the UI maintainer.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf1aafb..ecf8273 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1462,6 +1462,7 @@ S: Maintained
 F: crypto/
 F: include/crypto/
 F: tests/test-crypto-*
+F: qemu.sasl
 
 Coroutines
 M: Stefan Hajnoczi <stefanha@redhat.com>
-- 
2.9.3
