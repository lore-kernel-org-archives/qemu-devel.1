Received: from eggs.gnu.org ([2001:4830:134:3::10]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9m8J-000205-7b
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9m8F-0003K1-UO
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:08:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g9m8F-0003Jo-OW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:08:39 -0400
Received: by mail-pf1-x442.google.com with SMTP id l81-v6so365488pfg.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 00:08:39 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  9 Oct 2018 00:08:33 -0700
Message-Id: <1539068913-3796-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] Rom: change Rom's 'isrom' to bool type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/core/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa0b3fc867..910f9a97a9 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -837,7 +837,7 @@ struct Rom {
     uint8_t *data;
     MemoryRegion *mr;
     AddressSpace *as;
-    int isrom;
+    bool isrom;
     char *fw_dir;
     char *fw_file;
 
-- 
2.11.0
