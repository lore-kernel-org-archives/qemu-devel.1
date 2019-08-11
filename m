Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3999FC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02196208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/2JOvbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02196208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwj0w-0000Gc-6R
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit9-0006u6-5F
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit8-0004AI-0M
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:39 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwit7-00049s-Qg; Sun, 11 Aug 2019 04:07:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id d1so15163809pgp.4;
 Sun, 11 Aug 2019 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=s3XSOP19dlyZdHR2UrG21lR0KuQ3VaB6arS5LfITWyM=;
 b=G/2JOvbC5kxT4S2R1IERMdATVP/8VsIBjipVr0k1rBZKrfIpOyCxptt4RuaFzzJMLj
 rJMBwIxwTeR/3skbtrTJP2rKviWEcNw2VYI3Yi8zs/8lk033KBx0rYY6DFhMW8MXdcdV
 0CZpOw4Wuw0xK5GEYZj8qW8lU2r1z8WFpM5IOIkSxm+ZQRpfvOkJCul7UutQ2MhNzAGR
 W4LnU2OMmgVhE6jRCS7zD6zyti6MxI2A95YBus36qpEZdJKsLZjwjuT35JLo27JTla1+
 uqyB7R5x/9oTk0M6eNdUYDYtFoGYqWeRvjSi1cn6QMQ3V1+1HxIVJkN/yDi457fReZOc
 z8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s3XSOP19dlyZdHR2UrG21lR0KuQ3VaB6arS5LfITWyM=;
 b=jUR0KwB9nDy5tT4Xsv1vA81si21OF3qWN2ADOYFUd/hCyAwKMrIvIOvbP8Q6nyJy/P
 1IQihgashVCY7L1W0seHDKNxUekzwPo9zc2+rtCvJg87CXWJ24ITpk6wvMxhWv1q6PRx
 CmtQa/IGZS3nrooy5p1ibTNVL9fVU0ElzESGfjfX44F5W0TGEvQh7nCWP1BabdEnRWA7
 vS4xOkRoHyrXKB3EY3Zdvk0LTzXPXHXJNHD8QftOD8fpN+Eh1ILuGJu8535Ch16eL84/
 MZUVwgKGN/sqAxEBcRbQsyxjNh749Ee2/TkZP/unU0whK8N2W9dERhRiGauRIqbXB/95
 OBLQ==
X-Gm-Message-State: APjAAAXSC/oDxOeQpuvD8KYzrXstcLPG7NRxy3r6N35CUB10Wa2n1Uu0
 K8qIsyDJ80Q67zPX5GxOppUo7jUB
X-Google-Smtp-Source: APXvYqxzKK6ONycfFURgtvlMT+M765HJvzvTg2HnFcNubByRSNaQaDjYlXpqTnZI7ZTP6uhnkKFwbQ==
X-Received: by 2002:a17:90a:2486:: with SMTP id
 i6mr17774011pje.125.1565510857084; 
 Sun, 11 Aug 2019 01:07:37 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.36
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:36 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:07:00 -0700
Message-Id: <1565510821-3927-28-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 27/28] riscv: virt: Change create_fdt() to
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
it's already saved in s->fdt. Other machines (sifive_u, spike)
don't do it neither.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/virt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

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


