Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75021C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8F320758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egYB1Vpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8F320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai8B-0001Od-Dq
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4u-0003Gi-Mq; Mon, 18 May 2020 11:53:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4t-00006f-A7; Mon, 18 May 2020 11:53:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id i15so12425723wrx.10;
 Mon, 18 May 2020 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MwRjIJKrjZvOQLKRDS7bp2j+HXuefv0dlJUo1+WtTjQ=;
 b=egYB1VpdfFdcLU33RJfphrswTKxeIP4BjafZIjlthVmO7DNr1l7McScI+IvtmLndG9
 WjD9LpiJcPgoH1MQBUkML5lgSFY7x3NaGka7xlkROcXaUy0M0SBcrXd5T4VzdZLNz/tc
 JPL6wSS5HtdO9ff8Wg6X7bJESUkg8Ef8SEfUZKgdpq2BBN6kuw95k/w84PQl6K2QTuQC
 IfkMkWm7skqibMMRLPYi373AjZVNZgP9ah9kIfJgJMlSEaP6vC7XibL1zckb5Buz9xo2
 NTkPmJYYngauoD6KSjjGbIr3/BaenDgDt52tGVYYC0VdUp9L+LhUZnZUisxS9bM1br6K
 NHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MwRjIJKrjZvOQLKRDS7bp2j+HXuefv0dlJUo1+WtTjQ=;
 b=OVhAN4A7VXJCGXmqnREoWY1LvSbuojT9QzZn6Y9fcxA19BnN9ziPb3lxzrVvT8iYWM
 3ae2YPRD+5wHbkI5ahZjcRIN48r52ySMCnHxJCvn2goOWyVgK42KhonVwGXqDofzOYNs
 8cMGrF3qTXJMVPFM1aW+A6UFcjucqgK+V10bD3zBtPAdOll9R61eh22h7LeYx/S3pApP
 aYYK+t7cRmoGgVNvkH47oMiwxhF8e2YmDJsTBLl3wPyax863+PKWK+tqvFua+zvdiWo4
 bha864oieXXP31hd0TYgYd6zs5mmng0J66S0A9oRGRPpq5biVZ2NAQaJ11KqWe8oY8m8
 M+jw==
X-Gm-Message-State: AOAM533rn9X8wOIXaj5rEwJkcBEwC+MzCbYSuNeBbKVKAlU/WEf44KzS
 KRR8Rwd6EsZ/BIgfYdLM/NB8pDW6Pq4=
X-Google-Smtp-Source: ABdhPJz1bQDAMP2DFoPgL6gHBe6UaVxFp/cuSu6npvqkdthflrPa4uaDYx8RUUQurNbZEJssxkBzSA==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr21050664wrt.185.1589817197210; 
 Mon, 18 May 2020 08:53:17 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 6/7] accel/kvm: Let KVM_EXIT_MMIO return error
Date: Mon, 18 May 2020 17:53:07 +0200
Message-Id: <20200518155308.15851-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Give the hypervisor a possibility to catch any error
occuring during KVM_EXIT_MMIO.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because maybe we simply want to ignore this error instead
---
 accel/kvm/kvm-all.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d06cc04079..8dbcb8fda3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2357,6 +2357,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
     do {
         MemTxAttrs attrs;
+        MemTxResult res;
 
         if (cpu->vcpu_dirty) {
             kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
@@ -2429,12 +2430,12 @@ int kvm_cpu_exec(CPUState *cpu)
         case KVM_EXIT_MMIO:
             DPRINTF("handle_mmio\n");
             /* Called outside BQL */
-            address_space_rw(&address_space_memory,
-                             run->mmio.phys_addr, attrs,
-                             run->mmio.data,
-                             run->mmio.len,
-                             run->mmio.is_write);
-            ret = 0;
+            res = address_space_rw(&address_space_memory,
+                                   run->mmio.phys_addr, attrs,
+                                   run->mmio.data,
+                                   run->mmio.len,
+                                   run->mmio.is_write);
+            ret = res == MEMTX_OK ? 0 : -1;
             break;
         case KVM_EXIT_IRQ_WINDOW_OPEN:
             DPRINTF("irq_window_open\n");
-- 
2.21.3


