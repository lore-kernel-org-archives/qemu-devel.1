Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cn-0006ow-EC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cm-0003vd-J3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:28 +0100
Message-Id: <20180308223946.26784-8-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/25] hw/isa/pc87312: Use 'unsigned int' for
 the irq value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:PReP" <qemu-ppc@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.16.2
