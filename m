Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59800C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A512072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0ujbNXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A512072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboKi-0007LR-96
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHz-0001iq-TT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:23 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHx-0006TU-Ks
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:23 -0400
Received: by mail-qk1-x741.google.com with SMTP id f189so7856412qkd.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q6fMxoKgDixMx1XBFW+F7YxZyPOAUqVrYpURuluogyg=;
 b=X0ujbNXSPVo7DCGMqSjhfqLy6GAse5zA/TKx3Ulkrfa5IGvWh8i8xK8we8rT+D5U2u
 g+S8MH5sRjctxd9LEthtBwssjJQtwNChyQ/zJBRsygHy9EVtXPI8K7ms4LulAEK7lAQQ
 3ehBR/1meWP9AEKRFRuloBsb8ydQ2XcXD4bSGzBgfUZ7CQVRfZ+IjZ1NMVs7QR4bMh5s
 Bo1a/51mpUpK06ihM4Ps/M1m2YiExoAprUEp+/Tm3E7MGzMqWWrbqZby6W6YiWuY7MU+
 SPw2OLByuZ0i6m/etP5OhK1yom6/VZoe/lt0H0OhQOsAPY6Knfkilf9bAo/490rQBdFD
 3FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q6fMxoKgDixMx1XBFW+F7YxZyPOAUqVrYpURuluogyg=;
 b=ldSufmvJpDac1DiK5FqTXfnn+u5mQ/hDEfldaV9g2nqj57mfsn1SF55mSnk6//FEP5
 PSYX1zjhA/DOyzR4Leu2hYdqjaOgjytu9jieFLYlGRWbUnF2i7FxMOVXzG5z6ni43Mvv
 3zBFQfJ3hHMbF54APkxX5ui/Z+yehrgD3X56LGjgyVgudFAvOcSyFSF6rlsUPuhN7PmX
 rMl4WAc344CMKAgkDXdl8W91vwOKXQLl9n/URrjUTF25QxA87IXpr/WuG/kIH7R+sL0z
 WPgn56EF6+rR5qirbxLzotVjn87pnjhRYSwNxBFDXvns/GMfgqC+NOnLsXVzhwJCtdhP
 nKuw==
X-Gm-Message-State: AOAM5329rhb8/gRePlSYajC0Z8TnMnxF9tU0kSQQtDKkEd1Mw/vrRbuC
 5XIsbppSW19JCrbD1Me3siy46Cp+JbMjvg==
X-Google-Smtp-Source: ABdhPJxqEnZItjmtYo9hGuXVZKoGg7+feg3C2Ih9NNad1IHjt1O0hmpsPs+CY8NZXARJ6a3UaX5t9w==
X-Received: by 2002:a37:4897:: with SMTP id v145mr10689935qka.26.1590079400310; 
 Thu, 21 May 2020 09:43:20 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:19 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/74] cpu: move run_on_cpu to cpus-common
Date: Thu, 21 May 2020 12:39:02 -0400
Message-Id: <20200521164011.638-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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
index 4db4e0026f..907ba5f0fc 100644
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
index e57e8fe669..935fff6e4e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1194,11 +1194,6 @@ void qemu_init_cpu_loop(void)
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
index d8b81db262..fe79777502 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -766,16 +766,6 @@ void qemu_cpu_kick(CPUState *cpu);
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


