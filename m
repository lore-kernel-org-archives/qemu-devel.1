Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCttn-0006QK-Pt
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gCttk-0005hI-LD
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:38585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gCttk-0005aa-5J
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 18:02:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id q19-v6so10255329pll.5
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 15:02:29 -0700 (PDT)
Date: Wed, 17 Oct 2018 14:54:21 -0700
Message-Id: <20181017215422.3973-5-palmer@sifive.com>
In-Reply-To: <20181017215422.3973-1-palmer@sifive.com>
References: <20181017215422.3973-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 4/5] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.orgMichael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 005169eabcb4..6bd723dc3ad9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -385,6 +385,8 @@ static void riscv_virt_board_init(MachineState *machine)
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    g_free(plic_hart_config);
 }
 
 static void riscv_virt_board_machine_init(MachineClass *mc)
-- 
2.18.1
