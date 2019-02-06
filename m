Received: from eggs.gnu.org ([209.51.188.92]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grREx-0005pX-KD
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grREv-0004R9-Cv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grREu-0004M8-Vw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10C727F3F4
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 17:43:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 18:43:26 +0100
Message-Id: <20190206174328.9736-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190206174328.9736-1-marcandre.lureau@redhat.com>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/6] chardev: add a note about frontend
 sources and context switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 54f0d61d32..2211913734 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -166,6 +166,9 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
fmt, ...)
  * is active; return the #GSource's tag.  If it is disconnected,
  * or without associated Chardev, return 0.
  *
+ * Note that you are responsible to update the front-end sources if
+ * you are switching the main context with qemu_chr_fe_set_handlers().
+ *
  * Returns: the source tag
  */
 guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
--=20
2.20.1.519.g8feddda32c
