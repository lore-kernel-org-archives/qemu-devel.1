Received: from eggs.gnu.org ([2001:4830:134:3::10]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYblK-0005KG-3T
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYblG-0006Pp-85
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:03:06 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:44779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYblG-0006PN-44
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:03:02 -0500
Received: by mail-qk0-x243.google.com with SMTP id v188so15225125qkh.11
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:03:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:31 -0300
Message-Id: <20180108180231.21122-8-f4bug@amsat.org>
In-Reply-To: <20180108180231.21122-1-f4bug@amsat.org>
References: <20180108180231.21122-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/7] i386/pc: use the QEMU_ALIGNED() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3fcf318a95..85d9454c71 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -93,12 +93,12 @@ struct e820_entry {
     uint64_t address;
     uint64_t length;
     uint32_t type;
-} QEMU_PACKED __attribute((__aligned__(4)));
+} QEMU_PACKED QEMU_ALIGNED(4);
 
 struct e820_table {
     uint32_t count;
     struct e820_entry entry[E820_NR_ENTRIES];
-} QEMU_PACKED __attribute((__aligned__(4)));
+} QEMU_PACKED QEMU_ALIGNED(4);
 
 static struct e820_table e820_reserve;
 static struct e820_entry *e820_table;
-- 
2.15.1
