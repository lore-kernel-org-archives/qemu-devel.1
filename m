Received: from eggs.gnu.org ([2001:4830:134:3::10]:47283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOH-0007Vl-3X
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOD-0006vJ-DL
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOD-0006un-8A
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:17 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EF2A811A2
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:08 +0100
Message-Id: <1480956313-31322-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] qga/schema: fix double-return in doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

guest-get-memory-block-info documentation should have only one
"Returns:".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20161117155504.21843-3-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c21f308..758803a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -952,7 +952,6 @@
 #
 # Get information relating to guest memory blocks.
 #
-# Returns: memory block size in bytes.
 # Returns: @GuestMemoryBlockInfo
 #
 # Since 2.3
--=20
2.5.5
