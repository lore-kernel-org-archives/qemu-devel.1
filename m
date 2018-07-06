Received: from eggs.gnu.org ([2001:4830:134:3::10]:39498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTUk-0006ly-VI
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTUh-00072Z-OU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:22:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Jul 2018 13:21:54 -0300
Message-Id: <20180706162155.8432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.0 0/1] Fix the Nokia N810 tablet MMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi Peter,

This bug was previously reported here:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01824.html

Diff before/after ecd219f7abb using -append "console=ttyS1 printk.time=0"
option to boot http://people.linaro.org/~peter.maydell/n8x0-images.tgz

 mmci-omap mmci-omap.0: command timeout (CMD5)
 mmc0: host does not support reading read-only switch. assuming
write-enable.
 mmc0: new SDHC card at address 4567
-Waiting for root device /dev/mmcblk0p1...
 mmcblk0: mmc0:4567 QEMU! 1.81 GiB
  mmcblk0: p1 p2
-EXT3-fs: barriers not enabled
-EXT3-fs (mmcblk0p1): mounted filesystem with writeback data mode
-VFS: Mounted root (ext3 filesystem) readonly on device 179:1.
-kjournald starting.  Commit interval 5 seconds
-devtmpfs: mounted
-Freeing init memory: 132K
-mmci-omap mmci-omap.0: command timeout (CMD52)
-mmci-omap mmci-omap.0: command timeout (CMD52)
-mmci-omap mmci-omap.0: command timeout (CMD8)
-mmci-omap mmci-omap.0: command timeout (CMD5)
-mmci-omap mmci-omap.0: command timeout (CMD5)
-mmci-omap mmci-omap.0: command timeout (CMD5)
-mmci-omap mmci-omap.0: command timeout (CMD5)
-mmci-omap mmci-omap.0: command timeout (CMD55)
-mmci-omap mmci-omap.0: command timeout (CMD55)
-mmci-omap mmci-omap.0: command timeout (CMD55)
-mmci-omap mmci-omap.0: command timeout (CMD55)
-mmci-omap mmci-omap.0: command timeout (CMD1)
-lcd_mipid spi1.1: performing LCD ESD recovery
-lcd_mipid spi1.1: performing LCD ESD recovery
+mmci-omap mmci-omap.0: command timeout (CMD18)
+mmcblk0: retrying using single block read
+mmci-omap mmci-omap.0: command timeout (CMD17)
+Unable to handle kernel NULL pointer dereference at virtual address
00000018
+pgd = c0004000
+[00000018] *pgd=00000000
+Internal error: Oops: 5 [#1] PREEMPT
+last sysfs file:
+Modules linked in:
+CPU: 0    Tainted: G        W    (2.6.35~rc4-129.1-n8x0 #1)
+PC is at mmc_omap_dma_cb+0xb8/0x174
+LR is at omap2_dma_irq_handler+0x240/0x294
+pc : [<c0219504>]    lr : [<c003c3ac>]    psr: 20000193
+sp : c7d49db8  ip : c7c4c800  fp : 00000001
+r10: 00000060  r9 : c7c4c950  r8 : 00000001
+r7 : 0000032c  r6 : 00000007  r5 : 00000150  r4 : c7d4ba00
+r3 : 00000000  r2 : 00000007  r1 : 00000060  r0 : 00000007
+Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
+Control: 00c5387d  Table: 80004008  DAC: 00000017
+Process mmcqd (pid: 462, stack limit = 0xc7d48268)
+Stack: (0xc7d49db8 to 0xc7d4a000)
+9da0:                                                       c03baed4
00000150
+9dc0: 00000007 0000032c 00000001 c003c3ac 0000000c 00000000 c7d49e18
c0399a20
+9de0: 00000000 00000000 0000000c 00000000 c7d48000 00000001 00000001
c0081318
+9e00: c039ccc8 0000000c c0399a20 00000001 00000000 c00834c8 0000000c
00000000
+9e20: 00000001 c002906c ffffffff fa0fe000 00000001 c0029ac8 c7d5ed24
c7d5ed24
+9e40: c7d49e68 00000001 c7d57320 c7d64400 00000001 c7d5ed24 c7d49e90
c7d48000
+9e60: 00000001 00000001 00000ffe c7d49e80 c0215fa8 c0215ffc 60000013
ffffffff
+9e80: 00000001 29e8d608 c7d57320 c7d49ea4 c7d49ea4 c7d49efc 00000000
c7d49e64
+9ea0: c0210128 00000011 00000022 00000000 00000000 00000000 00000000
000000b5
+9ec0: 00000000 ffffff92 c7d49efc c7d49e90 0000000c 00000000 00000000
00000000
+9ee0: 00000000 00000000 0000049d 00000000 00000000 00000000 00000000
05f5e100
+9f00: 00000000 00000200 00000001 00000000 00000200 00000000 00000000
c7d49e90
+9f20: 00000001 c7d64800 c7eca800 c7d60980 c7d57320 c0171dc4 c7eca800
c7d60980
+9f40: c7d57320 00000000 000001b1 c01729a0 c7ec4e40 00000000 00000000
c7d48000
+9f60: c7ec4e40 00000000 c7d48000 c7ec4e40 00000000 c7d49f84 c7d57320
c0167680
+9f80: c7ec4e40 c7d48000 c7d5ed24 c7d5ed2c c7ec4e40 00000000 c7ec4fb0
00000001
+9fa0: c7d57320 c02169b8 00000000 c7c6be28 c7d49fd4 c02168c0 c7d5ed24
00000000
+9fc0: 00000000 00000000 00000000 c00692dc 00000000 00000000 c7d49fd8
c7d49fd8
+9fe0: 00000000 00000000 00000000 00000000 00000000 c002af04 00000000
00000000
+[<c0219504>] (mmc_omap_dma_cb+0xb8/0x174) from [<c003c3ac>]
(omap2_dma_irq_handler+0x240/0x294)
+[<c003c3ac>] (omap2_dma_irq_handler+0x240/0x294) from [<c0081318>]
(handle_IRQ_event+0x24/0xe4)
+[<c0081318>] (handle_IRQ_event+0x24/0xe4) from [<c00834c8>]
(handle_level_irq+0xd4/0x16c)
+[<c00834c8>] (handle_level_irq+0xd4/0x16c) from [<c002906c>]
(asm_do_IRQ+0x6c/0x8c)
+[<c002906c>] (asm_do_IRQ+0x6c/0x8c) from [<c0029ac8>] (__irq_svc+0x48/0xac)
+Exception stack(0xc7d49e38 to 0xc7d49e80)
+9e20:                                                       c7d5ed24
c7d5ed24
+9e40: c7d49e68 00000001 c7d57320 c7d64400 00000001 c7d5ed24 c7d49e90
c7d48000
+9e60: 00000001 00000001 00000ffe c7d49e80 c0215fa8 c0215ffc 60000013
ffffffff
+[<c0029ac8>] (__irq_svc+0x48/0xac) from [<c0215ffc>]
(mmc_blk_issue_rq+0x240/0x590)
+[<c0215ffc>] (mmc_blk_issue_rq+0x240/0x590) from [<c02169b8>]
(mmc_queue_thread+0xf8/0xfc)
+[<c02169b8>] (mmc_queue_thread+0xf8/0xfc) from [<c00692dc>]
(kthread+0x78/0x80)
+[<c00692dc>] (kthread+0x78/0x80) from [<c002af04>]
(kernel_thread_exit+0x0/0x8)
+Code: e59f00c0 eafffff0 e3110020 08bd81f0 (e5931018)
+---[ end trace 1b75b31a2719ed20 ]---
+Kernel panic - not syncing: Fatal exception in interrupt

Trace diff:

@@ -245,6 +247,7 @@
  16-bit register 0x000004
  16-bit register 0x000003
  16-bit register 0x000004
+sdcard_reset
  Read-only register 0x0002c8
  Read-only register 0x0002c8
  Read-only register 0x0002c8
@@ -308,10 +311,6 @@
 sdcard_response RESP#1 (normal cmd) (sz:4)
 sdcard_app_command SD           SET_BUS_WIDTH/ACMD06 arg 0x00000002
(state transfer)
 sdcard_response RESP#1 (normal cmd) (sz:4)
- Bad register 0x000034
- Bad register 0x000034
- Bad register 0x000034
- Bad register 0x000034
 sdcard_normal_command SD  READ_MULTIPLE_BLOCK/ CMD18 arg 0x00000000
(state transfer)
 sdcard_response RESP#1 (normal cmd) (sz:4)
 sdcard_read_block addr 0x0 size 0x200
@@ -325,532 +324,17 @@
 sdcard_read_block addr 0xe00 size 0x200
 sdcard_normal_command SD    STOP_TRANSMISSION/ CMD12 arg 0x00000000
(state sendingdata)
 sdcard_response RESP#1 (normal cmd) (sz:4)
+ Bad register 0x000034
+ Bad register 0x000034
+ Bad register 0x000034
+ Bad register 0x000034
 sdcard_normal_command SD          SEND_STATUS/ CMD13 arg 0x45670000
(state transfer)
 sdcard_response RESP#1 (normal cmd) (sz:4)
-sdcard_normal_command SD  READ_MULTIPLE_BLOCK/ CMD18 arg 0x00000022
(state transfer)
-sdcard_response RESP#1 (normal cmd) (sz:4)
-sdcard_read_block addr 0x4400 size 0x200
- Read-only register 0x000038
-sdcard_read_block addr 0x4600 size 0x200
-sdcard_normal_command SD    STOP_TRANSMISSION/ CMD12 arg 0x00000000
(state sendingdata)
-sdcard_response RESP#1 (normal cmd) (sz:4)
-sdcard_normal_command SD  READ_MULTIPLE_BLOCK/ CMD18 arg 0x00000020
(state transfer)
-sdcard_response RESP#1 (normal cmd) (sz:4)
-sdcard_read_block addr 0x4000 size 0x200
...

With this patch the N810 boots.

Regards,

Phil.

Philippe Mathieu-Daudé (1):
  hw/sd/omap_mmc: Split 'pseudo-reset' from 'power-on-reset'

 hw/sd/omap_mmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.18.0
