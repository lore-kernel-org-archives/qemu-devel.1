Received: from eggs.gnu.org ([209.51.188.92]:41114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JTa-0001aO-HJ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JTZ-0002P5-Tu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h2JTZ-0002N6-Mt
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F20E730EBE76
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 17:40:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  8 Mar 2019 11:39:57 -0600
Message-Id: <20190308173958.20618-4-eblake@redhat.com>
In-Reply-To: <20190308173958.20618-1-eblake@redhat.com>
References: <20190308173958.20618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] nbd: fix outdated qapi docs syntax for
 tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190227162035.18543-4-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block.json b/qapi/block.json
index 79623088e72..145c268bb64 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -224,7 +224,7 @@
 # QEMU instance could refer to them as "nbd:HOST:PORT:exportname=3DNAME"=
.
 #
 # @addr: Address on which to listen.
-# @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
+# @tls-creds: ID of the TLS credentials object (since 2.6).
 # @tls-authz: ID of the QAuthZ authorization object used to validate
 #             the client's x509 distinguished name. This object is
 #             is only resolved at time of use, so can be deleted and
--=20
2.20.1
