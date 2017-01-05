Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBII-0007Az-8U
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIH-0002gg-Hk
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIH-0002gG-Cw
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:37 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F3C78FCF5
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:12 +0100
Message-Id: <20170105165329.17227-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/20] char: add qemu_chr_fe_add_watch()
 Returns description
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 0a149428cf..b6e361860a 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -258,6 +258,8 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
fmt, ...)
  * @cond the condition to poll for
  * @func the function to call when the condition happens
  * @user_data the opaque pointer to pass to @func
+ *
+ * Returns: the source tag
  */
 guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
                             GIOFunc func, void *user_data);
--=20
2.11.0
