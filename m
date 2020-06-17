Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B96C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B8B21582
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AA2z7orh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B8B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfFM-0004hm-Vc
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDV-0002fG-Sa
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:29 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDO-0008Q3-Cg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:29 -0400
Received: by mail-qt1-x842.google.com with SMTP id q14so2741522qtr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QNZB54KyQChgQjAJ4p/NXb5SKwXOjBRD9J4KOgYTGDc=;
 b=AA2z7orh/m+mwEWFgQscfE4OJA8CSw68Kuhox/bKvytcSM8YZvkftQB7TO16rvo0eM
 fhWp068tIALYrvq/uUyZEaB2jQe5FUEKV3dbou1qpxpMhqcG0TEuOfBt36LWBQL+Akr6
 yAlBmE+vRbhV8EaxNBElT1idS3uGuiC20f7zX/M/KjDTEcpny+v2Y1C/W4P/pI3V214S
 XhgB94mTYZ5AwsIY4UUVo4ujR+pCw5c9PZxsahotK4zc65O7Z0wiX1V6Kl8zW06vyMlM
 QOPWkaoFLG0UhfOhk+DkHHZeLg+wtzKhb87kjDeNzvScYgXpUzj2K8zmtYJ+qjYD7DW4
 laOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QNZB54KyQChgQjAJ4p/NXb5SKwXOjBRD9J4KOgYTGDc=;
 b=HwUcYW7OjlyjdKt5qHQ8xmIN3t43/mc2DZ4l5Al8wYtwDhRubfLcemIqKUZVUUkHXB
 l05Nps5ZNWWI9imR1uoY3Vzfag8w/Vw0zpXVWveWRW5ML0VnTJqVY/qjUYj3kiYoKq5x
 4WZNNX309Lx5t8OjJF8dUkIfaBOfrH2cas4KDybbVAYLE4ngkKeUvaspqnI6/VHX+1Aj
 JVb10QS83aQiGUnX/uKqXXIwampXSRm74vBUGkgQVLZIyqJAsnpFDgRFG79Le6LAhQlU
 KVlPLnnFI0VlkzGXnmSv7hkFw1+vNNEN2wuW3oVlS2m29Ogi2NinwhsOWM6ST9qWMIdz
 t3Hw==
X-Gm-Message-State: AOAM5323gq7Vk52nsNVZb9DvEJS4bbIjZwuyv961af4+3IVwjYA1gt0W
 aEcn2uE7lTlWlxzr3jcZAK6sPyBdq2LBfA==
X-Google-Smtp-Source: ABdhPJyXJHPLpEEuCZdP7Yc8QXLwbj/JnTLMaC8xTB/kqlmZU3ZJYneco7TC6KWaL/rh+/WiZngFqg==
X-Received: by 2002:ac8:6edb:: with SMTP id f27mr1035447qtv.325.1592427801035; 
 Wed, 17 Jun 2020 14:03:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:20 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 04/73] cpu: move run_on_cpu to cpus-common
Date: Wed, 17 Jun 2020 17:01:22 -0400
Message-Id: <20200617210231.4393-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

We don't pass a pointer to qemu_global_mutex anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         |  2 +-
 cpus.c                |  5 -----
 include/hw/core/cpu.h | 10 ----------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 57d9fc6ea1..b1069193c1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -117,7 +117,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     cpu_mutex_unlock(cpu);
 }
 
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item wi;
     bool has_bql = qemu_mutex_iothread_locked();
diff --git a/cpus.c b/cpus.c
index 035f41a997..8e54916169 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1214,11 +1214,6 @@ void qemu_init_cpu_loop(void)
     qemu_thread_get_self(&io_thread);
 }
 
-void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
-{
-    do_run_on_cpu(cpu, func, data);
-}
-
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
 {
     if (kvm_destroy_vcpu(cpu) < 0) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ebff239ad3..e3f7ec06ff 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -771,16 +771,6 @@ void qemu_cpu_kick(CPUState *cpu);
  */
 bool cpu_is_stopped(CPUState *cpu);
 
-/**
- * do_run_on_cpu:
- * @cpu: The vCPU to run on.
- * @func: The function to be executed.
- * @data: Data to pass to the function.
- *
- * Used internally in the implementation of run_on_cpu.
- */
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
-
 /**
  * run_on_cpu:
  * @cpu: The vCPU to run on.
-- 
2.17.1


