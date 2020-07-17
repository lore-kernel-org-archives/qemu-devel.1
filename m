Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E94C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E202070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KE5qWmqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E202070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTGn-0003dY-PX
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwTFq-00033y-Tl
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:30:35 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwTFp-0003mC-6v
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:30:34 -0400
Received: by mail-pl1-x642.google.com with SMTP id q17so5642470pls.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i02/q3AgrH9RgvbsQSvTZ7VqTpExkdZLxVeb6Qgb8Ok=;
 b=KE5qWmqpqyDA1UWBZVerBqwdeqwN2X+UkmefhSSKwcIMwm2yrTEgGsEGlWLqnsxgZa
 tlcRrPLal8E3LUzF7P0Czbzsv+S761p3RDcevLS7tz7Qz0FO35qrX/pQlCMqFJFYJzGz
 1RtOP0RvTYpOV5gwt9Q6PEkMYrl2MBLgnS5qI7PChADuWw6YuNj4LYlcQFEPtpuUhVxn
 WHol9G3CWYb6RPFaLZipbKHDrPgPF6WOEoZ4ZvVDqoFMMyq8XhhsblfCtW2WUc0mF4er
 dP2BeoCF/lQmCraLwfGPErB+JMJ3z7Nn/g1x5BZmIrh3GnZiINrGt515B803O4d0yVnS
 DlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i02/q3AgrH9RgvbsQSvTZ7VqTpExkdZLxVeb6Qgb8Ok=;
 b=FlJTY2+M3saffT1WdeNOZAU3xhNmgRq+yMcWZKZ2T+0WaIQDyvYMcE1c57MmJjE8F+
 z50pSU8jj/mZmmPtM3TqznulMf/u2i1fYfmcYpyl2K9ajZSp7TBYX1BR35JLtePs8My1
 /ZLy/ZPklNSJ5lzQCRv5WWOEdfewPA31lh30yH2gaZ9agxQnmIMISIk9UE1lRws9hPXL
 vY4zX+0TbUPoy3VzaItKV5RLUfnDYZXr+d1hC7/Oprt9acKoHErQ0hE4eJ0dnM3bfZ2Y
 RGm/IAJr5367ZDqnOq0B693J86SccrRVc0LnCAQ5hhxYnLk1uJJMHBb6ROY7P/N/Sqno
 L4iw==
X-Gm-Message-State: AOAM5308/f9iF9zvzZvBMG5i6Ngma2J0hEacNWe1udGQV2CkMptL8WkK
 08S618Z1GRJi1pTs+uL97N8U8pvMBxc=
X-Google-Smtp-Source: ABdhPJwvY3k1tgO1GgJ+PzoJA5M4dy2UJtIdgxyi2ZkHeMnG0t7xI0dHmw+W8fR/80I2Aq7OJxePRw==
X-Received: by 2002:a17:90a:784b:: with SMTP id
 y11mr11015941pjl.51.1595003430954; 
 Fri, 17 Jul 2020 09:30:30 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id f18sm7652846pgv.84.2020.07.17.09.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 09:30:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/cpu-exec: precise single-stepping after an interrupt
Date: Fri, 17 Jul 2020 09:30:29 -0700
Message-Id: <20200717163029.2737546-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, luc.michel@greensocs.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When single-stepping with a debugger attached to QEMU, and when an
interrupt is raised, the debugger misses the first instruction after
the interrupt.

Buglink: https://bugs.launchpad.net/qemu/+bug/757702
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6a3d3a3cfc..66d38f9d85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -588,7 +588,13 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else {
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
                 replay_interrupt();
-                cpu->exception_index = -1;
+                /*
+                 * After processing the interrupt, ensure an EXCP_DEBUG is
+                 * raised when single-stepping so that GDB doesn't miss the
+                 * next instruction.
+                 */
+                cpu->exception_index =
+                    (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
                 *last_tb = NULL;
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
-- 
2.25.1


