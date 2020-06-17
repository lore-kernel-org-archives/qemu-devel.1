Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432E1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1175B2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC/Pejzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1175B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlflP-00013p-IV
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEt-0004eO-3b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:55 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEq-0000PG-0P
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:54 -0400
Received: by mail-qk1-x742.google.com with SMTP id b27so3512081qka.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YTz6vFHmZFyC4ACE7F4vHqeFTUJV7CWjdiB6P/9KC+w=;
 b=hC/Pejzb8BghSmFgUSR+yU/UxhcdgiOuTZg5ww8qnQVSJ+j0wrUDItnixZfav82TfF
 u9kU66OoyEgjPZ2wUSfOqEsbfjJYkaDJ0dNgeGhQneC3JAAgYSs7plS52Yt19W5ddJTy
 6C2yFaWdcV9IS/gbbkfo6pmL6uhUpVpWCr7PiaaTIg1XVCOu5X2LN9WHmajL3OOhrHZQ
 e6eNPGdU1F5ipFHlNs8CflvhyLr97YoWavUT7BOHfwWtmTjjDN7p0uUCq22NqqtzmSsi
 g1CNKMY7eAld89KE83NMt0dQ9aGc/ytAjuDNkV7kAaekVPgFyRCEGH/4V418+uzQArls
 hu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YTz6vFHmZFyC4ACE7F4vHqeFTUJV7CWjdiB6P/9KC+w=;
 b=spbTNvYcbRumoO9hByYwa6TESeXORS8rPrGEFMnjDk4X9pGzdPC+hZKqSkFNHJA4HQ
 /5P6gtnwDmdTsiBgflXqBWy2TqTJZUYqi9GHx8aEvaZTdR4FBqc9S3KBPdn1pZhW6vZH
 gVm6M1TfNDMrV5lXGD8BQ4rHsG99YUI/hK6eBdLQaJnRJWyPKlqfZqMoz5gdiQi6CH45
 Ody46F9LM6D0ct+z5NV99DEtVujbI7nLdbJtDFw/Tv8zEbj7yBBQwf/G3jtNnEQKNQlo
 T0t1K3NIPqK3JeT/W8VH5c3BPmlylnFV+1dUCYH9F3uORJoLh6E3Fqt50/INvxqrgMWM
 0Gmg==
X-Gm-Message-State: AOAM533W+7x67U+ekzsYpRIZWjXLzm/pqmVsBs5A/dNp8NohdY5ysLfr
 j0hY4/C2ExFq0llYXeP/dG2PWf6ToEV1rA==
X-Google-Smtp-Source: ABdhPJzbaSCLaao3AWjR6m5aPs45KbFrOxOruYbFXhOkTsPlQrFCOCPObgXKviN3NH70Z40F28etrQ==
X-Received: by 2002:a37:5e07:: with SMTP id s7mr628501qkb.20.1592427890822;
 Wed, 17 Jun 2020 14:04:50 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 66/73] riscv: convert to cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:24 -0400
Message-Id: <20200617210231.4393-67-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3a6d202d03..d56ba65b32 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -310,6 +310,9 @@ static bool riscv_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+
+    g_assert(qemu_mutex_iothread_locked());
+
     /*
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
@@ -510,7 +513,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_reset(dc, riscv_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
+    cc->has_work_with_iothread_lock = riscv_cpu_has_work;
     cc->do_interrupt = riscv_cpu_do_interrupt;
     cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
     cc->dump_state = riscv_cpu_dump_state;
-- 
2.17.1


