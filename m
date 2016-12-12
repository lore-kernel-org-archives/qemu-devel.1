Received: from eggs.gnu.org ([2001:4830:134:3::10]:43832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZMG-0005Et-MN
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZMF-0004W8-2l
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZME-0004Vp-St
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:46:06 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DB0E4E34E
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:46:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:43:11 +0300
Message-Id: <20161212224325.20790-41-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 40/54] char: remove unused READ_RETRIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Curiously unused since its introduction in commit 7b0bfdf52d69.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 1fdfa98954..eb9fb8d984 100644
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
2.11.0
