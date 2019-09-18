Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7859F207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7859F207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcJn-0000YQ-53
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsb-0007NU-Pc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsa-0006xE-KA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:29 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsa-0006wZ-Di
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:28 -0400
Received: by mail-pf1-f173.google.com with SMTP id q7so193975pfh.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/slVi5LkPf35jqkW3jrcMeEbGR/Vs94NBRRu6ouuKKk=;
 b=POQHjcOScM4ZU44OeXIUzxUyshfXAV3TKkBPnvbtyTUqYmGvMoATySavDIcXcY4IeZ
 IEIU3jTw12ppgACfO8vm5t6yEEur8S6T9V31SV9Bfg71q+kXXtvukYNeYVfUwxazRloy
 nvSqlbttdOwrHjLd2oUmZfST7GCq5LvLWQpFctwVxwww3vhW2a0Vm93q1L7jQB57KCOq
 mRvDfvKPr2UBvIJ595+Oc6K8JeupsJCkQ+ulIVhd3fDn59ZySsDwB74pqpQp6j3MGss2
 OxBNktDpMTGF/NtG7Bemo0wRyYrl0qNpDquEwt2EzGg4Uizq58fRtgJeooolgO69qf5B
 0bvQ==
X-Gm-Message-State: APjAAAWlmLb1y/CqyC1/oiW34NGPDU941P6u7MXQIaS2RTU2bFpDvhwr
 UiRN2ODta7HVP8AYbFd/Rbe2vA==
X-Google-Smtp-Source: APXvYqxeDww68b1Woksa4lrq/D6H18nuAMHfkcgWd8O3k7XanZa+HbaCXhG238lYXiKYQepDD727Pw==
X-Received: by 2002:a62:d45a:: with SMTP id u26mr4883586pfl.137.1568820507242; 
 Wed, 18 Sep 2019 08:28:27 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id p190sm7653671pfb.160.2019.09.18.08.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:26 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:22 -0700
Message-Id: <20190918145640.17349-31-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.173
Subject: [Qemu-devel] [PULL 30/48] riscv: sifive_u: Set the minimum number
 of cpus to 2
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

It is not useful if we only have one management CPU.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
[Palmer: Set default CPUs to 2]
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 5 ++++-
 include/hw/riscv/sifive_u.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2947e06f71..feee21e42a 100644
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
@@ -433,6 +434,8 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
      * management CPU.
      */
     mc->max_cpus = 4;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+    mc->default_cpus = mc->min_cpus;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index f25bad8f13..6d227410f8 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -69,6 +69,8 @@ enum {
     SIFIVE_U_GEM_CLOCK_FREQ = 125000000
 };
 
+#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
+
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
 #define SIFIVE_U_PLIC_NUM_SOURCES 54
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
-- 
2.21.0


