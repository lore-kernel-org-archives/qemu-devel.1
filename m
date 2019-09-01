Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C21BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D222190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnhKLfiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D222190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GJ1-0002fC-4n
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzy-0007s4-Vj
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzx-0006xE-DM
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzx-0006vz-6P; Sat, 31 Aug 2019 22:53:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id q21so1882172pfn.11;
 Sat, 31 Aug 2019 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=rlv8oohxREAWM9oZbuDXdhmlrfyNIrg/N66W0e06W30=;
 b=cnhKLfiy+nPCP720ry25lcqaNRQ3FvirlVKQ8bl2TLtpUmp+kDtxFfxd9T/v+PABsz
 cWVUBOTDQ19YlweD+qzTHRRmrIFqF+xDX0D2NxT4QdwwzWWMIkvmAwCuauxy+vP/r4Si
 V16W/F4lCMsbHt8z5MI4IkuHjHAY1pidacbKzf4bDmonCVmj05T9mmis+Tfw7fomgIjd
 zyunrzZ2GVPzvmtZCcjfz3vV4e6/oPqBa+qkkDXgw0AuRmz6bG1tgaUtB+IghTfqKPzZ
 r4dPGPUJxUCbdU8kuCkpsaEhpJdvIMyj5zkyvBHt8auUxwSJNFr2ZYpxeaWE/rbpgnj0
 HsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=rlv8oohxREAWM9oZbuDXdhmlrfyNIrg/N66W0e06W30=;
 b=JmqIavOOhHSY63rwk6QtJCHLQ8aTi5XRwEtVW54FMQOiRojO2lguFk/0plBG46X4t8
 a89iyF8N2Tna/claghDLHNS7RXvvgBQROOkq+KKxVvTXYg3aiowO0KE7ouVAHDC41qgG
 4zJrNqYxtko1rnwwpVOQ8IxlAdtCL/x4N3QLm7Xkrqz7nsnvlR9VxXdK3CchfQl4m/H8
 D2Zhv0UK0H6Nj9JqUC5koqqY69mUMuCPfiPVjOGsY1f+JmF+YkkrNlbYqmH6/gxpFJV1
 bStOYZOSEiDzsCt+SopFVq8xFbtPffgeYtCgwpn29SLCoRPr635lZyL7gdPIF8TF6dkA
 Ig2g==
X-Gm-Message-State: APjAAAUoatKhXWGWtBDFY/Mcl65fnpw0XRcms2kTW/MsEGe849uTn3DF
 FREx5HnglPzqP/FDQnaVJIo=
X-Google-Smtp-Source: APXvYqyBkMiC/z5cnGeEjvrtFAQlv7FiJCK2l2h2s+1NPNqaCzPJ2lX/uODxnUBSWhlzjoQIgytqVA==
X-Received: by 2002:a63:1765:: with SMTP id 37mr19669488pgx.447.1567306428406; 
 Sat, 31 Aug 2019 19:53:48 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.47
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:47 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:53:08 -0700
Message-Id: <1567306391-2682-28-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 27/30] riscv: sifive_u: Instantiate OTP
 memory with a serial number
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

This adds an OTP memory with a given serial number to the sifive_u
machine. With such support, the upstream U-Boot for sifive_fu540
boots out of the box on the sifive_u machine.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5:
- create sifive_u_otp block directly in the machine codes, instead
  of calling sifive_u_otp_create()

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 9 +++++++++
 include/hw/riscv/sifive_u.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d970037..516093e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,6 +10,7 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
+ * 4) OTP (One-Time Programmable) memory with stored serial number
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -64,10 +65,12 @@ static const struct MemmapEntry {
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
+    [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
 
+#define OTP_SERIAL          1
 #define GEM_REVISION        0x10070109
 
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
@@ -422,6 +425,9 @@ static void riscv_sifive_u_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
                           TYPE_SIFIVE_U_PRCI);
+    sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
+                          TYPE_SIFIVE_U_OTP);
+    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
@@ -498,6 +504,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
+    object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
+
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
     }
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index b41e730..7d9d901 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -22,6 +22,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/riscv/sifive_u_prci.h"
+#include "hw/riscv/sifive_u_otp.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
@@ -38,6 +39,7 @@ typedef struct SiFiveUSoCState {
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
     SiFiveUPRCIState prci;
+    SiFiveUOTPState otp;
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
@@ -59,6 +61,7 @@ enum {
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
+    SIFIVE_U_OTP,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM
 };
-- 
2.7.4


