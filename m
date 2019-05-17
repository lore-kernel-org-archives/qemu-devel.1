Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28417C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83842083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaqaipM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83842083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRf9n-0005Sf-2x
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 11:52:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hRf90-00058q-DF
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hRf8z-0008TS-II
	for qemu-devel@nongnu.org; Fri, 17 May 2019 11:51:38 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
	id 1hRf8x-0008N0-Di; Fri, 17 May 2019 11:51:35 -0400
Received: by mail-pl1-x644.google.com with SMTP id a5so3514324pls.12;
	Fri, 17 May 2019 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=3zAQYjQsDk6oUPzzs0AgM3UySNo4uual9DRtUoAO6pM=;
	b=IaqaipM9wsyddaBd0k7l+hr/riS3GbnPORDOHH05IpAgSh0lrZDDUj6Iep1GkvhJDf
	zr6cIfCpBp4M7xgKY5Jh6lNbqIbVbI4MLWLIJUWrTfV8cwzbu1APRuC5RYVr6N4gmvu0
	jnV72sjZ9UReJjAPKCcrcFR92Ml/rQn4tNTmv5fb+CseLmr4fOcJpuUmlmpDqmYGs4c3
	R62GvNWQAxKV6yJ1l0J86K322n6J4An+8vSbyb9T3kbqXNtbKhVDxWgb8RDeEXd+5Nw0
	R2gIHjIg8eccjK+2MBFL+T0cDuiWyjAkx0xPMkMaInY980TTRZsdys8sJmdk64La2QdT
	9QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=3zAQYjQsDk6oUPzzs0AgM3UySNo4uual9DRtUoAO6pM=;
	b=kWdvr8von6QSfwgP0BecR+97wHxORYdCVzHBWXpuXbOEuUy6WpFACwbvF6IdqT4Q+7
	jz/EVCWdIPFTLDYJYSNQK2Lura37pO4GLZMCjQDTTfIHMh+rNjYRLuPeQwtLT3DpOMrW
	2LUafiA9uLgZG3HaKaO1LJEMPSpQua9xkgZbl0oVS4wZYVx4W4bhCO1fiBBUVelVfNkX
	E4TagWZ0xSIQuFES/Xlo7QXgzghH1nRY6klAnV//Oj5gwOWCCAABK+O736acAhLGXtI+
	qjHJpC+onEXEyUuPr1sx8A3QkD+QuvGFYTXkbDbkKmn3G/TbKYtrHId6Z41usR22uD7t
	q3Ug==
X-Gm-Message-State: APjAAAXxWQUkrc0soR08CgPyouhFNmOPJib1r0VoPz1nT32w8aXGYn1H
	TirGfE3VB+9uPnBDu5FZN534eQqG
X-Google-Smtp-Source: APXvYqxPBxgHH9/6M15hHY4+uf1lwfsCs9teYzaMqmtCxeKz2k6oEtIetTviXRuA73Moh9/WcWDuyQ==
X-Received: by 2002:a17:902:1621:: with SMTP id
	g30mr16454605plg.326.1558108292036; 
	Fri, 17 May 2019 08:51:32 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
	[147.11.224.80]) by smtp.gmail.com with ESMTPSA id
	u123sm17564646pfu.67.2019.05.17.08.51.30
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Fri, 17 May 2019 08:51:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 17 May 2019 08:51:25 -0700
Message-Id: <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 2/2] riscv: sifive_u: Update the plic hart
 config to support multicore
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present the PLIC is instantiated to support only one hart, while
the machine allows at most 4 harts to be created. When more than 1
hart is configured, PLIC needs to instantiated to support multicore,
otherwise an SMP OS does not work.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e2120ac..a416d5d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -344,6 +344,8 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
+    char *plic_hart_config;
+    size_t plic_hart_config_len;
     int i;
     Error *err = NULL;
     NICInfo *nd = &nd_table[0];
@@ -357,9 +359,21 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
 
+    /* create PLIC hart topology configuration string */
+    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
+    plic_hart_config = g_malloc0(plic_hart_config_len);
+    for (i = 0; i < smp_cpus; i++) {
+        if (i != 0) {
+            strncat(plic_hart_config, ",", plic_hart_config_len);
+        }
+        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
+                plic_hart_config_len);
+        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
+    }
+
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-        (char *)SIFIVE_U_PLIC_HART_CONFIG,
+        plic_hart_config,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
-- 
2.7.4


