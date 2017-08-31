Received: from eggs.gnu.org ([2001:4830:134:3::10]:55574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXq-0000kT-E1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXm-0006aN-6E
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:30 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXm-0006aA-2D
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:26 -0400
Received: by mail-qk0-x241.google.com with SMTP id k126so3514674qkb.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:53:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:03 -0300
Message-Id: <20170831035306.29170-5-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/7] hw/mips/malta: use serial_chr_nonnull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index af678f5784..8620e9c42c 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1035,11 +1035,7 @@ void mips_malta_init(MachineState *machine)
 
     /* Make sure the first 3 serial ports are associated with a device. */
     for(i = 0; i < 3; i++) {
-        if (!serial_hds[i]) {
-            char label[32];
-            snprintf(label, sizeof(label), "serial%d", i);
-            serial_hds[i] = qemu_chr_new(label, "null");
-        }
+        serial_hds[i] = serial_chr_nonnull(serial_hds[i]);
     }
 
     /* create CPU */
-- 
2.14.1
