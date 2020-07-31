Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0017C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9392087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMJcKRtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9392087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1UY4-0007hL-0D
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 08:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1UVo-0004x0-87
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:51:48 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:34045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1UVm-0003Z7-Gg
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:51:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id o1so17310136plk.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o9V0JUllgC3h//GHZoYXd1Im5qo2kMrDGKs9+A1PleI=;
 b=AMJcKRtEwj0sl6R0HDH8pA9Z1k5CQ2jkU1QfgeaFl6NWrFXLlZoR5hTjQ2rZdICtpk
 BIhqT0BvGKRMEKABieW3LuX7jTTMCgyOgsHs4NOyckfgyL5gimUwvEDgAciFWIgXrSnU
 NsaMOCiU7uGc15lbILz3EuSqFjSHMnBWcWvg7OMAcZeDO7hnAGg2j++UsnW30AX9ZBPX
 s5wCy/dE/PUUfHETaISR76Sd53ikhmdk//h1rhhraNqQgoAmUyR4rcNdAFa45mOQG8Lg
 iN7Df7+I0/FNVrgnqmLATjILf1SmpLfWmTYONxOVaj6MUXgPq/gUBxFKHXqEw3oJOino
 IHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o9V0JUllgC3h//GHZoYXd1Im5qo2kMrDGKs9+A1PleI=;
 b=hIg3PfANZGBnXVFL/COaEcCe5UQdCxEwrdw5Lie19f7w2rIuyMQQQq+hrDcROcitVH
 MgwoeDdoEZIAYivn7Eux4adl6HMCmEGUQZPHic/N8rvk4PsUEOWnUGUbFjrwp5+SG9zK
 TvTLtYRFKJ0piw3z73o2N6KyvlOuZV+IZb88Pd7Y1jv5TctH2hsKLYmxnQcaBH3/Pt6J
 65gAor6f5rjNxED/snhKyPgFv2ifXR0yLGYXVp+Xo7VyfrPocdXMdHzwPY2pQLpc7yWx
 xhVKuJgBFnv+BORgWGtHzZq1HcGfBXqodUy3S1LRdzyVrBt/GJhrRnFB/2hYkVV5SFEV
 Hk1g==
X-Gm-Message-State: AOAM5300EHgd1q7QAlKuG4x6u6ouuDeivlN/CuwWDMGG3P+SPq/PZOEI
 iZjFztzqMzD22w0Ui1I4lr37w2unccc=
X-Google-Smtp-Source: ABdhPJxDbNVL/mSIg/eknaoQTRREoV9yKmNQsMy5/iMMEZ4GRaX/EqIqCZ2DXwfPlWmsVusIC23ssg==
X-Received: by 2002:a17:90a:4f45:: with SMTP id
 w5mr3953129pjl.11.1596199904310; 
 Fri, 31 Jul 2020 05:51:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id v11sm9733646pgs.22.2020.07.31.05.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 05:51:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/core: Add bql_interrupt flag to CPUClass
Date: Fri, 31 Jul 2020 08:51:26 -0400
Message-Id: <20200731125127.30866-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731125127.30866-1-robert.foley@linaro.org>
References: <20200731125127.30866-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x634.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, pbonzini@redhat.com, peter.puhov@linaro.org,
 alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new flag bql_interrupt, allows the CPUClass to
determine if the BQL should be held during calls to
cpu_exec_interrupt or do_interrupt.

This is being added in preparation for changes in
cpu_handle_interrupt, which will use this flag.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/core/cpu.c         | 1 +
 include/hw/core/cpu.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 8707ce2c34..7ab88caa97 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -425,6 +425,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     k->cpu_exec_exit = cpu_common_noop;
     k->cpu_exec_interrupt = cpu_common_exec_interrupt;
     k->adjust_watchpoint_address = cpu_adjust_watchpoint_address;
+    k->bql_interrupt = true;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6a2c77682f..d2c426ee5d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -157,6 +157,8 @@ struct TranslationBlock;
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
+ * @bql_interrupt: Hold BQL while performing the cpu_exec_interrupt
+ *                 or do_interrupt call.
  *
  * Represents a CPU family or model.
  */
@@ -227,6 +229,7 @@ typedef struct CPUClass {
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
+    bool bql_interrupt;
 } CPUClass;
 
 /*
@@ -589,6 +592,11 @@ static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
     }
 }
 
+static inline void cpu_class_enable_bql_interrupt(CPUClass *cc)
+{
+    cc->bql_interrupt = true;
+}
+
 /**
  * qemu_tcg_mttcg_enabled:
  * Check whether we are running MultiThread TCG or not.
-- 
2.17.1


