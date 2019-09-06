Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B89C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC0720644
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSNd+mf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC0720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HN7-0007ct-Nb
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyv-0004v4-62
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyq-0004cC-Ar
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6Gyp-0004aJ-Ms; Fri, 06 Sep 2019 12:21:00 -0400
Received: by mail-pf1-x443.google.com with SMTP id b13so4813174pfo.8;
 Fri, 06 Sep 2019 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=1tve8+Ba3DM/qRQHy3eai96wpNp7DZ/JqR8WQUk82po=;
 b=GSNd+mf132cyng8jhnN6CwZ5CG8ILgdHfu+zOMZDSPwFIpzrT93bti64zWkZdMCPM7
 Mel2aW9J+HiHTlR14CQb6z3zwFgqirfXE3Ni+MsYZr1Wc4kl1EaBglKGPNDhYa+upraq
 redzywtIzuvjNzdEPIkuPYoAyeCxgNafjWV8E2SyZd7D0lV5+2yn3kPF8cA6uU4T6ef0
 I982u/CD08RaE2ExCYPTDl9dS4mxF2eohyTbMjrLd/PNIaQHZX2eILwKxOz8cSNO2KuQ
 d+uF66HjUuGcr9PNvhiQQGVvcBtZJrqh08b7WCDBtuzhw1jJV0EeUKIwHyxWNTZYjXb+
 f2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=1tve8+Ba3DM/qRQHy3eai96wpNp7DZ/JqR8WQUk82po=;
 b=Cf/6k11Fe+YKaM7rkoXOIV1Nm+W6fszRvSab6S0MGMeUZJIGOcvt/IxorRoJyBdrqI
 VZ40KIF9Tr/RtXrLhAMA6FJBT1A1ZXHWP5B6w7o/f+50nBclB7YeSUGsugQ/WrH6de0V
 bmU1+hyFBqiguW3Ukx3FCds1aInwhW1lNP6IMDH9n8AMTyvnjx2EmWtqOivu/FB/3VMd
 otF2ZJxylaXhB7ZcPp/Cq3tZdjbu/X8aOQNqpYllCpLCzFXHVNmtFCddPfKeY6QW/q2S
 xZOa83J9obPt3/xNkwnrcOjjsUhx+/bPM5cmh7FNzDWsBecjTXXqVuRJfgBzG+4cu+AS
 Hmmg==
X-Gm-Message-State: APjAAAUF++TTY8nVRz7+fgp5ApcSpuAM5vAcQBF9ek0Q4hXDJxgr5XoN
 jBK0FFf9dpIC30yUXMct/NE=
X-Google-Smtp-Source: APXvYqz4YMAr8Uw0irBveRqRFgxmcVn77ilyrrJmCHpeITxFZdWl0vV6wuMGF9PbDKjsTMMTNZi5kg==
X-Received: by 2002:a62:cdca:: with SMTP id
 o193mr11894205pfg.204.1567786857220; 
 Fri, 06 Sep 2019 09:20:57 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.56
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:18 -0700
Message-Id: <1567786819-22142-32-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 31/32] riscv: sifive_u: Remove handcrafted
 clock nodes for UART and ethernet
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

In the past we did not have a model for PRCI, hence two handcrafted
clock nodes ("/soc/ethclk" and "/soc/uartclk") were created for the
purpose of supplying hard-coded clock frequencies. But now since we
have added the PRCI support in QEMU, we don't need them any more.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- new patch to remove handcrafted clock nodes for UART and ethernet

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 24 +-----------------------
 include/hw/riscv/sifive_u.h |  3 +--
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3b61fab..507a6e2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -87,8 +87,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk";
-    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
-    uint32_t uartclk_phandle;
+    uint32_t plic_phandle, prci_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -248,17 +247,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
-    ethclk_phandle = phandle++;
-    nodename = g_strdup_printf("/soc/ethclk");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
-    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-        SIFIVE_U_GEM_CLOCK_FREQ);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
-    ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(nodename);
-
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -292,16 +280,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
-    uartclk_phandle = phandle++;
-    nodename = g_strdup_printf("/soc/uartclk");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
-    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", uartclk_phandle);
-    uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(nodename);
-
     nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 5270851..e4df298 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -77,8 +77,7 @@ enum {
 enum {
     SIFIVE_U_CLOCK_FREQ = 1000000000,
     SIFIVE_U_HFCLK_FREQ = 33333333,
-    SIFIVE_U_RTCCLK_FREQ = 1000000,
-    SIFIVE_U_GEM_CLOCK_FREQ = 125000000
+    SIFIVE_U_RTCCLK_FREQ = 1000000
 };
 
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
-- 
2.7.4


