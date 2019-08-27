Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD3BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAFD2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdZpBD0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAFD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2d6N-0005NR-Hm
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwL-0003Ni-Hq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwJ-0003nB-Sl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwH-0003eW-S5; Tue, 27 Aug 2019 10:59:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id w11so11459917plp.5;
 Tue, 27 Aug 2019 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=XIkLolLkHu2jtT+JdqJX9hnPTa5guiQoqfo7x+mU4Yw=;
 b=QdZpBD0qOg6+gXhZpguix95v7EsDQzrDKkcOdyOJP+xh2rsqZ+26TNDbf8U4P4mvQ0
 TQoK19PqMED1mv066dvcbJpepJanmAzmcM4JZL5Qy2qOZuMuAsd9mjeBQR6RYVvhnpj6
 Z1hKSl5c9lrRSnQiMHDuGZKldSLFwkOtprGWytqEtj2eb4lFvzkZdXbOrvc+pbqlUAXz
 sLF7VvyfEET+1dn+cE1uUElJpcxNCq5ZQFrMapaj7+lW9zh95HBGvvkftoATg8dihp/s
 TqZqweEoR3k4pltUBEXQ+zbURtGsrA4zHXCRaMCDQgeqHPFOPyHTXH8jR7eECECgOKRe
 ZOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=XIkLolLkHu2jtT+JdqJX9hnPTa5guiQoqfo7x+mU4Yw=;
 b=PQMpChmVPoOsz9Q67xhoLpjbbGqCX0ZtNoMIX5YQ5AoGkB0UYaE9uBLKC8HRf8YhHA
 I6MPYOJqCDajFwlth8K0qhG/pNshrPjI/m/ytcOgVthlI2Uw1zD3MwYl8+cnXE/6c+Ce
 DqmSIlMYAU+2t+scRi7G0tXimogP5Ojxc1XSsN3Gn2kopOIlxGYD2LwJgkrag0JcDXs7
 EZwMP1UaZm/SQxTIYNw1rdOofAFBK/0uE46L0q13T0TlfO0iuh6rzIa0FxzQq6bm7NTP
 aLsBnr8kcU5E2ZhkGm9zRCKtIP0tbxhJ2KhHXJVmG1/KsNueMJU3djwRKIfUOjrVvxEI
 KYLA==
X-Gm-Message-State: APjAAAWdI1LrlvDwFZl2jUQQj7ruW/s4miJtLgD/QysSl22LlztdtXy5
 hzeI3jJVIqoUVEfNiEFMV10=
X-Google-Smtp-Source: APXvYqxpj4NoFAbmdDXXuZXzHAU07bDFTy6Rfe39g1fr+U/tNaDEbdmqdhZ2YXwzjXDnpauzunP2ZQ==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr22858949plb.231.1566917943031; 
 Tue, 27 Aug 2019 07:59:03 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.59.01
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:59:02 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:25 -0700
Message-Id: <1566917919-25381-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v6 16/30] riscv: sifive_u: Set the minimum
 number of cpus to 2
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

It is not useful if we only have one management CPU.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- use management cpu count + 1 for the min_cpus

Changes in v2:
- update the file header to indicate at least 2 harts are created

 hw/riscv/sifive_u.c         | 4 +++-
 include/hw/riscv/sifive_u.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3f58f61..67b503a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,7 +10,8 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  *
- * This board currently uses a hardcoded devicetree that indicates one hart.
+ * This board currently generates devicetree dynamically that indicates at least
+ * two harts.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -433,6 +434,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
      * management CPU.
      */
     mc->max_cpus = 4;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 4abc621..32d680c 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -68,6 +68,8 @@ enum {
     SIFIVE_U_GEM_CLOCK_FREQ = 125000000
 };
 
+#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
+
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
 #define SIFIVE_U_PLIC_NUM_SOURCES 54
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
-- 
2.7.4


