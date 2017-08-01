Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrV-0004J5-6u
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrU-0007Aq-4F
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrT-0007AN-Th
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:36 -0400
Received: by mail-wm0-x243.google.com with SMTP id d40so3781576wma.3
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:12 +0200
Message-Id: <1501604245-33460-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/17] char-fd: remove useless chr pointer
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

Apparently unused since it was introduced in commit
a29753f8aa79a34a324afebe340182a51a5aef11. Now, it can be trivially
accessed by CHARDEV() of self.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170720100046.4424-1-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fd.c         | 1 -
 include/chardev/char-fd.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 1584a3d..6a62a54 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -141,7 +141,6 @@ void qemu_chr_open_fd(Chardev *chr,
     qio_channel_set_name(QIO_CHANNEL(s->ioc_out), name);
     g_free(name);
     qemu_set_nonblock(fd_out);
-    s->chr = chr;
 }
 
 static void char_fd_class_init(ObjectClass *oc, void *data)
diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
index 55ae5b4..e7c2b17 100644
--- a/include/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -29,7 +29,7 @@
 
 typedef struct FDChardev {
     Chardev parent;
-    Chardev *chr;
+
     QIOChannel *ioc_in, *ioc_out;
     int max_size;
 } FDChardev;
-- 
1.8.3.1
