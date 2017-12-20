Received: from eggs.gnu.org ([2001:4830:134:3::10]:55664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029c-1b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaR-00060D-B3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaR-0005zG-2L
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C18C883BA
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB7BD18E3E
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:12 +0100
Message-Id: <20171220185924.32756-2-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] qapi-schema: Fix query-vm-generation-id's
 doc comment markup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reported-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-2-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..ea3723f903 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3188,7 +3188,7 @@
 #
 # Show Virtual Machine Generation ID
 #
-# Since 2.9
+# Since: 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
=20
--=20
2.13.6
