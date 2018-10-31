Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHsvN-0000LO-KZ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHsvH-0003m1-LN
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:00:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHsvH-0003l9-Cp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:00:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id h2-v6so11824194wmb.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:00:47 -0700 (PDT)
References: <154098485103.7774.2165977871054805313@015909e0f939>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84c5dc6a-6507-1b72-9808-ef4a58ff26d4@redhat.com>
Date: Wed, 31 Oct 2018 17:00:43 +0100
MIME-Version: 1.0
In-Reply-To: <154098485103.7774.2165977871054805313@015909e0f939>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] hw/arm/exynos4: Add DMA support for
 SMDKC210 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, linux@roeck-us.net, edgar.iglesias@gmail.com, i.mitsyanko@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, qemu-arm@nongnu.org

On 31/10/18 12:20, no-reply@patchew.org wrote:
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-quick@centos7 SHOW_ENV=1 J=8
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>  From https://github.com/patchew-project/qemu
>   t [tag update]            patchew/20181030162517.21816-1-peter.maydell@linaro.org -> patchew/20181030162517.21816-1-peter.maydell@linaro.org
> Switched to a new branch 'test'
> 17c45854c8 arm: exynos4: Add dma support for smdkc210
> 8c077ecece hw/arm/xilinx_zynq: Use the ARRAY_SIZE macro
> 
> === OUTPUT BEGIN ===
[...]> /tmp/qemu-test/src/tests/libqtest.c:125: kill_qemu() detected 
QEMU death from signal 11 (Segmentation fault) (core dumped)

Program terminated with signal SIGSEGV, Segmentation fault.
#0  qemu_set_irq (irq=0x7070707070707070, level=1) at qemu/hw/core/irq.c:45
45	    irq->handler(irq->opaque, irq->n, level);
[Current thread is 1 (Thread 0x7f1e02629640 (LWP 5756))]

(gdb) bt
#0  0x0000556eecf2ae1a in qemu_set_irq (irq=0x7070707070707070, level=1) 
at qemu/hw/core/irq.c:45
#1  0x0000556eecf2af98 in qemu_set_irq (level=1, irq=0x556eee8256b0) at 
qemu/hw/core/irq.c:45
#2  0x0000556eecf2af98 in qemu_irq_raise (irq=0x556eee8256b0) at 
qemu/include/hw/irq.h:16
#3  0x0000556eecf2af98 in qemu_irq_invert (irq=0x556eee8256b0) at 
qemu/hw/core/irq.c:105
#4  0x0000556eecd9a7ed in exynos4210_init (system_mem=0x556eee546c00) at 
qemu/hw/arm/exynos4210.c:432
#5  0x0000556eecd87fb7 in exynos4_boards_init_common (machine=<optimized 
out>, board_type=board_type@entry=EXYNOS4_BOARD_SMDKC210) at 
qemu/hw/arm/exynos4_boards.c:155
#6  0x0000556eecd88070 in smdkc210_init (machine=<optimized out>) at 
qemu/hw/arm/exynos4_boards.c:169
#7  0x0000556eecf2df2b in machine_run_board_init 
(machine=0x556eee4c7710) at qemu/hw/core/machine.c:834
#8  0x0000556eecc7664f in main (argc=<optimized out>, argv=<optimized 
out>, envp=<optimized out>) at qemu/vl.c:4503

(gdb) fr 1
#1  0x00005566eb1dbfc7 in qemu_set_irq (level=1, irq=0x556eee8256b0) at 
qemu/hw/core/irq.c:47
47	    irq->handler(irq->opaque, irq->n, level);

(gdb) p *irq
$2 = {parent_obj = {class = 0x5566ed477c10, free = 0x7f38e31ef530 
<g_free>, Python Exception <class 'gdb.error'> There is no member named 
keys.:
properties = 0x5566ed7a7d80, ref = 1, parent = 0x0}, handler = 
0x5566eafdbcd0 <exynos4210_irq_handler>,
   opaque = 0x5566ed5bd660, n = 281}


The following patch fixes this crash, but I'm not sure this is the 
correct fix:

-- >8 --
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -213,6 +213,8 @@ void exynos4210_init_board_irqs(Exynos4210Irq *s)
  {
      uint32_t grp, bit, irq_id, n;

+    memset(s->board_irqs, 0, sizeof(s->board_irqs));
+
      for (n = 0; n < EXYNOS4210_MAX_EXT_COMBINER_IN_IRQ; n++) {
          irq_id = 0;
          if (n == EXYNOS4210_COMBINER_GET_IRQ_NUM(1, 4) ||
---
