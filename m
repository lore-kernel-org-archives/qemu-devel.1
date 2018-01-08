Received: from eggs.gnu.org ([2001:4830:134:3::10]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYblD-0005An-01
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYblC-0006Mr-D4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:59 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYblC-0006MW-8p
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:58 -0500
Received: by mail-qk0-x242.google.com with SMTP id o126so15227337qke.12
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:02:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:30 -0300
Message-Id: <20180108180231.21122-7-f4bug@amsat.org>
In-Reply-To: <20180108180231.21122-1-f4bug@amsat.org>
References: <20180108180231.21122-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 6/7] net/eepro100: reduce alignment to
 DWORD (32bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

as suggested in the comment.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/eepro100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 61d767524f..abb44710d9 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -266,7 +266,7 @@ typedef struct {
 
     /* Data in mem is always in the byte order of the controller (le).
      * It must be dword aligned to allow direct access to 32 bit values. */
-    uint8_t mem[PCI_MEM_SIZE] QEMU_ALIGNED(8);
+    uint8_t mem[PCI_MEM_SIZE] QEMU_ALIGNED(4);
 
     /* Configuration bytes. */
     uint8_t configuration[22];
-- 
2.15.1
