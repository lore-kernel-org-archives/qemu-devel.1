Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A75C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1A92086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtiXp1RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1A92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza2e-0001sJ-AA
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxl-0004r1-OB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxk-00076e-H4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxk-00074D-Av; Mon, 19 Aug 2019 01:12:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id c81so444851pfc.11;
 Sun, 18 Aug 2019 22:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YssNIeKRkS6bwp+uvt3KsbQCmr70pzeUcMIt/0LtwME=;
 b=rtiXp1RNBjzCBWIYmC6dmw+ylbTh3/ZoshcKXF1NqnWInf7BSTTInq5+CVwMm5E8nq
 PYQqpg2YHIsEsqoJGuv8Tk7YaSMdIF1zaUqdCTz1bA8lYE59s3TNQjYGp6DlDsJgjpcF
 n7540K/Jg6beOPFphFhba8fX11piP0dhhWvSseHsod9qQM6l968h9YJuGg7OHdAKifQJ
 RaUACs8ar1MMl3X8LamzRnZ6AElU7E68zCpwTRB3EnpN760FQcnd6SeMEeIQzslZy1V4
 I2H5LS/7SBTZulhX1re34FFctg4I/ROwIRIvK/fnUJ99GMyUSr+oNyoCpcbZczNtGorT
 ghFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YssNIeKRkS6bwp+uvt3KsbQCmr70pzeUcMIt/0LtwME=;
 b=YLcJL/Vvsu6PrZpBS61Kw5rCUBlpSXtmuhUAGWupEhaEA4PlrtQXrOA7BMqNZnNDDs
 WFlv54O92Og4LPiR12Z6XfLQpoK1li1KOJmDiWc5Q2D40a83X8dH0uosjlZq9TUhLzlk
 lFTdf94ODPP3bSadfrZXWbbB/FRd4e/WY5hp5BCRlVHP0xeF7cEYQBCOqwoMLekuYQ6c
 AGIyhBBNF2qTu/L+dRHOVwYj8r5vbbH7rR02kiMg7UFP5MfY9wyjB39jiP9Sdy9PJjYV
 odboYa+ya6JqSAZ9e+agWDTtqz7hSo8/O0hI4KFO7DixVXY6qzRU/N30apZ3hfP6Qj0i
 VFpg==
X-Gm-Message-State: APjAAAUhgvKqxWzt1T2IOZS3yhoeS8KopypUtyXjMDxbNIkQCK9SQ8t8
 HoroCB7Q7alFnGi3k+rU2dTeaxpL
X-Google-Smtp-Source: APXvYqyv/rhY9UKkpVL8twvFTW0XB2uHkDCxXiMekRm5D1b70V2oWek5PNlXwfasGsWaEkuF0V5pfQ==
X-Received: by 2002:a65:6448:: with SMTP id s8mr18357673pgv.223.1566191531509; 
 Sun, 18 Aug 2019 22:12:11 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.10
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:10 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:37 -0700
Message-Id: <1566191521-7820-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 04/28] riscv: hw: Change create_fdt() to
 return void
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no need to return fdt at the end of create_fdt() because
it's already saved in s->fdt.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v4:
- change create_fdt() to return void in sifive_u.c too, after rebasing
  on Palmer's QEMU RISC-V tree

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 11 ++++-------
 hw/riscv/virt.c     | 11 ++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5fe0033..e22803b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -67,7 +67,7 @@ static const struct MemmapEntry {
 
 #define GEM_REVISION        0x10070109
 
-static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
+static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
@@ -253,14 +253,11 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
-
-    return fdt;
 }
 
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
-    void *fdt;
 
     SiFiveUState *s = g_new0(SiFiveUState, 1);
     MemoryRegion *system_memory = get_system_memory();
@@ -281,7 +278,7 @@ static void riscv_sifive_u_init(MachineState *machine)
                                 main_mem);
 
     /* create device tree */
-    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     riscv_find_and_load_firmware(machine, BIOS_FILENAME,
                                  memmap[SIFIVE_U_DRAM].base);
@@ -294,9 +291,9 @@ static void riscv_sifive_u_init(MachineState *machine)
             hwaddr end = riscv_load_initrd(machine->initrd_filename,
                                            machine->ram_size, kernel_entry,
                                            &start);
-            qemu_fdt_setprop_cell(fdt, "/chosen",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
                                   "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
     }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2f75195..6bfa721 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -112,7 +112,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename,
                            0x1800, 0, 0, 0x7);
 }
 
-static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
+static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
@@ -316,8 +316,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
     g_free(nodename);
-
-    return fdt;
 }
 
 
@@ -373,7 +371,6 @@ static void riscv_virt_board_init(MachineState *machine)
     size_t plic_hart_config_len;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
-    void *fdt;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
@@ -392,7 +389,7 @@ static void riscv_virt_board_init(MachineState *machine)
         main_mem);
 
     /* create device tree */
-    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
@@ -411,9 +408,9 @@ static void riscv_virt_board_init(MachineState *machine)
             hwaddr end = riscv_load_initrd(machine->initrd_filename,
                                            machine->ram_size, kernel_entry,
                                            &start);
-            qemu_fdt_setprop_cell(fdt, "/chosen",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
                                   "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
     }
-- 
2.7.4


