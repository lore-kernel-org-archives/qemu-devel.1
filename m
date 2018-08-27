Received: from eggs.gnu.org ([2001:4830:134:3::10]:56682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPvE-0003lp-Vr
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPvE-0005v2-92
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fuPvE-0005uX-03
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A324787A82
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:23:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 00:23:20 +0200
Message-Id: <20180827222322.26009-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180827222322.26009-1-marcandre.lureau@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/9] chardev: add a note about frontend sources
 and context switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 4677a9e65a..25fe62e1cf 100644
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
2.18.0.547.g1d89318c48
