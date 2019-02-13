Received: from eggs.gnu.org ([209.51.188.92]:39556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGZ-0004Ys-7n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGY-0005oT-Dt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGY-0005o2-8M
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:11 +0100
Message-Id: <20190213161913.22107-24-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 23/25] chardev: add a note about frontend
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
Cc: peter.maydell@linaro.org

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190206174328.9736-5-marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/chardev/char-fe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index c1b7fd9a95..aa1b864ccd 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -184,6 +184,9 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
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
2.21.0.rc0.1.g036caf7885
