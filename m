Received: from eggs.gnu.org ([2001:4830:134:3::10]:55843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcG-00051V-2E
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcF-00030j-Bk
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:04 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcF-00030T-7O
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:03 -0400
Received: by mail-qt0-x241.google.com with SMTP id j3so25283366qtn.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 18:23:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Apr 2018 22:22:40 -0300
Message-Id: <20180405012241.25714-4-f4bug@amsat.org>
In-Reply-To: <20180405012241.25714-1-f4bug@amsat.org>
References: <20180405012241.25714-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/4] memory: Fix memory_region 'priority'
 property sign
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Priorities can be negative, fix this limitation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index e77f9e4036..eaa5fa7f23 100644
--- a/memory.c
+++ b/memory.c
@@ -1258,7 +1258,7 @@ static void memory_region_initfn(Object *obj)
                         memory_region_get_addr,
                         NULL, /* memory_region_set_addr */
                         NULL, NULL, &error_abort);
-    object_property_add(OBJECT(mr), "priority", "uint32",
+    object_property_add(OBJECT(mr), "priority", "int32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL, &error_abort);
-- 
2.16.3
