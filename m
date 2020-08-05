Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CCDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825D222CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/xsOwj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825D222CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O3X-0004U3-Gz
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyx-0004eW-Nx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyw-0006VE-0u
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id x6so9768012pgx.12
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YM01JZCOBFTkObfq+41JWuhzyHiJWJ7EohnvO1vdIJU=;
 b=E/xsOwj1out5jTDw1B6uHewMdZZssRhI0qYSGvOkDZ8q6nMosifaO3SUYGRsaBrefG
 lCS6oar456DouWXOhlB8jJwebXTQJBkXUBBT3yMi31IV4n5ivkGztic6TDWfqGKUTl5J
 dAlDI4wDLoElA1Q13fhWkuZPLGirHNQtYZtr5WQyIXDJFAs/T0fzVaQZ5E1tBjz1E//v
 cLbSnZVD5h+HDdfIPibvT7lx4V5TC18YZc3vgwxZLDCp+E9ZEHLOre+dDUhrjxPxDDyD
 ETTYsY8MPdmf7V0Kgh2qNVG73U/Heu4NEuXS+HXK0q5RG4oD5BFGQqJXDJAI9Me8IAoI
 vuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YM01JZCOBFTkObfq+41JWuhzyHiJWJ7EohnvO1vdIJU=;
 b=HKCqMhJRNBgOe9v91gCcMTZTwsUkMgraDPYZx4tYopsyh+OD+wIeNPC4T7PrlGLAZZ
 TBRG5fMM5Y1gClBpEGEdpwoC6BtSXvJdh5sVHZpVSasevyOqJmvCNdFM2Ru3MzaGFOsq
 JIY/1rfFjw9ZZfYEnRZIWVx7MIC/vuTJHueRPTdTJ/VkQGCYsGLKdpBRuoEDSIal+BiJ
 UfeQkMEus57YyUUixqhxfHeM0VMvDZuFkhN8FU2btXCg7qg7BMGeMRE6T9i/sxBsv7x9
 cOzyqX0AM4IVZ2tjManWEykUtbGmfKHtn2+IepWR4dnJggS757SbJ4n7yeAAl9v2XyoL
 wszg==
X-Gm-Message-State: AOAM531DIrA7tfrRFkVeoduLeayNzm71KNXNXagOACH0Z34qIbeSaiQH
 UFNofoRrbGu/AOu/ihdQx7kUVHA7Nvk=
X-Google-Smtp-Source: ABdhPJxjuA9Ylj1mq4sVihjlFA2l6FIIAeNxChpioXsJuOaar6eJVj1oCra0DTnrID81k0Z6xroI4A==
X-Received: by 2002:a62:647:: with SMTP id 68mr4820009pfg.45.1596651460295;
 Wed, 05 Aug 2020 11:17:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 15/21] target/riscv: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:57 -0400
Message-Id: <20200805181303.7822-16-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, robert.foley@linaro.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, cota@braap.org,
 Palmer Dabbelt <palmer@dabbelt.com>, peter.puhov@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a series of changes to remove the implied BQL
from the common code of cpu_handle_interrupt and
cpu_handle_exception.  As part of removing the implied BQL
from the common code, we are pushing the BQL holding
down into the per-arch implementation functions of
do_interrupt and cpu_exec_interrupt.

The purpose of this set of changes is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

This approach was suggested by Paolo Bonzini.
For reference, here are two key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/cpu_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..5050802e95 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -80,14 +80,17 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
+        qemu_mutex_lock_iothread();
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
         int interruptno = riscv_cpu_local_irq_pending(env);
         if (interruptno >= 0) {
             cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
             riscv_cpu_do_interrupt(cs);
+            qemu_mutex_unlock_iothread();
             return true;
         }
+        qemu_mutex_unlock_iothread();
     }
 #endif
     return false;
@@ -822,6 +825,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
  */
 void riscv_cpu_do_interrupt(CPUState *cs)
 {
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 #if !defined(CONFIG_USER_ONLY)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -982,4 +989,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
 #endif
     cs->exception_index = EXCP_NONE; /* mark handled to qemu */
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
-- 
2.17.1


