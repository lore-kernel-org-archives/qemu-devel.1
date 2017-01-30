Received: from eggs.gnu.org ([2001:4830:134:3::10]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCDm-0005te-Sz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCDm-00073X-3h
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCDl-00073B-U3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:42:14 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0351C4DAF8
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:42:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:40 +0400
Message-Id: <20170130133954.31353-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 27/41] char: remove unused READ_RETRIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Curiously unused since its introduction in commit 7b0bfdf52d69.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 6d0d5e722b..722c98dc33 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -87,7 +87,6 @@
=20
 #include "char-mux.h"
=20
-#define READ_RETRIES 10
 #define TCP_MAX_FDS 16
=20
 /***********************************************************/
--=20
2.11.0.295.gd7dffce1c.dirty
