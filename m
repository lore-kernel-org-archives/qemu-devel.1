Received: from eggs.gnu.org ([2001:4830:134:3::10]:55883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCT5-0000i2-KE
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCT4-00058V-S8
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:39 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCT4-00058D-OL
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:38 -0400
Received: by mail-qt0-x243.google.com with SMTP id c15so5325930qta.3
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 21:31:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 17 Aug 2017 01:31:00 -0300
Message-Id: <20170817043102.6322-7-f4bug@amsat.org>
In-Reply-To: <20170817043102.6322-1-f4bug@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 6/8] !fixup mips: now than MIPSCPU is
 QOMified, mark it abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index f99cfbde7e..84b6f8bf68 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -219,7 +219,7 @@ static const TypeInfo mips_cpu_type_info = {
     .parent = TYPE_CPU,
     .instance_size = sizeof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
-    .abstract = false,
+    .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
 };
-- 
2.14.1
