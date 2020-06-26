Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D243C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE6720706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W68PDnB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE6720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqP5-0006YO-KJ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4C-0002dD-19
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4A-0006Tr-8j
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id h15so9845550wrq.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z3WhPCSbc/ErEx8VXjma/l1Goh9ApGA8m0ZTZ011C2o=;
 b=W68PDnB8XVh76ZTvt739lPw4floRS3q6OJisncP8jyctXY8j8DFijsJZuIiTlbedwZ
 IyPr/HH6x+ndy2jJanf+Vzc1opzPW9N6bDN3STJvHyzAXkQo6IlnQk3anHLY+Bet8g4s
 FvrR6UFUE3yVwBBlZILutSXrL8uUBkZ5o6Mhe5+/5V+d+Oa3h9R5MjS+nzVysBQoxWI4
 zpS9LYnxgv2OdYBXirx3CVf3S+xArStEL+fdnDem01su/JQZzLpkfD5E4MMCIMQm8k90
 k9LKbU1wBYcm53sIYcqD2YZAZ+IW5VtIeuvzQ41U3HEisUbjZH59ukY1m31ht2m1D+h7
 +UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z3WhPCSbc/ErEx8VXjma/l1Goh9ApGA8m0ZTZ011C2o=;
 b=QlZsNAIfJ+9TJ+sEfyYG8O+ZlF2Zxgovj+/M8LJwKnvO8XgILEp3uVMXSIHBTqNnx5
 3dESgnYEp3NX5LmCcJdBOTOHBlsOurXjs358TfFUbfhL7oMguVFI89Sem4Bx6rdlnDiI
 L99mfb9qziRhzgLebH8MHq3xJbslzH5jE65pUoOgFRGZA2jX1XTVdRSeroTL3m16xbau
 gFIGHXoOdSrSyv5eNde1qug/KpukUC1eh3a/wVeAxYnP6OD1Nu/9CR36oztE/5mczbVl
 cVSjq0374BrHCu6wouLy+IJoBPGf9HHu3Rx3jqYRhNuH+pMo8J98nWP510HJLGCzQGEZ
 VOEQ==
X-Gm-Message-State: AOAM533WXmLZROOrT9i5/1QX+25UN1VosuEv3MUjgbr+hqLR7JUnm00x
 IWiA2RgMplvCgPqSwS8PUoWxpyE/lNL1yA==
X-Google-Smtp-Source: ABdhPJyCfH1h7MiNl3v11mrX2M1bI4MnFYhs6eC+lnpBwBflCA9qUclwaKOqLL8MQfZhtSL6C8YV0A==
X-Received: by 2002:adf:8067:: with SMTP id 94mr4093422wrk.427.1593184496559; 
 Fri, 26 Jun 2020 08:14:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/57] target/arm: Define arm_cpu_do_unaligned_access for
 user-only
Date: Fri, 26 Jun 2020 16:13:53 +0100
Message-Id: <20200626151424.30117-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use the same code as system mode, so that we generate the same
exception + syndrome for the unaligned access.

For the moment, if MTE is enabled so that this path is reachable,
this would generate a SIGSEGV in the user-only cpu_loop.  Decoding
the syndrome to produce the proper SIGBUS will be done later.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c        | 2 +-
 target/arm/tlb_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e44e18062cf..d9b8ec791ed 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2169,8 +2169,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->tlb_fill = arm_cpu_tlb_fill;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
-#if !defined(CONFIG_USER_ONLY)
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
+#if !defined(CONFIG_USER_ONLY)
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
     cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 7388494a554..522a6442a48 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -10,8 +10,6 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 
-#if !defined(CONFIG_USER_ONLY)
-
 static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
                                             unsigned int target_el,
                                             bool same_el, bool ea,
@@ -122,6 +120,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
+#if !defined(CONFIG_USER_ONLY)
+
 /*
  * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
-- 
2.20.1


