Received: from eggs.gnu.org ([2001:4830:134:3::10]:35441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TQ-0008F6-EQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TP-0008Gf-OF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85TP-0008G6-Hp
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0699BC059740
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 13:46:42 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:46:21 +0100
Message-Id: <20170509134623.13120-3-berrange@redhat.com>
In-Reply-To: <20170509134623.13120-1-berrange@redhat.com>
References: <20170509134623.13120-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/4] List SASL config file under the
 cryptography maintainer's realm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

No one is listed as maintainer for qemu.sasl. It is used by the
VNC server for SASL auth, but since it is cryptography related,
list it under the crytography maintainer's realm, rather than
under the UI maintainer.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efdec47..b4d877b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1484,6 +1484,7 @@ S: Maintained
 F: crypto/
 F: include/crypto/
 F: tests/test-crypto-*
+F: qemu.sasl
 
 Coroutines
 M: Stefan Hajnoczi <stefanha@redhat.com>
-- 
2.9.3
