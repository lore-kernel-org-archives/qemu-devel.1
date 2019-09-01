Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5ADC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DBB22CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZJOoEmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DBB22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4G9U-0008UK-L9
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzo-0007hK-9J
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzm-0006be-6i
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzl-0006Z1-3D; Sat, 31 Aug 2019 22:53:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id 26so4563397pfp.9;
 Sat, 31 Aug 2019 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=UM+Y7KDLzrYTrBk4xhqiDKoDDPO9EnMtwCiqmXP8L+I=;
 b=AZJOoEmD0DE8rVsQPM+Wouwynw8xPiad1jt3NbNulX9XJ/669cQFi7GPo0VX21pxrG
 VMUA2rNlFYGMo/O2EVsu/SdeOiZzC0u99zj8gZHXwk/pOxBTPFk0FLohFH1egiHpsDH/
 EBEzhdJPwa0hLl214hNr8TpifZHe7LKKugyKfMBFrPCvIf1spv8UNLGrZTmAsVSECWEc
 kIpZ9LGpugsQPB+DSXt/Fhl93fe5ZrtkB5VIG6unremn8iLLOQihxIoWGuq/W9iQAAip
 uTAAWFdSr83L+gD+BybGN3g19lbg53+bCLk89xcZxfOiQDypa5OAt58IndPRZ4OtH8Yx
 t0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=UM+Y7KDLzrYTrBk4xhqiDKoDDPO9EnMtwCiqmXP8L+I=;
 b=owBiQewBLHNyNZXesRFiyABPpHWBywIvICjChcyMpsYZsq43lnyJ4Jk011UHPnam2w
 mSrfphQ4LnWc87izk1qP9N7Oibxnv4S3h2F5ZNRB9vMBXb4ZF4TGRdQ8gy4qpwJakfHv
 scoqMdDm10yQ30HW5LBcb1GNo/RU9BXZmcGFTkDn3a9ety3OAvR0HS88rWEFOtbymMTE
 hF8L5cR7q+gGUVsTHanvYpM++ctyeryU6TZAVMBjAXeXJwrZWvSnXyv4kAzYBl1D1IBV
 cOOqwslKzxTNO0A1i/jQ6lF4WSYWhichkzoEZwcEsKwSmqpdOR0BGJWDBLh2cxQEzWNv
 ApPQ==
X-Gm-Message-State: APjAAAVV7HWBjtPj3slau0XPwt1GE7wtnS8rSPvTvaK20WwYvuNE1Mgk
 M/AvIEwsySctrJSFgkPKzRw=
X-Google-Smtp-Source: APXvYqzL6uJ8DVN39RWoZzi89h1ABF9kYIveRrvaRboz1b+214hgzJK/9tT8u8wpVxJuZrqXeeE8bQ==
X-Received: by 2002:a65:640d:: with SMTP id a13mr19253235pgv.256.1567306416267; 
 Sat, 31 Aug 2019 19:53:36 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.35
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:57 -0700
Message-Id: <1567306391-2682-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 16/30] riscv: sifive_u: Set the minimum
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

Changes in v7: None
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


