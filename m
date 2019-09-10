Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF27ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B2E21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2E21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yJs-0000SN-2F
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwE-00089x-W5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwD-0006m2-LA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:18 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwD-0006lV-Ef
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:17 -0400
Received: by mail-wr1-f50.google.com with SMTP id l3so719332wru.7
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=6LjmDeAL87SuuDyQOaR6PZ+xifwSg2XG2OmboMVgOmA=;
 b=QSL7kIuypFYthmM4HYJtIwi4FFuOA4HPcaZMb5ItGGjTqESonqv5FyYKvr17JlRKfP
 2pgTkRhbZqWVq0Yq42vFFQIC60lGRx6SOlxAQ25onENdfEHhxfJWix+h7O1ryn5UE19A
 daHrsaSwH6KAThdfmsfFcWDDIGaFPBqDANbcTivcgGuOpjlZ9Sd/Amd5ouMvD79zc5AF
 Ac6I4jHqvhtu6rhn/w7qB+sVOYddn1SZjZIL+KlAWfQAFItZO+kNpgOS5et4ttLlETXM
 uve4yDw8lT0h6At/pQrzKJTpLkc6rXTEUZEu3bUJYOyr24DLfYWFtNMLCpR0Nd1sFYvQ
 bQlg==
X-Gm-Message-State: APjAAAVo/ehjk+nGviL+cN3FzEjzHz0HRXkyY0EWNcylVrYwFBoGVtW1
 nS8Cojbhj2hAib6m5IXs28Fk0K5lmA8LZQ==
X-Google-Smtp-Source: APXvYqwSAcKIV2uCiMe0h9HmJm5ElS3T4uW1tcvOg//FCCZ/fyK7onWOhURLE8wWf1Gj30Z/BJDGow==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr4086064wru.116.1568190316211; 
 Wed, 11 Sep 2019 01:25:16 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id v4sm31601269wrg.56.2019.09.11.01.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:15 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:56 -0700
Message-Id: <20190910190513.21160-31-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.50
Subject: [Qemu-devel] [PULL 30/47] riscv: sifive_u: Set the minimum number
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
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 4 +++-
 include/hw/riscv/sifive_u.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2947e06f71..2023b71d53 100644
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


