Received: from eggs.gnu.org ([209.51.188.92]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifeng1519@gmail.com>) id 1hHm1D-0002jB-3x
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifeng1519@gmail.com>) id 1hHm1C-0001T3-0q
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:10:43 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lifeng1519@gmail.com>)
	id 1hHm1B-0001PB-Pi
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 05:10:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so3668321pgc.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 02:10:40 -0700 (PDT)
From: Li Feng <lifeng1519@gmail.com>
Date: Sat, 20 Apr 2019 17:10:16 +0800
Message-Id: <20190420091016.213160-1-fengli@smartx.com>
Subject: [Qemu-devel] [PATCH] libvhost-user: fix bad vu_log_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: fengli@smartx.com

Mark dirty as page, the step of each call is 1.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index e08d6c7b97..2689de6d1c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -433,7 +433,7 @@ vu_log_write(VuDev *dev, uint64_t address, uint64_t length)
     page = address / VHOST_LOG_PAGE;
     while (page * VHOST_LOG_PAGE < address + length) {
         vu_log_page(dev->log_table, page);
-        page += VHOST_LOG_PAGE;
+        page += 1;
     }
 
     vu_log_kick(dev);
-- 
2.11.0
