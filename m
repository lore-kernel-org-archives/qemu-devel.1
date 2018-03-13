Received: from eggs.gnu.org ([2001:4830:134:3::10]:58211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiD-0005uO-At
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiC-0003Zf-Bb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:05 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiC-0003YV-3S
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:04 -0400
Received: by mail-wm0-x244.google.com with SMTP id u10so668593wmu.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:43 +0100
Message-Id: <20180313224719.4954-34-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/69] hw/isa/pc87312: Use 'unsigned int' for
 the irq value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-8-f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/pc87312.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 105c23e680..fda91fed21 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -76,9 +76,9 @@ static inline uint16_t get_parallel_iobase(PC87312State *s)
     return parallel_base[s->regs[REG_FAR] & FAR_PARALLEL_ADDR];
 }
 
-static const uint32_t parallel_irq[] = { 5, 7, 5, 0 };
+static const unsigned int parallel_irq[] = { 5, 7, 5, 0 };
 
-static inline uint32_t get_parallel_irq(PC87312State *s)
+static inline unsigned int get_parallel_irq(PC87312State *s)
 {
     int idx;
     idx = (s->regs[REG_FAR] & FAR_PARALLEL_ADDR);
@@ -110,7 +110,7 @@ static inline uint16_t get_uart_iobase(PC87312State *s, int i)
     }
 }
 
-static inline uint32_t get_uart_irq(PC87312State *s, int i)
+static inline unsigned int get_uart_irq(PC87312State *s, int i)
 {
     int idx;
     idx = (s->regs[REG_FAR] >> (2 * i + 2)) & 0x3;
-- 
2.14.3
