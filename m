Received: from eggs.gnu.org ([2001:4830:134:3::10]:33615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r2-00059P-EG
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r1-000461-KE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:16 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r1-00045e-Dd
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:15 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so58623733wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:31 +0100
Message-Id: <1485524749-118532-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/41] char: add qemu_chr_fe_add_watch() Returns
 description
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/char.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 0a14942..b6e3618 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -258,6 +258,8 @@ void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
  * @cond the condition to poll for
  * @func the function to call when the condition happens
  * @user_data the opaque pointer to pass to @func
+ *
+ * Returns: the source tag
  */
 guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
                             GIOFunc func, void *user_data);
-- 
1.8.3.1
